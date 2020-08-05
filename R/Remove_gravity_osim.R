Remove_gravity_osim = function(model_file,
                          output_model_file){
  
  #Read data
  x = XML::xmlParse(model_file)
  
  #set up data to add markers
  root = XML::xmlRoot(x)
  nodes = XML::getNodeSet(x, "//gravity")
  
  XML::xmlValue(nodes[[1]]) = as.character("0 0 0")
  
  cat(XML::saveXML(x,
                   indent = TRUE,
                   prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"),
      file=(output_model_file))
}
