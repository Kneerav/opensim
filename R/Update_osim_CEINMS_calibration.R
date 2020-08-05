#Update osim model to include calibrated parameters
Update_osim_CEINMS_calibration = function(model_file,
                                    output_model_file,
                                    CEINMS_calibrated_file){
  
  #Read data
  x = XML::xmlParse(model_file)
  y = XML::xmlParse(CEINMS_calibrated_file)
  
  #set up data to add markers
  root = XML::xmlRoot(y)
  nodes = XML::getNodeSet(y, "//mtuSet//mtu")
  
  nodes2 = XML::getNodeSet(x, "//ForceSet//objects//Millard2012EquilibriumMuscle")
  
  #extract muscle names
  muscles = vector()
  for(i in 1:length(nodes)){
    muscles[i] = XML::xmlValue(nodes[[i]][["name"]])
  }
  
  #Add max contraction velocity to each muscle
  for(i in 1:length(muscles)){
    optimalFibreLength = XML::xmlValue(nodes[[i]][["optimalFibreLength"]])
    pennationAngle = XML::xmlValue(nodes[[i]][["pennationAngle"]])
    tendonSlackLength = XML::xmlValue(nodes[[i]][["tendonSlackLength"]])
    maxIsometricForce = XML::xmlValue(nodes[[i]][["maxIsometricForce"]])
    strengthCoefficient = XML::xmlValue(nodes[[i]][["strengthCoefficient"]])
    
    new_max = as.numeric(maxIsometricForce)*as.numeric(strengthCoefficient)
    
    #write data
    nodes_i = XML::getNodeSet(x, paste0("//Millard2012EquilibriumMuscle [@name ='", muscles[i], "']"))
    xmlValue(nodes_i[[1]][["max_isometric_force"]]) = as.character(new_max)
    xmlValue(nodes_i[[1]][["tendon_slack_length"]]) = as.character(tendonSlackLength)
    xmlValue(nodes_i[[1]][["optimal_fiber_length"]]) = as.character(optimalFibreLength)
    xmlValue(nodes_i[[1]][["pennation_angle_at_optimal"]]) = as.character(pennationAngle)

  }
  
  
  cat(XML::saveXML(x,
                   indent = TRUE,
                   prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"),
      file=(output_model_file))
}
