Setup_BK = function(base_file = "Setup_BK_base.xml",
                    model_file = "Model_SCALED.osim",
                    replace_force_set = "false",
                    force_set_files = "Reserve_Actuators.xml",
                    results_directory = ".",
                    output_precision = "12",
                    start_time,
                    end_time,
                    solve_for_equilibrium_for_auxiliary_states = "false",
                    maximum_number_of_integrator_steps = "20000",
                    maximum_integrator_step_size = "1",
                    minimum_integrator_step_size = "1e-05",
                    integrator_error_tolerance = "1e-05",
                    step_interval = "1",
                    in_degrees = "true",
                    bodies = "all",
                    express_results_in_body_local_frame = "false",
                    external_loads_file = "External_loads.xml",
                    coordinates_file = "IK.mot",
                    lowpass_cutoff_frequency_for_coordinates = "8",
                    setup_filename = "Setup_BK.xml"){


  #Read in default file
  x = XML::xmlParse(base_file)

  #set up root
  root = XML::xmlRoot(x)

  #model_file
  nodes = XML::getNodeSet(x, "//AnalyzeTool//model_file")
  XML::xmlValue(nodes[[1]]) = model_file

  #replace_force_set
  nodes = XML::getNodeSet(x, "//AnalyzeTool//replace_force_set")
  XML::xmlValue(nodes[[1]]) = replace_force_set

  #force_set_files
  nodes = XML::getNodeSet(x, "//AnalyzeTool//force_set_files")
  XML::xmlValue(nodes[[1]]) = force_set_files

  #results_directory
  nodes = XML::getNodeSet(x, "//AnalyzeTool//results_directory")
  XML::xmlValue(nodes[[1]]) = results_directory

  #output_precision
  nodes = XML::getNodeSet(x, "//AnalyzeTool//output_precision")
  XML::xmlValue(nodes[[1]]) = output_precision

  #initial_time
  nodes = XML::getNodeSet(x, "//AnalyzeTool//initial_time")
  XML::xmlValue(nodes[[1]]) = start_time

  #final_time
  nodes = XML::getNodeSet(x, "//AnalyzeTool//final_time")
  XML::xmlValue(nodes[[1]]) = end_time

  #solve_for_equilibrium_for_auxiliary_states
  nodes = XML::getNodeSet(x, "//AnalyzeTool//solve_for_equilibrium_for_auxiliary_states")
  XML::xmlValue(nodes[[1]]) = solve_for_equilibrium_for_auxiliary_states

  #maximum_number_of_integrator_steps
  nodes = XML::getNodeSet(x, "//AnalyzeTool//maximum_number_of_integrator_steps")
  XML::xmlValue(nodes[[1]]) = maximum_number_of_integrator_steps

  #maximum_integrator_step_size
  nodes = XML::getNodeSet(x, "//AnalyzeTool//maximum_integrator_step_size")
  XML::xmlValue(nodes[[1]]) = maximum_integrator_step_size


  #minimum_integrator_step_size
  nodes = XML::getNodeSet(x, "//AnalyzeTool//minimum_integrator_step_size")
  XML::xmlValue(nodes[[1]]) = minimum_integrator_step_size

  #integrator_error_tolerance
  nodes = XML::getNodeSet(x, "//AnalyzeTool//integrator_error_tolerance")
  XML::xmlValue(nodes[[1]]) = integrator_error_tolerance

  #external_loads_file
  nodes = XML::getNodeSet(x, "//AnalyzeTool//external_loads_file")
  XML::xmlValue(nodes[[1]]) = external_loads_file

  #coordinates_file
  nodes = XML::getNodeSet(x, "//AnalyzeTool//coordinates_file")
  XML::xmlValue(nodes[[1]]) = coordinates_file

  #lowpass_cutoff_frequency_for_coordinates
  nodes = XML::getNodeSet(x, "//AnalyzeTool//lowpass_cutoff_frequency_for_coordinates")
  XML::xmlValue(nodes[[1]]) = lowpass_cutoff_frequency_for_coordinates

  ###################   Analysis set, specifics to BK    ###############################
  #start_time
  nodes = XML::getNodeSet(x, "//AnalysisSet//objects//BodyKinematics//start_time")
  XML::xmlValue(nodes[[1]]) = start_time

  #end_time
  nodes = XML::getNodeSet(x, "//AnalysisSet//objects//BodyKinematics//end_time")
  XML::xmlValue(nodes[[1]]) = end_time

  #step_interval
  nodes = XML::getNodeSet(x, "//AnalysisSet//objects//BodyKinematics//step_interval")
  XML::xmlValue(nodes[[1]]) = step_interval

  #in_degrees
  nodes = XML::getNodeSet(x, "//AnalysisSet//objects//BodyKinematics//in_degrees")
  XML::xmlValue(nodes[[1]]) = in_degrees

  #bodies
  nodes = XML::getNodeSet(x, "//AnalysisSet//objects//BodyKinematics//bodies")
  XML::xmlValue(nodes[[1]]) = bodies

  #express_results_in_body_local_frame
  nodes = XML::getNodeSet(x, "//AnalysisSet//objects//BodyKinematics//express_results_in_body_local_frame")
  XML::xmlValue(nodes[[1]]) = express_results_in_body_local_frame

  #Write to file
  cat(XML::saveXML(x,
                   indent = TRUE,
                   #prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>",
                   encoding = "UTF-8"),
      file=(setup_filename))

}
