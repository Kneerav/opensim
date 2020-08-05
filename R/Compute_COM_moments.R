
Compute_COM_moments = function(Body_kinematics,
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
                     SI = get(paste0(GF, "ground_force_py")) - center_of_mass_Y)
  
  DF = DF %>% mutate(Fy_Rx = get(paste0(GF, "ground_force_vy"))*AP,
                     Fy_Rz = get(paste0(GF, "ground_force_vy"))*ML,
                     Fz_Rx = get(paste0(GF, "ground_force_vz"))*AP,
                     Fz_Ry = get(paste0(GF, "ground_force_vz"))*SI,
                     Fx_Rz = get(paste0(GF, "ground_force_vx"))*ML,
                     Fx_Ry = get(paste0(GF, "ground_force_vx"))*SI) %>%
    mutate(Sagittal = Fy_Rx + Fx_Ry,
           Frontal = Fy_Rz + Fz_Ry,
           Transverse = Fx_Rz + Fz_Rx)  %>%
    select(time, AP, SI, ML, Fx_Ry, Fx_Rz, Fy_Rx, Fy_Rz, Fz_Rx, Fz_Ry, Sagittal, Frontal, Transverse)
  
  return(DF)
  
}