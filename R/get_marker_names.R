get.marker.names = function(x){
  header = read.delim(x, skip=3, nrows = 1, header = FALSE)
  header = header[seq(3,length(header), by=3)]
  header= as.vector(t(header))
  
  header = header[-length(header)]
  
  return(header)
}
