Extract_inertia = function(osim_model){
  
  require(XML)
  
  #Read model data
  x = XML::xmlParse(osim_model)
  
  #set up data to add markers
  root = XML::xmlRoot(x)
  nodes = XML::getNodeSet(x, "//BodySet//objects")
  nodes2 = XML::getNodeSet(x, "//BodySet//objects//Body")
  
  #get body names
  bodies = vector()
  for(i in 1:length(nodes2)){
    bodies[i] = XML::xmlAttrs(nodes2[[i]])
  }
  
  #setup matrix
  mass_matrix = matrix(nrow=length(bodies), ncol=9)
  
  #extract info and add to matrix
  for(i in 1:length(bodies)){
    mass_matrix[i,1] = bodies[i]
    mass_matrix[i,2] = XML::xmlValue(nodes2[[i]][["mass"]])
    mass_matrix[i,3] = XML::xmlValue(nodes2[[i]][["mass_center"]])
    mass_matrix[i,4] = XML::xmlValue(nodes2[[i]][["inertia_xx"]])
    mass_matrix[i,5] = XML::xmlValue(nodes2[[i]][["inertia_yy"]])
    mass_matrix[i,6] = XML::xmlValue(nodes2[[i]][["inertia_zz"]])
    mass_matrix[i,7] = XML::xmlValue(nodes2[[i]][["inertia_xy"]])
    mass_matrix[i,8] = XML::xmlValue(nodes2[[i]][["inertia_xz"]])
    mass_matrix[i,9] = XML::xmlValue(nodes2[[i]][["inertia_yz"]])
  }
  
  #name matrix cols
  colnames(mass_matrix) = c("Body", "mass", "mass_center", 
                            "inertia_xx" , "inertia_yy" , "inertia_zz",
                            "inertia_xy", "inertia_xz", "inertia_yz")
  
  return(mass_matrix)
}



