Osim_to_CEINMS_scale = function(osim_model,
                          input_file,
                          output_file,
                          limb = "Right",
						  scale_factor = 1,
						  maxContractionVelocity = 10){
  

  require(XML)
  
  #Read model data
  x = XML::xmlParse(osim_model)
  
  #set up data to add markers
  root = XML::xmlRoot(x)
  nodes = XML::getNodeSet(x, "//ForceSet//objects")
  nodes2 = XML::getNodeSet(x, "//ForceSet//objects//Millard2012EquilibriumMuscle")
  
  #Read EMG_hybrid blank
  y = XML::xmlParse(input_file)
  
  #set up data to add muscles
  root_y = XML::xmlRoot(y)
  nodes_y = XML::getNodeSet(y, "//mtuSet")
  
  if(limb=="Right"){
    muscles = c("bflh_r", "semimem_r", "semiten_r",
                "vasint_r", "vaslat_r", "vasmed_r", "recfem_r",
                "glmax1_r", "glmax2_r", "glmax3_r",
                "glmed1_r", "glmed2_r", "glmed3_r",
                "glmin1_r", "glmin2_r", "glmin3_r",
                "soleus_r", "gasmed_r", "gaslat_r", 
                "tfl_r", "perlong_r", "perbrev_r", "tibant_r",
                "addmagProx_r", "addmagIsch_r","addmagDist_r","addmagMid_r",
                "piri_r",  "iliacus_r", "psoas_r", "addbrev_r", "addlong_r",
                "bfsh_r", "sart_r", "grac_r",
                "tibpost_r", "fhl_r", "fdl_r",
                "ehl_r", "edl_r")
  } else {
    muscles = c("bflh_l", "semimem_l", "semiten_l",
                "vasint_l", "vaslat_l", "vasmed_l", "recfem_l",
                "glmax1_l", "glmax2_l", "glmax3_l",
                "glmed1_l", "glmed2_l", "glmed3_l",
                "glmin1_l", "glmin2_l", "glmin3_l",
                "soleus_l", "gasmed_l", "gaslat_l", 
                "tfl_l", "perlong_l", "perbrev_l", "tibant_l",
                "addmagProx_l", "addmagIsch_l","addmagDist_l","addmagMid_l",
                "piri_l",  "iliacus_l", "psoas_l", "addbrev_l", "addlong_l",
                "bfsh_l", "sart_l", "grac_l",
                "tibpost_l", "fhl_l", "fdl_l",
                "ehl_l", "edl_l")
  }

  
  #paste(muscles, collapse=" ")
  
  for(i in 1:length(muscles)){
    nodes_i = XML::getNodeSet(x, paste0("//Millard2012EquilibriumMuscle [@name ='", muscles[i], "']"))
    
    #Get muscle params from scaled model
    
    opt_fibre = as.numeric(xmlValue(nodes_i[[1]][["optimal_fiber_length"]]))
    PA = as.numeric(xmlValue(nodes_i[[1]][["pennation_angle_at_optimal"]]))
    slack = as.numeric(xmlValue(nodes_i[[1]][["tendon_slack_length"]]))
    max = as.numeric(xmlValue(nodes_i[[1]][["max_isometric_force"]])) / scale_factor
    
    #Add
    Marker_R1 = newXMLNode("mtu", parent = nodes_y)
    newXMLNode(muscles[i],  name = "name", parent = Marker_R1)
    newXMLNode("0",  name = "c1", parent = Marker_R1)
    newXMLNode("0",  name = "c2", parent = Marker_R1)
    newXMLNode("-1",  name = "shapeFactor", parent = Marker_R1)
    newXMLNode(opt_fibre,  name = "optimalFibreLength", parent = Marker_R1)
    newXMLNode(PA,  name = "pennationAngle", parent = Marker_R1)
    newXMLNode(slack,  name = "tendonSlackLength", parent = Marker_R1)
	newXMLNode(maxContractionVelocity,  name = "maxContractionVelocity", parent = Marker_R1)
    newXMLNode(max,  name = "maxIsometricForce", parent = Marker_R1)
    newXMLNode("1",  name = "strengthCoefficient", parent = Marker_R1)
    
  }
  
  #remove default node
  removeNodes(XML::getNodeSet(y, "//mtuSet//mtu")[[1]])
  
  #write to file
  cat(XML::saveXML(y,
                   indent = TRUE,
                   #prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>", 
                   encoding = "UTF-8"),
      file=(output_file))
  
}

