Setup_ID = function(base_file = "Setup_ID_base.xml",
                    results_directory = ".",
                    model_file = "Model_SCALED.osim",
                    start_time,
                    end_time,
                    forces_to_exclude = "Muscles",
					external_loads_file = "External_loads.xml",
                    coordinates_file = "IK.mot",
                    lowpass_cutoff_frequency_for_coordinates = "8",
                    output_gen_force_file = "inverse_dynamics.sto",
                    setup_filename = "Setup_ID.xml"){


  #Read in default file
  x = XML::xmlParse(base_file)

  #set up root
  root = XML::xmlRoot(x)

  #results_directory
  nodes = XML::getNodeSet(x, "//InverseDynamicsTool//results_directory")
  XML::xmlValue(nodes[[1]]) = results_directory

  #model_file
  nodes = XML::getNodeSet(x, "//InverseDynamicsTool//model_file")
  XML::xmlValue(nodes[[1]]) = model_file

  #time_range
  time_range = paste0(start_time, " ", end_time)
  nodes = XML::getNodeSet(x, "//InverseDynamicsTool//time_range")
  XML::xmlValue(nodes[[1]]) = time_range

  #forces_to_exclude
  nodes = XML::getNodeSet(x, "//InverseDynamicsTool//forces_to_exclude")
  XML::xmlValue(nodes[[1]]) = forces_to_exclude
  
  #external_loads_file
  nodes = XML::getNodeSet(x, "//InverseDynamicsTool//external_loads_file")
  XML::xmlValue(nodes[[1]]) = external_loads_file

  #coordinates_file
  nodes = XML::getNodeSet(x, "//InverseDynamicsTool//coordinates_file")
  XML::xmlValue(nodes[[1]]) = coordinates_file

  #lowpass_cutoff_frequency_for_coordinates
  nodes = XML::getNodeSet(x, "//InverseDynamicsTool//lowpass_cutoff_frequency_for_coordinates")
  XML::xmlValue(nodes[[1]]) = lowpass_cutoff_frequency_for_coordinates

  #output_gen_force_file
  nodes = XML::getNodeSet(x, "//InverseDynamicsTool//output_gen_force_file")
  XML::xmlValue(nodes[[1]]) = output_gen_force_file

  #Write to file
  cat(XML::saveXML(x,
                   indent = TRUE,
                   #prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>",
                   encoding = "UTF-8"),
      file=(setup_filename))

}
