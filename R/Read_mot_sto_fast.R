read_mot_sto = function(x){

  require(readr)
  
  line <- 0L
  input <- "start"
  while( !grepl( "time", input )  ) {
    line <- line + 1L
    input <- read_lines(x, skip = line - 1L, n_max = 1L )
  }
  line
  
  data = read.delim(x, skip = line-1)
  
  return(data)
  
}
