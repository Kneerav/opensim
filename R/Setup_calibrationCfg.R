Setup_Calibration_cfg = function(base_file = "calibrationCfg_base.xml",
                    trialSet = "Gait_trial.xml",
                    setup_filename = "Setup_IK.xml"){
  
  
  #Read in default file
  x = XML::xmlParse(base_file)
  
  #set up root
  root = XML::xmlRoot(x)
  
  #results_directory
  nodes = XML::getNodeSet(x, "//calibration//trialSet")
  XML::xmlValue(nodes[[1]]) = trialSet
  
  
  #Write to file
  cat(XML::saveXML(x,
                   indent = TRUE,
                   #prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>",
                   encoding = "UTF-8"),
      file=(setup_filename))
  
}
