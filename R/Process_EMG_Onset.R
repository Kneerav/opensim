Process_EMG_Onset = function(x){
  x = x - mean(x)
  
  #high pass 20Hz
  BW = signal::butter(n=2, W=20/500, plane="z", type="high")
  Filtered = signal::filtfilt(BW, x)
  
  #TKEO
  TKEO = seewave::TKEO(Filtered, f=1000, plot = FALSE)
  
  #Remove NA then lowpass
  new_x = TKEO[2:(nrow(TKEO)-1),2]
  BW = signal::butter(n=3, W=50/500, plane="z", type="low")
  Filtered = signal::filtfilt(BW, new_x)
  
  return(Filtered)
}