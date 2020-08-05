Adjust_reserves = function(base_file = "Reserve_Actuators_base.xml",
                           model_file = "F:/Supervision/Paige/Participant_03/Initial/Model_SCALED.osim",
                           output_filename = "Reserve_Actuators.xml"){
  
  
  #Read in default file
  x = XML::xmlParse(model_file)
  
  #set up root
  root = XML::xmlRoot(x)
  
  #leg
  nodes = XML::getNodeSet(x, "//Model//BodySet//objects")
  nodes_i = XML::getNodeSet(x, paste0("//Body [@name ='", "pelvis", "']"))
  pelvis_centre_model = XML::xmlValue(nodes_i[[1]][["mass_center"]])
  
  #Append reserves
  y = XML::xmlParse(base_file)
  
  #set up root
  root = XML::xmlRoot(y)
  
  #FX
  nodes_i = XML::getNodeSet(y, paste0("//PointActuator [@name ='", "FX", "']"))
  XML::xmlValue(nodes_i[[1]][["point"]]) = pelvis_centre_model
  
  #FY
  nodes_i = XML::getNodeSet(y, paste0("//PointActuator [@name ='", "FY", "']"))
  XML::xmlValue(nodes_i[[1]][["point"]]) = pelvis_centre_model
  
  #FZ
  nodes_i = XML::getNodeSet(y, paste0("//PointActuator [@name ='", "FZ", "']"))
  XML::xmlValue(nodes_i[[1]][["point"]]) = pelvis_centre_model
  
  #Write to file
  cat(XML::saveXML(y,
                   indent = TRUE,
                   #prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>",
                   encoding = "UTF-8"),
      file=(output_filename))
  
}