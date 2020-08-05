write.sto = function(x, name, path, filename){
  nRows = nrow(x)
  nColumns = ncol(x)
  Header = c(name,"version=1", paste0("nRows=", nRows), paste0("nColumns=", nColumns), "inDegrees=no", "", "endheader")
  caroline::write.delim(df=Header, file=paste0(path, filename, ".sto"), col.names = FALSE, row.names = FALSE, sep="\t")
  caroline::write.delim(df=x, file=paste0(path, filename, ".sto"), col.names = TRUE, row.names = FALSE, sep="\t", append=TRUE)

}
