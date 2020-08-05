read.mot.sto = function(x){
  for(i in 1:40){
    y = try(read.delim(x, header=TRUE, skip=i), silent = TRUE)
    if(class(y) == "try-error"){
      next
    } else {
      y = read.delim(x, header=TRUE, skip=i)
      if(colnames(y)[1]=="time"){
        break
      }
    }
      
    }

    return(y)
}