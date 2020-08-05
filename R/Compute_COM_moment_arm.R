Compute_COM_moment_arm = function(Body_kinematics,
                                    GRF,
                                    FP = 1){
  
  BK = read.mot.sto(Body_kinematics)
  GRF = read.mot.sto(GRF)
  
  require(dplyr)
  
  #filter GRF so same time as BK
  GRF_sync = GRF %>% filter(time >= BK$time[1] & time <= BK$time[nrow(BK)]) 
  
  #resample BK so same length and GRF
  BK_sync = biomechanics::Time_normalise(BK, nodes=nrow(GRF_sync))
  
  #Now lets merge and compute moment arms
  DF = data.frame(GRF_sync, BK_sync)
  
  if(FP == 1){
    GF = "X1_"
  } else {
    GF = "X2_"
  }
  
  DF = DF %>% mutate(ML = get(paste0(GF, "ground_force_pz")) - center_of_mass_Z,
                     AP = get(paste0(GF, "ground_force_px")) - center_of_mass_X,
                     SI = get(paste0(GF, "ground_force_py")) - center_of_mass_Y) %>%
    select(time, AP, SI, ML)
  
  return(DF)
  
}
  