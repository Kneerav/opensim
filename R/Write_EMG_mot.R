#' Compute the root-mean-square difference between two vectors of the same length
#'
#' Compute the root-mean-square difference between two vectors of the same length
#' @param x data frame containing the data to be written to a .mot file
#' @param name string for the name parameter printed in the .mot file. See example .MOT files provided with the OpenSim package.
#' @param filename string containing the desired filename for the .mot file. Note the ".mot" is note required in this string
#' @return writes the data frame to a .mot file
#' @export
write_EMG_mot = function(x, name="Normalised EMG Envelopes", filename = "EMG"){
  nRows = nrow(x)
  nColumns = ncol(x)
  Header = c(name, paste0("nRows=", nRows), paste0("nColumns=", nColumns), "", "endheader")
  caroline::write.delim(df=Header, file=paste0(filename, ".mot"), col.names = FALSE, row.names = FALSE, sep="\t")
  caroline::write.delim(df=x, file=paste0(filename, ".mot"), col.names = TRUE, row.names = FALSE, sep="\t", append=TRUE)
}
