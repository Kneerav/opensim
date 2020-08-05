Setup_ceinms_execution = function(base_file = "ceinmsExecutionSetup_HYBRID_cal.xml",
                                 subjectFile = "Final_Calibrated_HYBRID",
                                 inputDataFile = "Gait_trial.xml",
                                 executionFile = "executionOL_elastic_HYBRID.xml",
                                 excitationGeneratorFile = "excitationGenerator.xml",
                                 outputDirectory = "Output",
                                 setup_filename = "ceinmsExecutionSetup_HYBRID_cal.xml"){
  
  
  #Read in default file
  x = XML::xmlParse(base_file)
  
  #set up root
  root = XML::xmlRoot(x)

  #subjectFile
  nodes = XML::getNodeSet(x, "//ceinms//subjectFile")
  XML::xmlValue(nodes[[1]]) = subjectFile
  
  #inputDataFile
  nodes = XML::getNodeSet(x, "//ceinms//inputDataFile")
  XML::xmlValue(nodes[[1]]) = inputDataFile
  
  #executionFile
  nodes = XML::getNodeSet(x, "//ceinms//executionFile")
  XML::xmlValue(nodes[[1]]) = executionFile
  
  #excitationGeneratorFile
  nodes = XML::getNodeSet(x, "//ceinms//excitationGeneratorFile")
  XML::xmlValue(nodes[[1]]) = excitationGeneratorFile
  
  #outputDirectory
  nodes = XML::getNodeSet(x, "//ceinms//outputDirectory")
  XML::xmlValue(nodes[[1]]) = outputDirectory
  
  #Write to file
  cat(XML::saveXML(x,
                   indent = TRUE,
                   #prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>",
                   encoding = "UTF-8"),
      file=(setup_filename))
  
}