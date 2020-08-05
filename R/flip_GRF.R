flip_GRF = function(GRF_file, 
                    output_path, 
                    output_file = "/GRF_IAA.mot"){
  
  GRF = opensim::read.mot.sto(GRF_file)
  GRF = GRF[,c(1,11:16,2:7)]
  
  colnames(GRF) = c("time", "1_force_vx", "1_force_vy","1_force_vz",
                    "1_force_px","1_force_py","1_force_pz",
                    "2_force_vx","2_force_vy","2_force_vz",
                    "2_force_px","2_force_py","2_force_pz")
  
  opensim::write.force.mot(x=GRF, path=output_path, filename = output_file)
}