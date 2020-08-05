#' Read a trc file
#'
#' Read a trc file
#' @param x trc file
#' @return Dataframe containing the marker data extracted from trc file
#' @export
read.trc = function(x){

  header = read.delim(x, skip=3, nrows = 1, header = FALSE)
  header = header[seq(3,length(header), by=3)]
  header= na.omit(as.vector(t(header)))

  header_x = paste(header, "_X", sep="")
  header_y = paste(header, "_Y", sep="")
  header_z = paste(header, "_Z", sep="")

  final_header = c(rbind(header_x, header_y, header_z))

  datum = read.delim(x, skip=4)
  colnames(datum) = c("Frame", "time", final_header)
  datum = datum[,1:(ncol(datum)-1)]

  return(datum)
}
