#' Viewmaster
#' @description ip
#' @param query_cds cds to query
#' @param ref_cds reference cds
#' @return a cell_data_set object or a list of items if unfiltered data is returned (see unfiltered)
#' @importFrom Matrix colSums
#' @export


viewmaster <-function(query_cds, 
                      ref_cds, 
                      ref_celldata_col="celltype", 
                      query_celldata_col=NULL, 
                      FUNC=c("naive_bayes", "neural_network", "bagging","softmax_regression", "logistic_regression", "deep_belief_nn", "perceptron"),
                        selected_genes=NULL,
                      train_frac = 0.8,
                      tf_idf=F,
                      hidden_layers = c(500,100),
                      learning_rate = 2.0,
                      batch_size = 100,
                      max_epochs = 250,
                      max_error = 0.5,
                      lambda = 1.0,
                      iterations = 1000,
                      LSImethod=1,
                      verbose = T,
                      threshold = NULL){
  layers=F
  FUNC=match.arg(FUNC)
  common_list<-viewmaster::common_features(list(ref_cds, query_cds))

  rcds<-common_list[[1]]
  qcds<-common_list[[2]]
  
  if(is.null(selected_genes)){
    selected_common<-rownames(qcds)
  }else{
    selected_common<-selected_genes
  }
  
  # #no tf_idf
  query_mat<-monocle3::normalized_counts(rcds)
  ref_mat<-monocle3::normalized_counts(rcds[selected_common,])
  query_mat<-monocle3::normalized_counts(qcds[rownames(ref_mat),])

  data<-as.matrix(ref_mat)
  query<-as.matrix(query_mat)
  
  if(tf_idf){
    data<-as.matrix(tf_idf_transform(data, LSImethod))
    query<-as.matrix(tf_idf_transform(query, LSImethod))
  }
  labf<-as.factor(colData(ref_cds)[[ref_celldata_col]])
  labn<-as.numeric(labf)-1
  labels<-levels(labf)
  laboh<-matrix(model.matrix(~0+labf), ncol = length(labels))
  colnames(laboh)<-NULL
  rownames(data)<-NULL
  colnames(data)<-NULL

  train_idx<-sample(1:dim(data)[2], round(train_frac*dim(data)[2]))
  test_idx<-which(!1:dim(data)[2] %in% train_idx)

  # dim(t(data[train_idx,]))
  # dim(t(data[test_idx,]))
  # dim(laboh[train_idx,])
  # dim(laboh[test_idx,])
  # length(labn[train_idx])
  # length(labn[test_idx])
  # length(labels)
  # dim(query)
  
 switch(FUNC, 
        naive_bayes={FUNC = naive_bayes
          funclabel="naive_bayes_"
          output = "labels"},
        neural_network={FUNC = af_nn
          funclabel="nn_"
          layers=T
          output = "probs"},
        softmax_regression={FUNC = smr
          funclabel="smr_"
          output = "probs"},
        deep_belief_nn={FUNC = af_dbn
          funclabel="dbnn_"
          output = "probs"},
        logistic_regression={FUNC = lr
          funclabel="lr_"
          output = "probs"},
        bagging={FUNC = bagging
          funclabel="bagging_"
          output = "labels"},
        perceptron={FUNC = perceptron
          funclabel="perceptron_"
          output = "probs"},
        )
        
  if(is.null(query_celldata_col)){
    coldata_label<-paste0(funclabel, "celltype")
  }else{
    coldata_label = query_celldata_col
  }
  

  if(output=="probs"){
    args<-list(data[,train_idx], 
               data[,test_idx], 
               laboh[train_idx,], 
               laboh[test_idx,], 
               length(labels), 
               query,
               learning_rate = as.double(learning_rate),
               verbose = verbose)
    if(funclabel=="smr_"){
      args$learning_rate=learning_rate
      args$iterations = as.integer(iterations)
      args$lambda = as.integer(lambda)
      args$max_error = as.integer(max_error)
    }
    if(funclabel=="nn_"){
      args$learning_rate=learning_rate
      args$layers = c(as.integer(dim(data[,train_idx])[1]), sapply(hidden_layers, as.integer), as.integer(length(labels)))
      args$max_epochs = as.integer(max_epochs)
      args$batch_size = as.integer(batch_size)
      args$max_error = as.integer(max_error)
    }
    out<-do.call(FUNC, args)
    colnames(out)<-labels
    if(is.null(threshold)){
      colData(query_cds)[[coldata_label]]<-colnames(as.data.frame(out))[apply(as.data.frame(out),1,which.max)]
      return(query_cds)
    }else{
      if(threshold > 1 & threshold <= 0)stop("thresh must be value between 0 and 1")
      out[out<threshold]<-NA
      outd<-apply(as.data.frame(out),1,which.max)
      outv<-sapply(outd, function(out){
        if(length(out)==0){
          NA
        }else{
          names(out)
        }
      })
      colData(query_cds)[[coldata_label]]<-outv
      return(query_cds)
    }
    
  }
  if(output=="labels"){
    args<-list(data[,train_idx], 
               data[,test_idx], 
               labn[train_idx], 
               labn[test_idx], 
               length(labels), 
               query, 
               verbose = verbose)
    out<-do.call(FUNC, args)
    colData(query_cds)[[coldata_label]]<-labels[out+1]
    return(query_cds)
  }
}

#' Common Variant Genes
#' @description Find common variant genes between two cds objects
#' @param cds1 cds 
#' @param cds2 
#' @return a vector of similarly variant genes
#' @export


common_variant_genes <-function(cds1, 
                      cds2,
                      top_n=2000,
                      logmean_ul = 2, 
                      logmean_ll = -6,
                      row_data_column = "gene_short_name",
                      unique_data_column = "id",
                      verbose = T){
  cds1<-calculate_gene_dispersion(cds1)

  cds1<-select_genes(cds1, top_n = top_n, logmean_ul = logmean_ul, logmean_ll = logmean_ll)
  p<-plot_gene_dispersion(cds1)
  print(p)
  qsel<-rowData(cds1)[[row_data_column]][rowData(cds1)[[unique_data_column]] %in% get_selected_genes(cds1)]
  cds2<-calculate_gene_dispersion(cds2)
  p<-plot_gene_dispersion(cds2)
  print(p)
  cds2<-select_genes(cds2, top_n = top_n, logmean_ul = logmean_ul, logmean_ll = logmean_ll)
  p<-plot_gene_dispersion(cds2)
  print(p)
  rsel<-rowData(cds2)[[row_data_column]][rowData(cds2)[[unique_data_column]] %in% get_selected_genes(cds2)]
  selected_common<-intersect(qsel, rsel)
  selected_common
  }




#' Pseudo-singlets
#' @description ip
#' @param se Summarized Experiment
#' @param cds reference cds
#' @return a cell_data_set object or a list of items if unfiltered data is returned (see unfiltered)
#' @importFrom monocle3 new_cell_data_set
#' @importFrom Matrix rowSums
#' @export

pseudo_singlets <- function(se, 
                            sc_cds, 
                            assay_name="logcounts", 
                            logtransformed=T, 
                            selected_genes=NULL,
                            ncells_per_col=50, 
                            threads = detectCores()){
  if(!assay_name %in% names(assays(se))){stop("Assay name not found in Summarized Experiment object;  Run: 'names(assays(se))' to see available assays")}
  mat<-as.matrix(assays(se)[[assay_name]])
  if(logtransformed){
    cmat<-ceiling(exp(mat)-1)
  }else{
    cmat<-mat
  }
  if(is.null(selected_genes)){
    selected_genes<-rownames(se)
  }
  exprs_bulk<-cmat[selected_genes,]
  exprs_sc<-counts(sc_cds)[selected_genes[selected_genes %in% rownames(sc_cds)],]
  depth <- round(sum(rowSums(exprs_sc) / ncol(exprs_sc)))
  nRep <- 5
  n2 <- ceiling(ncells_per_col / nRep)
  ratios <- c(2, 1.5, 1, 0.5, 0.25) #range of ratios of number of fragments
  message(paste0("Simulating ", (ncells_per_col * dim(se)[2]), " single cells"))
  syn_mat <- pbmcapply::pbmclapply(seq_len(ncol(exprs_bulk)), function(x){
    counts <- exprs_bulk[, x]
    counts <- rep(seq_along(as.numeric(counts)), as.numeric(counts))
    simMat <- lapply(seq_len(nRep), function(y){
      ratio <- ratios[y]
      simMat <- matrix(sample(x = counts, size = ceiling(ratio * depth) * n2, replace = TRUE), ncol = n2)
      simMat <- Matrix::summary(as(simMat, "dgCMatrix"))[,-1,drop=FALSE]
      simMat[,1] <- simMat[,1] + (y - 1) * n2
      simMat
    }) %>%  Reduce("rbind", .)
    simMat <- Matrix::sparseMatrix(i = simMat[,2], j = simMat[,1], x = rep(1, nrow(simMat)), dims = c(nrow(exprs_bulk), n2 * nRep))
    colnames(simMat) <- paste0(colnames(exprs_bulk)[x], "#", seq_len(ncol(simMat)))
    rownames(simMat)<-rownames(exprs_bulk)
    simMat}, mc.cores =  threads)
  syn_mat <- Reduce("cbind", syn_mat)
  if(any(is.nan(syn_mat@x))){
    syn_mat@x[is.nan(syn_mat@x)]<-0
    warning("NaN calculated during single cell generation")
  }
  slice<-rep.int(1:nrow(colData(se)), ncells_per_col)
  slice<-slice[order(slice)]
  sim_meta_data<-colData(se)[slice,]
  rownames(sim_meta_data)<-colnames(syn_mat)
  new_cell_data_set(syn_mat, sim_meta_data, DataFrame(row.names = rownames(syn_mat), gene_short_name = rownames(syn_mat), id = rownames(syn_mat)))
}



#' Seurat to Monocle3
#' @description Conver Seurat to Monocle3
#' @param seu Seurat Object
#' @param seu_rd Reduced dimname for seurat ('i.e. UMAP')
#' @param assay_name Name of data slot ('i.e. RNA')
#' @param mon_rd Reduced dimname for monocle3 ('i.e. UMAP')
#' @import Seurat
#' @import monocle3
#' @return a cell_data_set object
#' @export


seurat_to_monocle3 <-function(seu, seu_rd="umap", mon_rd="UMAP", assay_name="RNA"){
  cds<-new_cell_data_set(seu@assays[[assay_name]]@counts, 
                         cell_metadata = seu@meta.data, 
                         gene_metadata = DataFrame(
                           row.names = rownames(seu@assays[[assay_name]]@counts), 
                           id=rownames(seu@assays[[assay_name]]@counts), 
                           gene_short_name=rownames(seu@assays[[assay_name]]@counts)))
  reducedDims(cds)[[mon_rd]]<-seu@reductions[[seu_rd]]@cell.embeddings
  cds
}

#' Monocle3 to Seurat
#' @description Convert Monocle3 cell data set to a Seurat object.  For a variety of reasons, the recommendations are to use this function
#' only to generate skeleton Seurat objects that can be used for plotting and not much else.  The resulting object will not contain PCA reductions or 
#' nearest neighbor graphs.
#' @param seu Seurat Object
#' @param seu_rd Reduced dimname for seurat ('i.e. UMAP')
#' @param assay_name Name of data slot ('i.e. RNA')
#' @param mon_rd Reduced dimname for monocle3 ('i.e. UMAP')
#' @param row.names rowData column to use as rownames for Seurat object
#' @import Seurat
#' @import monocle3
#' @return a cell_data_set object
#' @export


monocle3_to_seurat <-function(cds, seu_rd="umap", mon_rd="UMAP", assay_name="RNA", row.names="gene_short_name", normalize=T){
  warning("this function will create a Seurat object with only 1 reduced dimension; currently only UMAP is supported")
  counts <- exprs(cds)
  rownames(counts) <- rowData(cds)[[row.names]]
  seu<-CreateSeuratObject(counts, meta.data = data.frame(colData(cds)))
  keyname<-paste0(seu_rd, "_")
  colnames(reducedDims(cds)[[mon_rd]])<-paste0(keyname, 1:dim(reducedDims(cds)[[mon_rd]])[2])
  seu@reductions[[seu_rd]]<-Seurat::CreateDimReducObject(embeddings = reducedDims(cds)[[mon_rd]], key = keyname, assay = assay_name, )
  if(normalize){seu<-NormalizeData(seu)}
  seu
}


#' archr matrix to seurat object
#'
#' @param proj 
#' @param matrix 
#' @param binarize 
#' @param archr_rd 
#'
#' @return seurat object with specificed umap coordinates
#' @export
#'
#' @examples
#' seurat<-archR_to_serat(proj, "GeneScoreMatrix", binarize = F, archr_rd = "ATAC_UMAP")
#' 
#' 
archR_to_seurat = function(proj, matrix, binarize, archr_rd){
  se<-getMatrixFromProject(proj, useMatrix = matrix, binarize = binarize)
  mat<-se@assays@data@listData[[matrix]]
  feature_df<-se@elementMetadata %>% as.data.frame()
  
  if(matrix == "GeneScoreMatrix" | matrix == "GeneExpressionMatrix" | matrix ==  "MotifMatrix"){
    rn<-feature_df$name
  }
  if(matrix == "TileMatrix"){
    rn<-paste0(feature_df[,1] , "-", feature_df[,2] , "-",feature_df[,3])  
  }
  if(matrix == "PeakMatrix"){
    feature_df<-se@rowRanges %>%as.data.frame()
    rn<-paste0(feature_df[,1] , "-", feature_df[,2] , "-",feature_df[,3])  
  }
  rownames(mat)<-rn
  colnames(mat)<-colnames(se)
  meta<-se@colData %>% as.data.frame()
  rownames(meta)<-colnames(mat)
  seu<-CreateSeuratObject(mat, project = matrix, assay = matrix, meta.data = meta)
  
  keyname <- paste0(archr_rd, "_")
  umap_df<-proj@embeddings@listData[[archr_rd]]@listData[["df"]] %>% as.matrix()
  colnames(umap_df) <- paste0(keyname, 1:2)
  seu@reductions[[archr_rd]] <- Seurat::CreateDimReducObject(embeddings = umap_df, 
                                                             key = keyname, assay = matrix )
  seu
}







#' humanize
#'
#' @param seurat 
#'
#' @return seurat object with humanized genes
#' @export
#' @description This function assumes that you seurat object has mouse genes and will return a new seurat object with 'humanized' genes.
#' You will lose variable features after this, the original umap coordinates are maintained
#' @examples
#' human_seurat<-humanize(mouse_seurat)
#' 
humanize = function(seurat, seu_rd, assay){
  require("AnnotationDbi")
  require("org.Mm.eg.db")
  require("org.Hs.eg.db")
  human_mouse_genes<-viewmaster::gene_switch
  print("getting RNA matrix")
  seurat@assays$RNA@meta.features$gene_short_name = rownames(seurat)
  
  gene_df<-seurat@assays$RNA@meta.features
  dim(gene_df)
  print("convert gene_short_name to ensbl")
  gene_df$ensb = mapIds(org.Mm.eg.db,
                        keys=rownames(seurat), 
                        column="ENSEMBL",
                        keytype="SYMBOL",
                        multiVals="first")
  gene_df<-merge(gene_df, human_mouse_genes, by.x = "ensb", by.y = "mouse_ensembl_gene", all = T)
  human_gene_short = mapIds(org.Hs.eg.db,
                            keys=gene_df$human_ensembl_gene, 
                            column="SYMBOL",
                            keytype="ENSEMBL",
                            multiVals="first") %>% unlist()
  human_gene_short<-human_gene_short[!duplicated(human_gene_short)]
  
  gene_df<-gene_df[!is.na(gene_df$gene_short_name),]
  gene_df<-gene_df[!duplicated(gene_df$gene_short_name),]
  gene_df<-gene_df[!duplicated(gene_df$human_ensembl_gene),]
  
  gene_df$human_gene_symbol<-NA
  
  human_gene_short<-human_gene_short[order(match(names(human_gene_short), gene_df$human_ensembl_gene))]
  
  gene_df$human_gene_symbol[which(gene_df$human_ensembl_gene %in% names(human_gene_short))] <-human_gene_short[which(names(human_gene_short) %in% gene_df$human_ensembl_gene)]
  
  seurat@assays$RNA@meta.features<-merge(seurat@assays$RNA@meta.features, gene_df, by.x = "gene_short_name", by.y = "gene_short_name", all = T)
  
  print("subsetting RNA matrix by found human genes, you'll need to find variable features again")
  rd<-seurat@assays$RNA@meta.features  %>% dplyr::filter(!is.na(human_gene_symbol))
  mat<-seurat@assays$RNA@counts[rd$gene_short_name,]
  rownames(mat)<-rd$human_gene_symbol
  rownames(rd)<-rd$human_gene_symbol

  print("making new seurat object")
  hum<-CreateSeuratObject(mat, project = "humanized", meta.data = seurat@meta.data)
  hum@reductions[["umap"]]<-Seurat::CreateDimReducObject(embeddings = seurat@reductions[[seu_rd]]@cell.embeddings, key = paste0(seu_rd, "_"), assay = assay, )
  
  hum
}

#' archR_to_seurat
#'
#' @param proj 
#' @param matrix 
#' @param binarize 
#' @param archr_rd 
#'
#' @return
#' @export
#'
#' @examples
archR_to_seurat = function(proj, matrix, binarize, archr_rd){
  se<-getMatrixFromProject(proj, useMatrix = matrix, binarize = binarize)
  mat<-se@assays@data@listData[[matrix]]
  feature_df<-se@elementMetadata %>% as.data.frame()
  
  if(matrix == "GeneScoreMatrix" | matrix == "GeneExpressionMatrix" | matrix ==  "MotifMatrix"){
    rn<-feature_df$name
  }
  if(matrix == "TileMatrix"){
    rn<-paste0(feature_df[,1] , "-", feature_df[,2] , "-",feature_df[,3])  
  }
  if(matrix == "PeakMatrix"){
    feature_df<-se@rowRanges %>%as.data.frame()
    rn<-paste0(feature_df[,1] , "-", feature_df[,2] , "-",feature_df[,3])  
  }
  rownames(mat)<-rn
  colnames(mat)<-colnames(se)
  meta<-se@colData %>% as.data.frame()
  rownames(meta)<-colnames(mat)
  seu<-CreateSeuratObject(mat, project = matrix, assay = matrix, meta.data = meta)
  
  keyname <- paste0(archr_rd, "_")
  umap_df<-proj@embeddings@listData[[archr_rd]]@listData[["df"]] %>% as.matrix()
  colnames(umap_df) <- paste0(keyname, 1:2)
  seu@reductions[[archr_rd]] <- Seurat::CreateDimReducObject(embeddings = umap_df, 
                                                             key = keyname, assay = matrix )
  seu
}



#' Franken
#' @description Will prepare monocle3 objects for use across species
#' @param cds cell_data_set
#' @param rowdata_col rowData column to lookup 
#' @param from_species currently only mouse ("mm") and human ("hs") symbols supported
#' @import monocle3
#' @return a cell_data_set object
#' @export

franken<-function(cds, rowdata_col="gene_short_name", from_species="mm", to_species="hs", trim=T){
  message("Currently only human and mgi symbols supported")
  message("This function is buggy as it depends on biomart and ensembl, use humanize() for a quicker conversion")
  if(from_species==to_species){return(cds)}
  labels<-data.frame(mm=c(dataset="mmusculus_gene_ensembl", prefix="mgi"), hs=c(dataset="hsapiens_gene_ensembl", prefix="hgnc"))
  from_X<-rowData(cds)[[rowdata_col]]
  from_dataset=labels[,from_species][1]
  to_dataset=labels[,to_species][1]
  from_type = paste0(labels[,from_species][2], "_symbol")
  to_type = paste0(labels[,to_species][2], "_symbol")
  from_labelout<-paste0(toupper(labels[,from_species][2]), ".symbol")
  to_labelout<-paste0(toupper(labels[,to_species][2]), ".symbol")
  franken_table<-franken_helper(from_X, from_dataset, to_dataset, from_type, to_type)
  new_column_name<-paste0("franken_", from_species, "_to_", to_species)
  rowData(cds)[[new_column_name]]<-franken_table[[to_labelout]][match(from_X, franken_table[[from_labelout]])]
  rowData(cds)[[new_column_name]][is.na(rowData(cds)[[new_column_name]])]<-"Unknown"
  if(trim){
    cds<-cds[!rowData(cds)[[new_column_name]] %in% "Unknown",]
  }
  rownames(cds)<-rowData(cds)[[new_column_name]]
  rowData(cds)[[rowdata_col]]<-rowData(cds)[[new_column_name]]
  cds
}


#' franken_helper
#'
#' @param x 
#' @param from_dataset 
#' @param to_dataset 
#' @param from_type 
#' @param to_type 
#'
#' @return
#' @export
#'
#' @examples
franken_helper <- function(x, from_dataset="mmusculus_gene_ensembl", to_dataset="hsapiens_gene_ensembl", from_type="mgi_symbol", to_type="hgnc_symbol"){
  from_mart = useMart("ensembl", dataset = from_dataset)
  to_mart = useMart("ensembl", dataset = to_dataset)
  genesV2 = getLDS(attributes = c(from_type), filters = from_type, values = x , mart = from_mart, attributesL = c(to_type), martL = to_mart, uniqueRows=F)
  return(genesV2)
}

#' getPopulationOffset
#'
#' @param y 
#'
#' @return
#' @export
#'
#' @examples
getPopulationOffset = function(y){
  if(!is.factor(y))
    y=factor(y)
  if(length(levels(y))!=2)
    stop("y must be a two-level factor")
  off = sum(y==levels(y)[2])/length(y)
  off = log(off/(1-off))
  return(rep(off,length(y)))
}

#' multinomialFitCV
#'
#' @param x 
#' @param y 
#' @param nParallel 
#' @param ... 
#'
#' @return
#' @export
#'
#' @examples
multinomialFitCV = function(x,y,nParallel=detectCores(),...){
  fits = list()
  if(nParallel>1)
    registerDoMC(cores=nParallel)
  #Do them in order of size
  marks = names(sort(table(as.character(y))))
  for(mark in marks){
    message(sprintf("Fitting model for variable %s",mark))
    fac = factor(y==mark)
    #The two main modes of failure are too few positives and errors constructing lambda.  These should be handled semi-gracefully
    fits[[mark]] = tryCatch(
      cv.glmnet(x,fac,offset=getPopulationOffset(fac),family='binomial',intercept=FALSE,alpha=0.99,nfolds=10,type.measure='class',parallel=T,...),
      error = function(e) {
        tryCatch(
          cv.glmnet(x,fac,offset=getPopulationOffset(fac),family='binomial',intercept=FALSE,alpha=0.99,nfolds=10,type.measure='class',parallel=nParallel>1,lambda=exp(seq(-10,-3,length.out=100)),...),
          error = function(e) {
            warning(sprintf("Could not fit model for variable %s",mark))
            return(NULL)
          })
      })
  }
  return(fits)
}






#' Load Training Data
#'
#' @param seurat 
#'
#' @return
#' @export

loadTrainingData <-function(seurat){
  metadata = seurat@meta.data
  ttoc = seurat@assays$RNA@counts
  return(list(toc=ttoc,mDat=metadata))
}


#' Single Cell Logistic Regression Matrix
#'
#' @param trainDat training seurat object, assumes the negative control is in it already
#' @param testDat  testing seurat object
#' @param trainClass metadata column to learn
#' @param testClass metadata column to test
#' @param downsample number of randomly downsampled cells per metadata column in trainDat
#'
#' @return
#' @export
#'

log_reg_matrix<-function(trainDat, testDat, trainClass, testClass, downsample = 200){
  #prepare test data
  
  Idents(testDat)<-toString(testClass)
  DefaultAssay(testDat)<-"RNA"
  testDat = loadTrainingData(testDat)
  
  #prepare train data
  #assumes control sample is already in object
  Idents(trainDat)<-toString(trainClass)
  DefaultAssay(trainDat)<-"RNA"
  trainDat = loadTrainingData(subset(trainDat, downsample = downsample))
  trainDat$mDat$Trainer = trainDat$mDat[[trainClass]]
  
  rtoc<-c(rownames(testDat$toc), rownames(trainDat$toc))
  
  #Genes to always exclude (human only now)
  hkGeneREGEX='^(EIF[0-9]|RPL[0-9]|RPS[0-9]|RPN1|POLR[0-9]|SNX[0-9]|HSP[AB][0-9]|H1FX|H2AF[VXYZ]|PRKA|NDUF[ABCSV]|ATP[0-9]|PSM[ABCDEFG][0-9]|UBA[0-9]|UBE[0-9]|USP[0-9]|TXN)'
  coreExcludeGenes = unique(c(grep('\\.[0-9]+_',rtoc,value=TRUE), #Poorly characterised
                              grep('MALAT1',rtoc,value=TRUE), #Contamination
                              grep('^HB[BGMQDAZE][12]?_',rtoc,value=TRUE), #Contamination
                              grep('^MT-',rtoc,value=TRUE), #Mitochondria
                              grep(hkGeneREGEX,rtoc,value=TRUE) #Housekeeping genes
  ))
  
  cells = c(rownames(trainDat$mDat))
  
  cl<-trainDat$mDat[[trainClass]]
  names(cl)<-rownames(trainDat$mDat)
  
  classes = c(cl)
  #Any genes to exclude go here
  excludeGenes=coreExcludeGenes
  #Any genes that we wish to give extra weight should go here
  includeGenes=c()
  #Get and normalise the data
  genes<-intersect(x = rownames(testDat$toc), y=rownames(trainDat$toc))
  trainDat$toc<-trainDat$toc[genes,]
  testDat$toc<-testDat$toc[genes,]
  
  dat<-cbind(trainDat$toc)
  
  dat = Seurat::LogNormalize(dat)
  dat = dat[(Matrix::rowSums(dat>0)>3 & !(rownames(dat)%in%excludeGenes)),]
  dat = t(dat)
  dim(dat)
  fits= multinomialFitCV(dat,classes,nParallel=detectCores())
  
  dat = Seurat::LogNormalize(testDat$toc)
  dat = t(dat)
  #Load the trained models
  preds = list()
  for(mark in names(fits)){
    message(sprintf("Predicting probabilities for cluster %s",mark))
    preds[[mark]] = predict(fits[[mark]],newx=dat[,rownames(fits[[mark]]$glmnet.fit$beta)],s='lambda.1se',newoffset=rep(0,nrow(dat)))
    #Make a plot of the logits in the new space
    testDat$mDat$logits[match(rownames(preds[[mark]]),rownames(testDat$mDat))] = preds[[mark]][,1]
    #Truncate logits at +/- 5
    m = abs(testDat$mDat$logits)>5
    testDat$mDat$logits[m]=5*sign(testDat$mDat$logits)[m]
  }
  #Now make a matrix
  pp = do.call(cbind,preds) 
  colnames(pp) = names(preds)
  return(pp)
}

