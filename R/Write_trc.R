#' Write a trc file
#'
#' Write a trc file
#' @param x dataframe containing data to write to trc. Should be in the same format produced from read.trc()
#' @param unit string contain unit of measurement in either "mm" or "m"
#' @param filename string identifying the filename to write to file. Must end in .trc
#' @return trc file of filename
#' @export

write.trc = function(x, unit = "mm", filename){
  header1 = data.frame(V1 = "PathFileType", V2 = "4", V3 = "(X/Y/Z)", V4 = "Trial.trc")
  header2 = data.frame(DataRate = round(1/y[2,2], 0),
                       CameraRate = round(1/y[2,2], 0),
                       NumFrames = nrow(y),
                       NumMarkers = (ncol(y) - 2)/3,
                       Unit = unit,
                       OrigDataRate = round(1/y[2,2], 0),
                       OrigDataStartFrame = 1,
                       OrigNumFrames = nrow(y))

  New_names = gsub("_X", "", colnames(y))
  New_names[seq(4,length(New_names),by=3)] = ""
  New_names[seq(5,length(New_names),by=3)] = ""
  New_names[1] = "Frame#"

  Axis = c("", "", rep(c("X", "Y", "Z"),((ncol(y) - 2)/3) ))
  Numeric = 1:((ncol(y) - 2)/3)
  Numeric_3 = rep(Numeric, each=3)
  Numbers = c("", "", Numeric_3)
  Axis_final = paste(Axis, Numbers, sep="")

  y = rbind(Axis_final, y)
  colnames(y) = New_names

  caroline::write.delim(df=header1, file=filename, col.names = FALSE, row.names = FALSE, sep="\t")
  caroline::write.delim(df=header2, file=filename, col.names = TRUE, row.names = FALSE, sep="\t", append=TRUE)
  caroline::write.delim(df=y, file=filename, col.names = TRUE, row.names = FALSE, sep="\t", append=TRUE)


}
