Perturbation_setup = function(x = All_reps_dir[i],
                           model_file){           #Maybe model file??????? Change to medlat model
  
  
  setwd(x)
  
  #Create Perturbation directory
  dir.create(paste0(x, "/Contributions"))

  #Read in GRF decomp files
  if(stringr::str_detect(x, "Left")=="TRUE"){
    GRF_X = opensim::read.mot.sto(paste0(x, "/IAA/Model_scaled_IndAccPI_GRF_X_l.sto"))
    GRF_Y = opensim::read.mot.sto(paste0(x, "/IAA/Model_scaled_IndAccPI_GRF_Y_l.sto"))
    GRF_Z = opensim::read.mot.sto(paste0(x, "/IAA/Model_scaled_IndAccPI_GRF_Z_l.sto"))
    GRF_p = opensim::read.mot.sto(paste0(x, "/IAA/Model_scaled_IndAccPI_GUI_addbrev_l.sto"))
  } else {
    GRF_X = opensim::read.mot.sto(paste0(x, "/IAA/Model_scaled_IndAccPI_GRF_X_r.sto"))
    GRF_Y = opensim::read.mot.sto(paste0(x, "/IAA/Model_scaled_IndAccPI_GRF_Y_r.sto"))
    GRF_Z = opensim::read.mot.sto(paste0(x, "/IAA/Model_scaled_IndAccPI_GRF_Z_r.sto"))
    GRF_p = opensim::read.mot.sto(paste0(x, "/IAA/Model_scaled_IndAccPI_GUI_addbrev_r.sto"))
  }
  
  #Read forces
  Forces = opensim::read.mot.sto(paste0(x, "/Model_scaled_StaticOptimization_force.sto"))
  
  
  Forces = Forces[,-((ncol(Forces)-8):ncol(Forces))]
  
  ###################################   FUNCTIONS    ###################################
  
  #Write MOT file specifically for GRF
  write.force.mot = function(x, name, path, filename){
    nRows = nrow(x)
    nColumns = ncol(x)
    time.min = x[1,1]
    time.max = x[nrow(x),1]
    Header = c("GRF_file","version=1", paste0("nRows=", nRows), paste0("nColumns=", nColumns), "inDegrees=no", paste0("range ", time.min, " ", time.max), "endheader")
    caroline::write.delim(df=Header, file=paste0(path, filename, ".mot"), col.names = FALSE, row.names = FALSE, sep="\t")
    caroline::write.delim(df=x, file=paste0(path, filename, ".mot"), col.names = TRUE, row.names = FALSE, sep="\t", append=TRUE)
    
  }
  
  #Write GRF files in muscle specific folders 
  Write.folder.GRF = function(GF_X = GRF_X, GF_Y = GRF_Y, GF_Z = GRF_Z, GF_p = GRF_p,
                              path = paste0(x, "/Contributions/")){
    for(j in 2:ncol(GRF_X)){
      Force_data = data.frame(GRF_vx= GF_X[,j], GRF_vy= GF_Y[,j], GF_vz = GRF_Z[,j])
      Torques = phonTools::zeros(nrow(GF_X),3)
      
      if(stringr::str_detect(x, "Left")==TRUE){
        COP = data.frame(px = GF_p$ground_force2_px, py = phonTools::zeros(nrow(GF_X)) ,pz = GF_p$ground_force2_pz)
      } else {
        COP = data.frame(px = GF_p$ground_force1_px, py = phonTools::zeros(nrow(GF_X)) ,pz = GF_p$ground_force1_pz)
      }
      
      Forces = cbind.data.frame(GF_X[,1], Force_data, COP, Torques)
      colnames(Forces) = c("time", "1_force_vx","1_force_vy","1_force_vz",
                           "1_force_px","1_force_py","1_force_pz",
                           "1_torque_x","1_torque_y","1_torque_z")
      dir.create(path = paste0(path, colnames(GF_X)[j]))
      write.force.mot(x=Forces, "Force", path=paste0(path, colnames(GF_X)[j], "/"), "GRF")
    }
    
  }
  
  #Write sto
  write.sto = function(x, name, path, filename){
    nRows = nrow(x)
    nColumns = ncol(x)
    Header = c(name,"version=1", paste0("nRows=", nRows), paste0("nColumns=", nColumns), "inDegrees=no", "", "endheader")
    caroline::write.delim(df=Header, file=paste0(path, filename, ".sto"), col.names = FALSE, row.names = FALSE, sep="\t")
    caroline::write.delim(df=x, file=paste0(path, filename, ".sto"), col.names = TRUE, row.names = FALSE, sep="\t", append=TRUE)
    
  }
  
  #Take force file and spit out muscle of interest with all others at zero [adds to FOLDER]
  Write_zero_files = function(y, name, path = paste0(x, "/Contributions/")){
    
    for(j in 2:ncol(y)){
      Zeros = phonTools::zeros(nrow(y), ncol(y))
      Zeros[,1] = y[,1]
      Zeros[,j] = y[,j]
      DF = as.data.frame(Zeros)
      colnames(DF) = colnames(y)
      
      
      write.sto(x=DF, name=name, path = paste0(path, colnames(y)[j], "/"), filename = "Forces")
    }
  }
  
  
  
  #Run each function: 1. Create GRF in folders; 2. Create zero force files
  Write.folder.GRF()
  Write_zero_files(Forces, name="")
  
  
  #No_grav model
  opensim::Remove_gravity_osim(model_file = model_file, 
                      output_model_file = stringr::str_replace(model_file, ".osim", "_nograv.osim"))
  
  
  #Get stance times, tab all of this
  GRF_RAW = opensim::read.mot.sto(paste0(x, "/GRF_RAW.mot"))
  
  #Find stance
  Stance = dplyr::filter(GRF_RAW, X1_force_vy >10)
  start_time = Stance$time[1]
  end_time = Stance$time[nrow(Stance)]
  
  
  #this will setup external loads, setup ID, and copy IK to folders
  Muscle_Dir_list2 = list.dirs(path=paste0(x, "/Contributions/"), recursive=FALSE)
  for(j in 1:length(Muscle_Dir_list2)){
    
    setwd(x)
    
    #setup external loads, depending on leg
    if(stringr::str_detect(x, "Left")==TRUE){
      opensim::Setup_EL(base_file = "F:/PhD/R Package/Default_Setups/External_loads_base.xml", 
                        setup_filename = paste0(Muscle_Dir_list2[j], "/External_loads.xml"))
    } else {
      opensim::Setup_EL(base_file = "F:/PhD/R Package/Default_Setups/External_loads_base.xml", 
                        setup_filename = paste0(Muscle_Dir_list2[j], "/External_loads.xml"),
                        body = "calcn_r",
                        leg = "Right")
    }
    
    #Setup_ID
    opensim::Setup_ID(base_file = "F:/PhD/R Package/Default_Setups/Setup_ID_base.xml",
                      model_file = paste0(base_dir, "Initial/Model_SCALED_MedLat_nograv.osim"), 
                      start_time = start_time,
                      end_time = end_time,
                      setup_filename = paste0(Muscle_Dir_list2[j], "/Setup_ID.xml"))
    
  
   
    file.copy(from = list.files(path = paste0(x, "/MedLat"), pattern="IK.mot", full.names = TRUE), 
              to = Muscle_Dir_list2[j])
  }
  
  
  #This will get full force files for experimental and ModelTOTAL, will also run with gravity
  file.copy(from = list.files(path = x, pattern="StaticOptimization_force.sto", full.names = TRUE),
            to = paste0(x, "/Contributions/EXPERIMENTAL"))
  file.copy(from = list.files(path = x, pattern="StaticOptimization_force.sto", full.names = TRUE),
            to = paste0(x, "/Contributions/MODELTOTAL"))
  file.rename(list.files(path=paste0(x, "/Contributions/EXPERIMENTAL"), pattern="*StaticOptimization_force.sto", full.names = TRUE),
              paste0(x, "/Contributions/EXPERIMENTAL/Forces.sto"))
  file.rename(list.files(path=paste0(x, "/Contributions/MODELTOTAL"), pattern="*StaticOptimization_force.sto", full.names = TRUE),
              paste0(x, "/Contributions/MODELTOTAL/Forces.sto"))
  
  opensim::Setup_ID(base_file = "F:/PhD/R Package/Default_Setups/Setup_ID_base.xml",
                    model_file = paste0(base_dir, "Initial/Model_SCALED_MedLat.osim"), 
                    start_time = start_time,
                    end_time = end_time,
                    setup_filename = paste0(x, "/Contributions/MODELTOTAL/Setup_ID.xml"))
  
  opensim::Setup_ID(base_file = "F:/PhD/R Package/Default_Setups/Setup_ID_base.xml",
                    model_file = paste0(base_dir, "Initial/Model_SCALED_MedLat.osim"), 
                    start_time = start_time,
                    end_time = end_time,
                    setup_filename = paste0(x, "/Contributions/EXPERIMENTAL/Setup_ID.xml"))
  
}