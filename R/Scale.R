#' Run scale to compute joint angles
#'
#' Run scale to compute joint angles
#' @param opensim_path string containing path to opensim bin. Default is "C:/OpenSim 3.3/bin".
#' @param setup_file string containing path to xml setup file.
#' @return Output files will be prduced as identified in setup file.
#' @export
Scale = function(opensim_path = "C:/OpenSim 3.3/bin",
              setup_file){

  #Rewrite command to fix
  scale_path = paste0(opensim_path, "/scale")
  opensim_path = paste0('"', scale_path, '"')
  setup_file = paste0('"', setup_file, '"')

  #setup command
  CMD = paste0(opensim_path, ' -S ', setup_file)

  #run command through system
  cat(system(CMD, intern = FALSE, wait=TRUE, show.output.on.console = FALSE))

}