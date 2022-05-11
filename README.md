# viewmaster

<img src="https://github.com/waltno/viewmaster/blob/viewmaster.gif" width="100">


viewmaster is a method for performing unsupervised classification of single cells across datasets written for use in the R environment.

The inputs are cell_data_set objects (see http://github/trapnell-lab/monocle3)

## Easy Installation (Linux) (recommended) 

Download ArrayFire

https://arrayfire.com/binaries/

R
```

if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")

if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")


devtools::install_github("daqana/rcpparrayfire")
devtools::install_github("furlan_lab/viewmaster")

```


## Example
```
query_cds <- viewmaster(query_cds, 
                      ref_cds, 
                      ref_celldata_col="celltype", 
                      query_celldata_col=NULL, 
                      FUNC=c("naive_bayes", "neural_network", "bagging","softmax_regression", "logistic_regression", "deep_belief_nn", "perceptron"),
                      selected_genes=NULL,
                      train_frac = 0.8,
                      verbose = T)

```

## Acknowledgements

Written by Scott Furlan.
