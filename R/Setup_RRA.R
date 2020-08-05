Setup_RRA = function(base_file = "Setup_RRA_base.xml",
                    model_file = "Model_SCALED.osim",
                    replace_force_set = "true",
                    force_set_files = "RRA_actuators.xml",
                    results_directory = ".",
                    output_precision = "12",
                    start_time,
                    end_time,
                    solve_for_equilibrium_for_auxiliary_states = "false",
                    maximum_number_of_integrator_steps = "20000",
                    maximum_integrator_step_size = "1",
                    minimum_integrator_step_size = "1e-05",
                    integrator_error_tolerance = "1e-05",
					desired_kinematics_file = "IK.mot",
					task_set_file = "RRA_Tasks.xml",
					lowpass_cutoff_frequency_for_coordinates = "8",
					optimizer_algorithm = "ipopt",
					numerical_derivative_step_size = "0.0001",
					optimization_convergence_tolerance = "1e-005",
					adjust_com_to_reduce_residuals = "true",
					initial_time_for_com_adjustment = "-1",
					final_time_for_com_adjustment = "-1",
					adjusted_com_body = "torso",
					output_model_file = "Model_Adjusted.osim",
					use_verbose_printing = "false",
          external_loads_file = "External_loads.xml",


                    setup_filename = "Setup_RRA.xml"){


  #Read in default file
  x = XML::xmlParse(base_file)

  #set up root
  root = XML::xmlRoot(x)

  #model_file
  nodes = XML::getNodeSet(x, "//RRATool//model_file")
  XML::xmlValue(nodes[[1]]) = model_file

  #replace_force_set
  nodes = XML::getNodeSet(x, "//RRATool//replace_force_set")
  XML::xmlValue(nodes[[1]]) = replace_force_set

  #force_set_files
  nodes = XML::getNodeSet(x, "//RRATool//force_set_files")
  XML::xmlValue(nodes[[1]]) = force_set_files

  #results_directory
  nodes = XML::getNodeSet(x, "//RRATool//results_directory")
  XML::xmlValue(nodes[[1]]) = results_directory

  #output_precision
  nodes = XML::getNodeSet(x, "//RRATool//output_precision")
  XML::xmlValue(nodes[[1]]) = output_precision

  #initial_time
  nodes = XML::getNodeSet(x, "//RRATool//initial_time")
  XML::xmlValue(nodes[[1]]) = start_time

  #final_time
  nodes = XML::getNodeSet(x, "//RRATool//final_time")
  XML::xmlValue(nodes[[1]]) = end_time

  #solve_for_equilibrium_for_auxiliary_states
  nodes = XML::getNodeSet(x, "//RRATool//solve_for_equilibrium_for_auxiliary_states")
  XML::xmlValue(nodes[[1]]) = solve_for_equilibrium_for_auxiliary_states

  #maximum_number_of_integrator_steps
  nodes = XML::getNodeSet(x, "//RRATool//maximum_number_of_integrator_steps")
  XML::xmlValue(nodes[[1]]) = maximum_number_of_integrator_steps

  #maximum_integrator_step_size
  nodes = XML::getNodeSet(x, "//RRATool//maximum_integrator_step_size")
  XML::xmlValue(nodes[[1]]) = maximum_integrator_step_size


  #minimum_integrator_step_size
  nodes = XML::getNodeSet(x, "//RRATool//minimum_integrator_step_size")
  XML::xmlValue(nodes[[1]]) = minimum_integrator_step_size

  #integrator_error_tolerance
  nodes = XML::getNodeSet(x, "//RRATool//integrator_error_tolerance")
  XML::xmlValue(nodes[[1]]) = integrator_error_tolerance

  #external_loads_file
  nodes = XML::getNodeSet(x, "//RRATool//external_loads_file")
  XML::xmlValue(nodes[[1]]) = external_loads_file

  #lowpass_cutoff_frequency_for_coordinates
  nodes = XML::getNodeSet(x, "//RRATool//lowpass_cutoff_frequency_for_coordinates")
  XML::xmlValue(nodes[[1]]) = lowpass_cutoff_frequency_for_coordinates

  ###################   Analysis set, specifics to RRA    ###############################
  #desired_kinematics_file
  nodes = XML::getNodeSet(x, "//RRATool//desired_kinematics_file")
  XML::xmlValue(nodes[[1]]) = desired_kinematics_file

  #task_set_file
  nodes = XML::getNodeSet(x, "//RRATool//task_set_file")
  XML::xmlValue(nodes[[1]]) = task_set_file

  #optimizer_algorithm
  nodes = XML::getNodeSet(x, "//RRATool//optimizer_algorithm")
  XML::xmlValue(nodes[[1]]) = optimizer_algorithm

  #numerical_derivative_step_size
  nodes = XML::getNodeSet(x, "//RRATool//numerical_derivative_step_size")
  XML::xmlValue(nodes[[1]]) = numerical_derivative_step_size

  #optimization_convergence_tolerance
  nodes = XML::getNodeSet(x, "//RRATool//optimization_convergence_tolerance")
  XML::xmlValue(nodes[[1]]) = optimization_convergence_tolerance

  #adjust_com_to_reduce_residuals
  nodes = XML::getNodeSet(x, "//RRATool//adjust_com_to_reduce_residuals")
  XML::xmlValue(nodes[[1]]) = adjust_com_to_reduce_residuals

  #initial_time_for_com_adjustment
  nodes = XML::getNodeSet(x, "//RRATool//initial_time_for_com_adjustment")
  XML::xmlValue(nodes[[1]]) = initial_time_for_com_adjustment

  #final_time_for_com_adjustment
  nodes = XML::getNodeSet(x, "//RRATool//final_time_for_com_adjustment")
  XML::xmlValue(nodes[[1]]) = final_time_for_com_adjustment

  #adjusted_com_body
  nodes = XML::getNodeSet(x, "//RRATool//adjusted_com_body")
  XML::xmlValue(nodes[[1]]) = adjusted_com_body

  #output_model_file
  nodes = XML::getNodeSet(x, "//RRATool//output_model_file")
  XML::xmlValue(nodes[[1]]) = output_model_file

  #use_verbose_printing
  nodes = XML::getNodeSet(x, "//RRATool//use_verbose_printing")
  XML::xmlValue(nodes[[1]]) = use_verbose_printing

  #Write to file
  cat(XML::saveXML(x,
                   indent = TRUE,
                   #prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>",
                   encoding = "UTF-8"),
      file=(setup_filename))

}
