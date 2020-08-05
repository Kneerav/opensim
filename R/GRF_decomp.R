#' Run ground reaction force decomposition
#'
#' Run ground reaction force decomposition
#' @param opensim_path string containing path to opensim 3.2 32-bit bin. Default is "C:/Program Files (x86)/OpenSim 3.2_32bit/bin".
#' @param plugin_path string containing path to GRF decomposition plugin. Default is "C:/Program Files (x86)/OpenSim 3.2_32bit/plugins/IndAccPI.dll".
#' @param setup_file string containing path to xml setup file.
#' @return Output files will be prduced as identified in setup file.
#' @export
GRF_decomp = function(opensim_path = "C:/Program Files (x86)/OpenSim 3.2/bin",
                   plugin_path = "C:/Program Files (x86)/OpenSim 3.2/plugins/IndAccPI.dll",
                   setup_file){

  #Rewrite command to fix
  analyze_path = paste0(opensim_path, "/analyze")
  opensim_path = paste0('"', analyze_path, '"')
  setup_file = paste0('"', setup_file, '"')
  plugin_path = paste0('"', plugin_path, '"')

  #setup command
  CMD = paste0(opensim_path, ' -L ', plugin_path, ' -S ', setup_file)

  #run command through system
  cat(system(CMD, intern = FALSE, wait=TRUE, show.output.on.console = FALSE))

}