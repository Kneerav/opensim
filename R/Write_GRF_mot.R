write.force.mot = function(x, path, filename){
  nRows = nrow(x)
  nColumns = ncol(x)
  time.min = x[1,1]
  time.max = x[nrow(x),1]
  Header = c("GRF_file","version=1", paste0("nRows=", nRows), paste0("nColumns=", nColumns), "inDegrees=no", paste0("range ", time.min, " ", time.max), "endheader")
  caroline::write.delim(df=Header, file=paste0(path, filename, ".mot"), col.names = FALSE, row.names = FALSE, sep="\t")
  caroline::write.delim(df=x, file=paste0(path, filename, ".mot"), col.names = TRUE, row.names = FALSE, sep="\t", append=TRUE)

}
