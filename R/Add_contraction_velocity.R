Add_contraction_velocity = function(model_file,
                            output_model_file,
                            Vmax = 20){
    
  #Read data
  x = XML::xmlParse(model_file)
  
  #set up data to add markers
  root = XML::xmlRoot(x)
  nodes = XML::getNodeSet(x, "//ForceSet//objects")
  nodes2 = XML::getNodeSet(x, "//ForceSet//objects//Millard2012EquilibriumMuscle")
  
  #extract muscle names
  muscles = vector()
  for(i in 1:length(nodes2)){
    muscles[i] = XML::xmlAttrs(nodes2[[i]])
  }
  
  #Add max contraction velocity to each muscle
  for(i in 1:length(muscles)){
    nodes_i = XML::getNodeSet(x, paste0("//Millard2012EquilibriumMuscle [@name ='", muscles[i], "']"))
    Vmax = as.character(Vmax)
    XML::newXMLNode(Vmax,  name = "max_contraction_velocity", parent = nodes_i)
  }

  
  cat(XML::saveXML(x,
                   indent = TRUE,
                   prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"),
      file=(output_model_file))
}
