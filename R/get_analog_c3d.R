get_analog_c3d = function(Filename = "D:/Studies/EMG_Hybrid/C3D/jw_ngait_tm_ss1_2cycs.c3d",
                      EMG_names = c("Voltage.One", "Voltage.Two", "Voltage.Three","Voltage.Four",
                                    "Voltage.Five", "Voltage.Six", "Voltage.Seven", "Voltage.Eight",
                                    "Voltage.1", "Voltage.2", "Voltage.3"),
                      Muscle_names = c("bflh", "semimem", "vaslat","gasmed",
                                       "bflh_l", "gaslat", "soleus", "tibant",
                                       "recfem", "vasmed", "perlong"),
                      Force_plate = 2){
  require(reticulate)
  
  #get btk library
  btk = import("btk")
  
  #Setup reader
  reader = btk$btkAcquisitionFileReader()
  reader$SetFilename(Filename)
  reader$Update()
  acq = reader$GetOutput()
  
  #Get emg data
  EMG_data = matrix(ncol=length(EMG_names), nrow = length(as.vector(acq$GetAnalog(EMG_names[1])$GetValues())))
  for(i in 1:length(EMG_names)){
    Muscle = EMG_names[i]
    EMG_data[,i] = x = as.vector(acq$GetAnalog(Muscle)$GetValues())
  }
  EMG_data = as.data.frame(EMG_data)
  colnames(EMG_data) = Muscle_names
  
  #get FP data
  pfe = btk$btkForcePlatformsExtractor()
  pfe$SetInput(acq)
  pfe$Update()
  
  if(Force_plate == 2){
    Fx = pfe$GetOutput()$GetItem(0L)$GetChannel(1L)$GetValues()
    Fy = pfe$GetOutput()$GetItem(0L)$GetChannel(2L)$GetValues()
    Fz = pfe$GetOutput()$GetItem(0L)$GetChannel(3L)$GetValues()
    Fx2 = pfe$GetOutput()$GetItem(1L)$GetChannel(1L)$GetValues()
    Fy2 = pfe$GetOutput()$GetItem(1L)$GetChannel(2L)$GetValues()
    Fz2 = pfe$GetOutput()$GetItem(1L)$GetChannel(3L)$GetValues()
    
    Full = data.frame(EMG_data,
                      Fx = Fx, Fy = Fy, Fz = Fz,
                      Fx2 = Fx2, Fy2 = Fy2, Fz2 = Fz2)
  } else {
    Fx = pfe$GetOutput()$GetItem(0L)$GetChannel(1L)$GetValues()
    Fy = pfe$GetOutput()$GetItem(0L)$GetChannel(2L)$GetValues()
    Fz = pfe$GetOutput()$GetItem(0L)$GetChannel(3L)$GetValues()
    
    Full = data.frame(EMG_data,
                      Fx = Fx, Fy = Fy, Fz = Fz)
  }
  return(Full)
  
}
