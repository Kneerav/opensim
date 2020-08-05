Setup_IK = function(base_file = "Setup_IK_base.xml",
                    results_directory = ".",
                    input_directory = ".",
                    model_file = "Model_SCALED.osim",
                    constraint_weight = "Inf",
                    accuracy = "1e-005",
                    marker_file = "Marker.trc",
                    coordinate_file = "Unassigned",
                    start_time,
                    end_time,
                    report_errors = "true",
                    output_motion_file = "IK.mot",
                    report_marker_locations = "true",
                    Markers,
                    Weights = rep(1, length(Markers)),
                    setup_filename = "Setup_IK.xml"){


  #Read in default file
  x = XML::xmlParse(base_file)

  #set up root
  root = XML::xmlRoot(x)

  #results_directory
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//results_directory")
  XML::xmlValue(nodes[[1]]) = results_directory

  #input_directory
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//input_directory")
  XML::xmlValue(nodes[[1]]) = input_directory

  #model_file
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//model_file")
  XML::xmlValue(nodes[[1]]) = model_file

  #constraint_weight
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//constraint_weight")
  XML::xmlValue(nodes[[1]]) = constraint_weight

  #accuracy
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//accuracy")
  XML::xmlValue(nodes[[1]]) = accuracy

  #marker_file
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//marker_file")
  XML::xmlValue(nodes[[1]]) = marker_file

  #coordinate_file
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//coordinate_file")
  XML::xmlValue(nodes[[1]]) = coordinate_file

  #time_range
  time_range = paste0(start_time, " ", end_time)
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//time_range")
  XML::xmlValue(nodes[[1]]) = time_range

  #report_errors
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//report_errors")
  XML::xmlValue(nodes[[1]]) = report_errors

  #output_motion_file
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//output_motion_file")
  XML::xmlValue(nodes[[1]]) = output_motion_file

  #report_marker_locations
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//report_marker_locations")
  XML::xmlValue(nodes[[1]]) = report_marker_locations

  #IK tasks
  nodes = XML::getNodeSet(x, "//InverseKinematicsTool//IKTaskSet//objects")

  for(i in 1:length(Markers)){

    Marker = XML::newXMLNode("IKMarkerTask", parent = nodes)
    XML::newXMLNode("true",  name = "apply", parent = Marker)
    XML::newXMLNode("1",  name = "weight", parent = Marker)
    XML::addAttributes(Marker, name=Markers[i])

  }

  #Delete default marker
  XML::removeNodes(nodes[[1]][1])

  #Write to file
  cat(XML::saveXML(x,
                   indent = TRUE,
                   #prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>",
                   encoding = "UTF-8"),
      file=(setup_filename))

}
