Setup_RRA_Actuators = function(base_file = "RRA_Actuators.xml",
							   model_file = "Model_SCALED.osim",
                               setup_filename = "RRA_actuators.xml"){


  require(XML)
  
	#Read model data
	x = XML::xmlParse(base_file)

	#set up data to add markers
	root = XML::xmlRoot(x)
	nodes = XML::getNodeSet(x, "//ForceSet//objects")
	nodes2 = XML::getNodeSet(x, "//ForceSet//objects//PointActuator")

	#Read Osim file
	y = XML::xmlParse(model_file)

	#set up data to add muscles
	root_y = XML::xmlRoot(y)
	nodes_y = XML::getNodeSet(y, "//BodySet//objects")
	nodes_y2 = XML::getNodeSet(y, "//BodySet//objects//Body")
	mass_centre = XML::xmlValue(nodes_y2[[2]][["mass_center"]])

	#paste(muscles, collapse=" ")

	muscles = c("FX", "FY", "FZ")

	for(i in 1:length(muscles)){
	  nodes_i = XML::getNodeSet(x, paste0("//PointActuator [@name ='", muscles[i], "']"))
	  XML::xmlValue(nodes_i[[1]][[4]]) = as.character(mass_centre)
	  
	}

	#Write to file
	cat(XML::saveXML(x,
					 indent = TRUE,
					 #prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>",
					 encoding = "UTF-8"),
		file=(setup_filename))

}
