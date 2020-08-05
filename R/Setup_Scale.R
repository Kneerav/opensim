Setup_Scale = function(base_file = "Setup_scale_base.xml",
                    mass,
                    height,
                    age,
                    model_file = "Model.osim",
                    marker_set_file = "Markers.xml",
                    marker_file = "Marker.trc",
                    coordinate_file = "Unassigned",
                    start_time,
                    end_time,
                    output_motion_file = "IK.mot",
                    output_model_file = "Model_SCALED.osim",
                    output_marker_file = "Marker_locations.sto",
                    setup_filename = "Setup_Scale.xml"){


  #Read in default file
  x = XML::xmlParse(base_file)

  #set up root
  root = XML::xmlRoot(x)

  #mass
  nodes = XML::getNodeSet(x, "//ScaleTool//mass")
  XML::xmlValue(nodes[[1]]) = mass

  #height
  nodes = XML::getNodeSet(x, "//ScaleTool//height")
  XML::xmlValue(nodes[[1]]) = height

  #age
  nodes = XML::getNodeSet(x, "//ScaleTool//age")
  XML::xmlValue(nodes[[1]]) = age

  #model_file
  nodes = XML::getNodeSet(x, "//ScaleTool//GenericModelMaker//model_file")
  XML::xmlValue(nodes[[1]]) = model_file

  #marker_set_file
  nodes = XML::getNodeSet(x, "//ScaleTool//GenericModelMaker//marker_set_file")
  XML::xmlValue(nodes[[1]]) = marker_set_file

  #marker_file
  nodes = XML::getNodeSet(x, "//ScaleTool//MarkerPlacer//marker_file")  #markerplacer
  XML::xmlValue(nodes[[1]]) = marker_file
  
  nodes = XML::getNodeSet(x, "//ScaleTool//ModelScaler//marker_file")  #modelscaler
  XML::xmlValue(nodes[[1]]) = marker_file

  #coordinate_file
  nodes = XML::getNodeSet(x, "//ScaleTool//coordinate_file")
  XML::xmlValue(nodes[[1]]) = coordinate_file

  #time_range
  time_range = paste0(start_time, " ", end_time)
  nodes = XML::getNodeSet(x, "//ScaleTool//MarkerPlacer//time_range") #markerplacer
  XML::xmlValue(nodes[[1]]) = time_range
  
  nodes = XML::getNodeSet(x, "//ScaleTool//ModelScaler//time_range") #modelscaler
  XML::xmlValue(nodes[[1]]) = time_range

  #output_motion_file
  nodes = XML::getNodeSet(x, "//ScaleTool//MarkerPlacer//output_motion_file")
  XML::xmlValue(nodes[[1]]) = output_motion_file

  #output_model_file
  nodes = XML::getNodeSet(x, "//ScaleTool//MarkerPlacer//output_model_file") #markerplacer
  XML::xmlValue(nodes[[1]]) = output_model_file
  
  nodes = XML::getNodeSet(x, "//ScaleTool//ModelScaler//output_model_file") #modelscaler
  XML::xmlValue(nodes[[1]]) = output_model_file

  #output_marker_file
  nodes = XML::getNodeSet(x, "//ScaleTool//MarkerPlacer//output_marker_file")
  XML::xmlValue(nodes[[1]]) = output_marker_file

  #Write to file
  cat(XML::saveXML(x,
                   indent = TRUE,
                   #prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>",
                   encoding = "UTF-8"),
      file=(setup_filename))

}
