#' Run ceinms calibration
#'
#' Run ceinms calibration
#' @param ceinms_path string containing path to ceinms bin. Default is "C:/CEINMS 0.10/bin".
#' @param setup_file string containing path to xml setup file.
#' @param wait if TRUE, R console will wait until calibration is finished.
#' @return Output files will be prduced as identified in setup file.
#' @export
CEINMSexecute = function(ceinms_path = "C:/Program Files/CEINMS 0.10/bin",
              setup_file,
              wait = TRUE){
  
  #Rewrite command to fix
  calibrate_path = paste0(ceinms_path, "/ceinms")
  ceinms_path = paste0('"', calibrate_path, '"')
  setup_file = paste0('"', setup_file, '"')
  
  #setup command
  CMD = paste0(ceinms_path, ' -S ', setup_file)
  
  #run command through system
  cat(system(CMD, intern = FALSE, wait=wait, show.output.on.console = FALSE))
  
}
