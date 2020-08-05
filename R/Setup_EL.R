Setup_EL = function(base_file = "External_loads_base.xml",
                    leg = "Left",
                    body = "calcn_l",
                    datafile = "GRF.mot",
                    lowpass_cutoff_frequency_for_load_kinematics = "8",
                    setup_filename = "External_loads.xml"){
  
  
  #Read in default file
  x = XML::xmlParse(base_file)
  
  #set up root
  root = XML::xmlRoot(x)
  
  #leg
  nodes = XML::getNodeSet(x, "//ExternalLoads//objects//ExternalForce")
  XML::addAttributes(nodes[[1]], name=leg)
  
  #body
  nodes = XML::getNodeSet(x, "//ExternalLoads//objects//ExternalForce//applied_to_body")
  XML::xmlValue(nodes[[1]]) = body
  
  #datafile
  nodes = XML::getNodeSet(x, "//ExternalLoads//datafile")
  XML::xmlValue(nodes[[1]]) = datafile
  
  #lowpass_cutoff_frequency_for_load_kinematics
  nodes = XML::getNodeSet(x, "//ExternalLoads//lowpass_cutoff_frequency_for_load_kinematics")
  XML::xmlValue(nodes[[1]]) = lowpass_cutoff_frequency_for_load_kinematics
  

  #Write to file
  cat(XML::saveXML(x,
                   indent = TRUE,
                   #prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>",
                   encoding = "UTF-8"),
      file=(setup_filename))
  
}