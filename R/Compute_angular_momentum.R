Compute_angular_momentum = function(osim_model = "Model_SCALED.osim",
                                    BK_vel,
                                    BK_pos){
  require(XML)
  require(dplyr)
  
  
  
  #Read model data
  Mass = as.data.frame(Extract_inertia(osim_model = osim_model))
  
  BK = opensim::read.mot.sto(BK_vel)
  BK_pos = opensim::read.mot.sto(BK_pos)
  
  #Velocity stuff
  
  VOx = BK %>% select(time, ends_with("_Ox")) %>% 
    setNames(names(.) %>% stringr::str_replace("_Ox","")) %>%
    #select(-center_of_mass) %>%
    reshape2::melt("id.vars" = "time") %>%
    rename(Body = variable, VOx =  value) 
  
  VOy = BK %>% select(time, ends_with("_Oy")) %>% 
    setNames(names(.) %>% stringr::str_replace("_Oy","")) %>%
    #select(-center_of_mass) %>%
    reshape2::melt("id.vars" = "time") %>%
    rename(Body = variable, VOy =  value) 
  
  VOz = BK %>% select(time, ends_with("_Oz")) %>% 
    setNames(names(.) %>% stringr::str_replace("_Oz","")) %>%
    #select(-center_of_mass) %>%
    reshape2::melt("id.vars" = "time") %>%
    rename(Body = variable, VOz =  value) 
  
  ####################    relative difference
  VX = BK %>% select(time, ends_with("_X")) %>% 
    setNames(names(.) %>% stringr::str_replace("_X","")) %>%
    as.matrix() 
  
  VX_diff = data.frame(
    time = VX[, 1],
    VX[, -c(1,25)] - VX[,25]) %>%
    reshape2::melt("id.vars" = "time") %>%
    rename(Body = variable, VX =  value)
  
  VY = BK %>% select(time, ends_with("_Y")) %>% 
    setNames(names(.) %>% stringr::str_replace("_Y","")) %>%
    as.matrix() 
  
  VY_diff = data.frame(
    time = VY[, 1],
    VY[, -c(1,25)] - VY[,25]) %>%
    reshape2::melt("id.vars" = "time") %>%
    rename(Body = variable, VY =  value) 
  
  VZ = BK %>% select(time, ends_with("_Z")) %>% 
    setNames(names(.) %>% stringr::str_replace("_Z","")) %>%
    as.matrix() 
  
  VZ_diff = data.frame(
    time = VZ[, 1],
    VZ[, -c(1,25)] - VZ[,25]) %>%
    reshape2::melt("id.vars" = "time") %>%
    rename(Body = variable, VZ =  value) 
  
  #position
  pos_VX = BK_pos %>% select(time, ends_with("_X")) %>% 
    setNames(names(.) %>% stringr::str_replace("_X","")) %>%
    as.matrix() 
  
  pos_VX_diff = data.frame(
    time = pos_VX[, 1],
    pos_VX[, -c(1,25)] - pos_VX[,25]) %>%
    reshape2::melt("id.vars" = "time") %>%
    rename(Body = variable, rX =  value)
  
  pos_VY = BK_pos %>% select(time, ends_with("_Y")) %>% 
    setNames(names(.) %>% stringr::str_replace("_Y","")) %>%
    as.matrix() 
  
  pos_VY_diff = data.frame(
    time = pos_VY[, 1],
    pos_VY[, -c(1,25)] - pos_VY[,25]) %>%
    reshape2::melt("id.vars" = "time") %>%
    rename(Body = variable, rY =  value) 
  
  pos_VZ = BK_pos %>% select(time, ends_with("_Z")) %>% 
    setNames(names(.) %>% stringr::str_replace("_Z","")) %>%
    as.matrix() 
  
  pos_VZ_diff = data.frame(
    time = pos_VZ[, 1],
    pos_VZ[, -c(1,25)] - pos_VZ[,25]) %>%
    reshape2::melt("id.vars" = "time") %>%
    rename(Body = variable, rZ =  value) 
  
  
  #merge everything
  Full = VX_diff %>% left_join(VY_diff) %>% 
    left_join(VZ_diff)  %>% 
    left_join(VOx)  %>% 
    left_join(VOy)  %>% 
    left_join(VOz)  %>%
    left_join(pos_VX_diff)  %>%
    left_join(pos_VY_diff)  %>%
    left_join(pos_VZ_diff)  %>%
    left_join(Mass)
  
  #compute momentum (still need to read position to get moment arms ja feel)
  Momentum_components_transverse = Full %>%
    mutate(transverse =
             rX * as.numeric(as.character(mass))*VZ + 
             rZ * as.numeric(as.character(mass))*VX + 
             as.numeric(as.character(inertia_yy)) * pracma::deg2rad(VOy)) %>%
    select(time, Body, transverse) %>%
    reshape2::dcast(time ~ Body, value.var = "transverse") %>%
    mutate(Arm_r = hand_r + ulna_r + radius_r + humerus_r,
           Arm_l = hand_l + ulna_l + radius_l + humerus_l,
           Arms = Arm_r + Arm_l,
           Leg_r = toes_r + calcn_r + talus_r + tibia_r + femur_r,
           Leg_l = toes_l + calcn_l + talus_l + tibia_l + femur_l,
           Legs = Leg_r + Leg_l) 
  
  Momentum_components_frontal = Full %>%
    mutate(frontal =
             rZ * as.numeric(as.character(mass))*VY + 
             rY * as.numeric(as.character(mass))*VZ + 
             as.numeric(as.character(inertia_yy)) * pracma::deg2rad(VOx)) %>%
    select(time, Body, frontal) %>%
    reshape2::dcast(time ~ Body, value.var = "frontal") %>%
    mutate(Arm_r = hand_r + ulna_r + radius_r + humerus_r,
           Arm_l = hand_l + ulna_l + radius_l + humerus_l,
           Arms = Arm_r + Arm_l,
           Leg_r = toes_r + calcn_r + talus_r + tibia_r + femur_r,
           Leg_l = toes_l + calcn_l + talus_l + tibia_l + femur_l,
           Legs = Leg_r + Leg_l) 
  
  Momentum_components_sagittal = Full %>%
    mutate(sagittal =
             rX * as.numeric(as.character(mass))*VY + 
             rY * as.numeric(as.character(mass))*VX + 
             as.numeric(as.character(inertia_yy)) * pracma::deg2rad(VOz)) %>%
    select(time, Body, sagittal) %>%
    reshape2::dcast(time ~ Body, value.var = "sagittal") %>%
    mutate(Arm_r = hand_r + ulna_r + radius_r + humerus_r,
           Arm_l = hand_l + ulna_l + radius_l + humerus_l,
           Arms = Arm_r + Arm_l,
           Leg_r = toes_r + calcn_r + talus_r + tibia_r + femur_r,
           Leg_l = toes_l + calcn_l + talus_l + tibia_l + femur_l,
           Legs = Leg_r + Leg_l) 
  
  #write.csv(x=Momentum_components_frontal, file = paste0(x, "/IAA_roll/Momentum_frontal.csv"), row.names = FALSE)
  #write.csv(x=Momentum_components_transverse, file = paste0(x, "/IAA_roll/Momentum_transverse.csv"), row.names = FALSE)
  #write.csv(x=Momentum_components_sagittal, file = paste0(x, "/IAA_roll/Momentum_sagittal.csv"), row.names = FALSE)

  return(list(Momentum_components_sagittal, 
              Momentum_components_frontal,
              Momentum_components_transverse))
  

}

