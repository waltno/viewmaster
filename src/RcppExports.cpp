// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArrayFire.h>
#include <Rcpp.h>

using namespace Rcpp;

// bagging_demo
void bagging_demo(int perc, bool verbose);
RcppExport SEXP _viewmaster_bagging_demo(SEXP percSEXP, SEXP verboseSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type perc(percSEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    bagging_demo(perc, verbose);
    return R_NilValue;
END_RCPP
}
// bagging
af::array bagging(RcppArrayFire::typed_array<f32> train_feats, RcppArrayFire::typed_array<f32> test_feats, RcppArrayFire::typed_array<s32> train_labels, RcppArrayFire::typed_array<s32> test_labels, int num_classes, RcppArrayFire::typed_array<f32> query, bool verbose, bool benchmark, int num_models, int sample_size, int device);
RcppExport SEXP _viewmaster_bagging(SEXP train_featsSEXP, SEXP test_featsSEXP, SEXP train_labelsSEXP, SEXP test_labelsSEXP, SEXP num_classesSEXP, SEXP querySEXP, SEXP verboseSEXP, SEXP benchmarkSEXP, SEXP num_modelsSEXP, SEXP sample_sizeSEXP, SEXP deviceSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type train_feats(train_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type test_feats(test_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type train_labels(train_labelsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type test_labels(test_labelsSEXP);
    Rcpp::traits::input_parameter< int >::type num_classes(num_classesSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type query(querySEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    Rcpp::traits::input_parameter< bool >::type benchmark(benchmarkSEXP);
    Rcpp::traits::input_parameter< int >::type num_models(num_modelsSEXP);
    Rcpp::traits::input_parameter< int >::type sample_size(sample_sizeSEXP);
    Rcpp::traits::input_parameter< int >::type device(deviceSEXP);
    rcpp_result_gen = Rcpp::wrap(bagging(train_feats, test_feats, train_labels, test_labels, num_classes, query, verbose, benchmark, num_models, sample_size, device));
    return rcpp_result_gen;
END_RCPP
}
// af_dbn
af::array af_dbn(RcppArrayFire::typed_array<f32> train_feats, RcppArrayFire::typed_array<f32> test_feats, RcppArrayFire::typed_array<s32> train_target, RcppArrayFire::typed_array<s32> test_target, int num_classes, RcppArrayFire::typed_array<f32> query_feats, int device, std::string dts, float rbm_learning_rate, float nn_learning_rate, int rbm_epochs, int nn_epochs, int batch_size, float max_error, bool verbose, bool benchmark);
RcppExport SEXP _viewmaster_af_dbn(SEXP train_featsSEXP, SEXP test_featsSEXP, SEXP train_targetSEXP, SEXP test_targetSEXP, SEXP num_classesSEXP, SEXP query_featsSEXP, SEXP deviceSEXP, SEXP dtsSEXP, SEXP rbm_learning_rateSEXP, SEXP nn_learning_rateSEXP, SEXP rbm_epochsSEXP, SEXP nn_epochsSEXP, SEXP batch_sizeSEXP, SEXP max_errorSEXP, SEXP verboseSEXP, SEXP benchmarkSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type train_feats(train_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type test_feats(test_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type train_target(train_targetSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type test_target(test_targetSEXP);
    Rcpp::traits::input_parameter< int >::type num_classes(num_classesSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type query_feats(query_featsSEXP);
    Rcpp::traits::input_parameter< int >::type device(deviceSEXP);
    Rcpp::traits::input_parameter< std::string >::type dts(dtsSEXP);
    Rcpp::traits::input_parameter< float >::type rbm_learning_rate(rbm_learning_rateSEXP);
    Rcpp::traits::input_parameter< float >::type nn_learning_rate(nn_learning_rateSEXP);
    Rcpp::traits::input_parameter< int >::type rbm_epochs(rbm_epochsSEXP);
    Rcpp::traits::input_parameter< int >::type nn_epochs(nn_epochsSEXP);
    Rcpp::traits::input_parameter< int >::type batch_size(batch_sizeSEXP);
    Rcpp::traits::input_parameter< float >::type max_error(max_errorSEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    Rcpp::traits::input_parameter< bool >::type benchmark(benchmarkSEXP);
    rcpp_result_gen = Rcpp::wrap(af_dbn(train_feats, test_feats, train_target, test_target, num_classes, query_feats, device, dts, rbm_learning_rate, nn_learning_rate, rbm_epochs, nn_epochs, batch_size, max_error, verbose, benchmark));
    return rcpp_result_gen;
END_RCPP
}
// dbn_demo
int dbn_demo(int device, int perc, std::string dts);
RcppExport SEXP _viewmaster_dbn_demo(SEXP deviceSEXP, SEXP percSEXP, SEXP dtsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type device(deviceSEXP);
    Rcpp::traits::input_parameter< int >::type perc(percSEXP);
    Rcpp::traits::input_parameter< std::string >::type dts(dtsSEXP);
    rcpp_result_gen = Rcpp::wrap(dbn_demo(device, perc, dts));
    return rcpp_result_gen;
END_RCPP
}
// lr
af::array lr(RcppArrayFire::typed_array<f32> train_feats, RcppArrayFire::typed_array<f32> test_feats, RcppArrayFire::typed_array<s32> train_targets, RcppArrayFire::typed_array<s32> test_targets, int num_classes, RcppArrayFire::typed_array<f32> query, float learning_rate, bool verbose, bool benchmark, int device);
RcppExport SEXP _viewmaster_lr(SEXP train_featsSEXP, SEXP test_featsSEXP, SEXP train_targetsSEXP, SEXP test_targetsSEXP, SEXP num_classesSEXP, SEXP querySEXP, SEXP learning_rateSEXP, SEXP verboseSEXP, SEXP benchmarkSEXP, SEXP deviceSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type train_feats(train_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type test_feats(test_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type train_targets(train_targetsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type test_targets(test_targetsSEXP);
    Rcpp::traits::input_parameter< int >::type num_classes(num_classesSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type query(querySEXP);
    Rcpp::traits::input_parameter< float >::type learning_rate(learning_rateSEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    Rcpp::traits::input_parameter< bool >::type benchmark(benchmarkSEXP);
    Rcpp::traits::input_parameter< int >::type device(deviceSEXP);
    rcpp_result_gen = Rcpp::wrap(lr(train_feats, test_feats, train_targets, test_targets, num_classes, query, learning_rate, verbose, benchmark, device));
    return rcpp_result_gen;
END_RCPP
}
// lr_demo
void lr_demo(int perc, bool verbose);
RcppExport SEXP _viewmaster_lr_demo(SEXP percSEXP, SEXP verboseSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type perc(percSEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    lr_demo(perc, verbose);
    return R_NilValue;
END_RCPP
}
// naive_bayes
af::array naive_bayes(RcppArrayFire::typed_array<f32> train_feats, RcppArrayFire::typed_array<f32> test_feats, RcppArrayFire::typed_array<s32> train_labels, RcppArrayFire::typed_array<s32> test_labels, int num_classes, RcppArrayFire::typed_array<f32> query, bool verbose, bool benchmark, int device);
RcppExport SEXP _viewmaster_naive_bayes(SEXP train_featsSEXP, SEXP test_featsSEXP, SEXP train_labelsSEXP, SEXP test_labelsSEXP, SEXP num_classesSEXP, SEXP querySEXP, SEXP verboseSEXP, SEXP benchmarkSEXP, SEXP deviceSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type train_feats(train_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type test_feats(test_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type train_labels(train_labelsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type test_labels(test_labelsSEXP);
    Rcpp::traits::input_parameter< int >::type num_classes(num_classesSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type query(querySEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    Rcpp::traits::input_parameter< bool >::type benchmark(benchmarkSEXP);
    Rcpp::traits::input_parameter< int >::type device(deviceSEXP);
    rcpp_result_gen = Rcpp::wrap(naive_bayes(train_feats, test_feats, train_labels, test_labels, num_classes, query, verbose, benchmark, device));
    return rcpp_result_gen;
END_RCPP
}
// naive_bayes_demo
void naive_bayes_demo(int perc, bool verbose);
RcppExport SEXP _viewmaster_naive_bayes_demo(SEXP percSEXP, SEXP verboseSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type perc(percSEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    naive_bayes_demo(perc, verbose);
    return R_NilValue;
END_RCPP
}
// test_backends
int test_backends();
RcppExport SEXP _viewmaster_test_backends() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(test_backends());
    return rcpp_result_gen;
END_RCPP
}
// af_nn
af::array af_nn(RcppArrayFire::typed_array<f32> train_feats, RcppArrayFire::typed_array<f32> test_feats, RcppArrayFire::typed_array<s32> train_target, RcppArrayFire::typed_array<s32> test_target, int num_classes, std::vector<int> layers, RcppArrayFire::typed_array<f32> query_feats, int device, std::string dts, float learning_rate, int max_epochs, int batch_size, float max_error, bool verbose, bool benchmark);
RcppExport SEXP _viewmaster_af_nn(SEXP train_featsSEXP, SEXP test_featsSEXP, SEXP train_targetSEXP, SEXP test_targetSEXP, SEXP num_classesSEXP, SEXP layersSEXP, SEXP query_featsSEXP, SEXP deviceSEXP, SEXP dtsSEXP, SEXP learning_rateSEXP, SEXP max_epochsSEXP, SEXP batch_sizeSEXP, SEXP max_errorSEXP, SEXP verboseSEXP, SEXP benchmarkSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type train_feats(train_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type test_feats(test_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type train_target(train_targetSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type test_target(test_targetSEXP);
    Rcpp::traits::input_parameter< int >::type num_classes(num_classesSEXP);
    Rcpp::traits::input_parameter< std::vector<int> >::type layers(layersSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type query_feats(query_featsSEXP);
    Rcpp::traits::input_parameter< int >::type device(deviceSEXP);
    Rcpp::traits::input_parameter< std::string >::type dts(dtsSEXP);
    Rcpp::traits::input_parameter< float >::type learning_rate(learning_rateSEXP);
    Rcpp::traits::input_parameter< int >::type max_epochs(max_epochsSEXP);
    Rcpp::traits::input_parameter< int >::type batch_size(batch_sizeSEXP);
    Rcpp::traits::input_parameter< float >::type max_error(max_errorSEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    Rcpp::traits::input_parameter< bool >::type benchmark(benchmarkSEXP);
    rcpp_result_gen = Rcpp::wrap(af_nn(train_feats, test_feats, train_target, test_target, num_classes, layers, query_feats, device, dts, learning_rate, max_epochs, batch_size, max_error, verbose, benchmark));
    return rcpp_result_gen;
END_RCPP
}
// ann_demo
int ann_demo(int device, int perc, std::string dts, bool verbose, bool benchmark);
RcppExport SEXP _viewmaster_ann_demo(SEXP deviceSEXP, SEXP percSEXP, SEXP dtsSEXP, SEXP verboseSEXP, SEXP benchmarkSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type device(deviceSEXP);
    Rcpp::traits::input_parameter< int >::type perc(percSEXP);
    Rcpp::traits::input_parameter< std::string >::type dts(dtsSEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    Rcpp::traits::input_parameter< bool >::type benchmark(benchmarkSEXP);
    rcpp_result_gen = Rcpp::wrap(ann_demo(device, perc, dts, verbose, benchmark));
    return rcpp_result_gen;
END_RCPP
}
// perceptron
af::array perceptron(RcppArrayFire::typed_array<f32> train_feats, RcppArrayFire::typed_array<f32> test_feats, RcppArrayFire::typed_array<s32> train_targets, RcppArrayFire::typed_array<s32> test_targets, int num_classes, RcppArrayFire::typed_array<f32> query, bool verbose, int device);
RcppExport SEXP _viewmaster_perceptron(SEXP train_featsSEXP, SEXP test_featsSEXP, SEXP train_targetsSEXP, SEXP test_targetsSEXP, SEXP num_classesSEXP, SEXP querySEXP, SEXP verboseSEXP, SEXP deviceSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type train_feats(train_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type test_feats(test_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type train_targets(train_targetsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type test_targets(test_targetsSEXP);
    Rcpp::traits::input_parameter< int >::type num_classes(num_classesSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type query(querySEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    Rcpp::traits::input_parameter< int >::type device(deviceSEXP);
    rcpp_result_gen = Rcpp::wrap(perceptron(train_feats, test_feats, train_targets, test_targets, num_classes, query, verbose, device));
    return rcpp_result_gen;
END_RCPP
}
// perceptron_demo
void perceptron_demo(int device, int perc, bool verbose);
RcppExport SEXP _viewmaster_perceptron_demo(SEXP deviceSEXP, SEXP percSEXP, SEXP verboseSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type device(deviceSEXP);
    Rcpp::traits::input_parameter< int >::type perc(percSEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    perceptron_demo(device, perc, verbose);
    return R_NilValue;
END_RCPP
}
// smr
af::array smr(RcppArrayFire::typed_array<f32> train_feats, RcppArrayFire::typed_array<f32> test_feats, RcppArrayFire::typed_array<s32> train_targets, RcppArrayFire::typed_array<s32> test_targets, int num_classes, RcppArrayFire::typed_array<f32> query, bool verbose, bool benchmark, int device);
RcppExport SEXP _viewmaster_smr(SEXP train_featsSEXP, SEXP test_featsSEXP, SEXP train_targetsSEXP, SEXP test_targetsSEXP, SEXP num_classesSEXP, SEXP querySEXP, SEXP verboseSEXP, SEXP benchmarkSEXP, SEXP deviceSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type train_feats(train_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type test_feats(test_featsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type train_targets(train_targetsSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<s32> >::type test_targets(test_targetsSEXP);
    Rcpp::traits::input_parameter< int >::type num_classes(num_classesSEXP);
    Rcpp::traits::input_parameter< RcppArrayFire::typed_array<f32> >::type query(querySEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    Rcpp::traits::input_parameter< bool >::type benchmark(benchmarkSEXP);
    Rcpp::traits::input_parameter< int >::type device(deviceSEXP);
    rcpp_result_gen = Rcpp::wrap(smr(train_feats, test_feats, train_targets, test_targets, num_classes, query, verbose, benchmark, device));
    return rcpp_result_gen;
END_RCPP
}
// smr_demo
void smr_demo(int perc, bool verbose);
RcppExport SEXP _viewmaster_smr_demo(SEXP percSEXP, SEXP verboseSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type perc(percSEXP);
    Rcpp::traits::input_parameter< bool >::type verbose(verboseSEXP);
    smr_demo(perc, verbose);
    return R_NilValue;
END_RCPP
}
// computeSparseRowVariances
Rcpp::NumericVector computeSparseRowVariances(IntegerVector j, NumericVector val, NumericVector rm, int n);
RcppExport SEXP _viewmaster_computeSparseRowVariances(SEXP jSEXP, SEXP valSEXP, SEXP rmSEXP, SEXP nSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< IntegerVector >::type j(jSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type val(valSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type rm(rmSEXP);
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    rcpp_result_gen = Rcpp::wrap(computeSparseRowVariances(j, val, rm, n));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_viewmaster_bagging_demo", (DL_FUNC) &_viewmaster_bagging_demo, 2},
    {"_viewmaster_bagging", (DL_FUNC) &_viewmaster_bagging, 11},
    {"_viewmaster_af_dbn", (DL_FUNC) &_viewmaster_af_dbn, 16},
    {"_viewmaster_dbn_demo", (DL_FUNC) &_viewmaster_dbn_demo, 3},
    {"_viewmaster_lr", (DL_FUNC) &_viewmaster_lr, 10},
    {"_viewmaster_lr_demo", (DL_FUNC) &_viewmaster_lr_demo, 2},
    {"_viewmaster_naive_bayes", (DL_FUNC) &_viewmaster_naive_bayes, 9},
    {"_viewmaster_naive_bayes_demo", (DL_FUNC) &_viewmaster_naive_bayes_demo, 2},
    {"_viewmaster_test_backends", (DL_FUNC) &_viewmaster_test_backends, 0},
    {"_viewmaster_af_nn", (DL_FUNC) &_viewmaster_af_nn, 15},
    {"_viewmaster_ann_demo", (DL_FUNC) &_viewmaster_ann_demo, 5},
    {"_viewmaster_perceptron", (DL_FUNC) &_viewmaster_perceptron, 8},
    {"_viewmaster_perceptron_demo", (DL_FUNC) &_viewmaster_perceptron_demo, 3},
    {"_viewmaster_smr", (DL_FUNC) &_viewmaster_smr, 9},
    {"_viewmaster_smr_demo", (DL_FUNC) &_viewmaster_smr_demo, 2},
    {"_viewmaster_computeSparseRowVariances", (DL_FUNC) &_viewmaster_computeSparseRowVariances, 4},
    {NULL, NULL, 0}
};

RcppExport void R_init_viewmaster(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
