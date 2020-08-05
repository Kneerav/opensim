#' Compute marker error for IK
#'
#' Compute marker error for IK
#' @param x a string containing the filepath for the trc file of a static scale trial
#' @param y a string containing the filepath for the sto reporting model marker locations from static scale trial
#' @param units_trc string contain unit of measurement of the trc file in either "mm" or "m", defaults to "mm"
#' @param units_sto string contain unit of measurement of the sto file in either "mm" or "m", defaults to "m".
#' @return dataframe containing marker error data
#' @export

Compute_marker_error_IK = function(x,y,
                                skip_sto = 6,
                                units_trc = "mm",
                                units_sto = "m"){

  # does read.trc need to be called from opensim::  ????
  x = read.trc(x)
  y = read.delim(y, skip=skip_sto)

  #rename data so it has the same name
  colnames(y) = gsub(pattern = "_tz", "_Z", colnames(y))
  colnames(y) = gsub(pattern = "_tx", "_X", colnames(y))
  colnames(y) = gsub(pattern = "_ty", "_Y", colnames(y))

  colnames(y[-1]) == colnames(x[-c(1,2)])

  #prep data (need to fix this!!!!!!!!!!!)
  x = x[,-1] #remove frame column
  y = data.frame(time = y[,1], y[,-1]*1000) #add time column and convert m to mm

  #function to get squared differences
  Square_diff = function(x){
    diff = x[1]-x[2]
    diff_2 = diff^2
  }

  #get squared difference for the two dataframes, then get marker/plane averages
  Diffs = data.table::rbindlist(list(x,y))[,lapply(.SD,Square_diff), list(time)]

  #gets the sum of errors for each marker (sums the three planes)
  Index_vec = seq(2,length(Avg_Diffs), 3)
  SUM = matrix(nrow = nrow(Diffs), ncol = length(Index_vec))
  for(i in 1:length(Index_vec)){

    #fix this as it is set up to read a vector()
    SUM[,i] = sqrt(Diffs[Index_vec[i]] + Diffs[Index_vec[i]+1] + Diffs[Index_vec[i]+2])

  }

  SUM_DF = as.data.frame(t(SUM))
  colnames(SUM_DF) = gsub("_X", "_error", colnames(x[,Index_vec]))

  return(SUM_DF)

}
