Merge_forces_files = function(opensim_forces,
                              CEINMS_forces,
                              inverse_dynamics,
                              CEINMS_torques){
  
  #read in relevent data
  Forces_SO = opensim::read.mot.sto(opensim_forces)
  Forces_CEINMS = opensim::read.mot.sto(CEINMS_forces)
  ID = opensim::read.mot.sto(inverse_dynamics)
  Torques_CEINMS = opensim::read.mot.sto(CEINMS_torques)
  
  #Remove last column
  Forces_CEINMS = Forces_CEINMS[,-ncol(Forces_CEINMS)]
  Forces_SO = Forces_SO[,-ncol(Forces_SO)]
  
  #plot data to see difference
  require(ggplot2); require(dplyr)
  Plot_SO = Forces_SO[,colnames(Forces_CEINMS)]
  Plot_data = rbind.data.frame(Forces_CEINMS, Plot_SO)
  Plot_data = cbind.data.frame(Plot_data, Optimiser = rep(c("CEINMS", "OpenSim"), each=nrow(Forces_CEINMS)))
  Plot_data = reshape2::melt(Plot_data, "id.vars" = c("time", "Optimiser"))
  
  P1 = ggplot(data = Plot_data, aes(time, value, col=Optimiser, lty=Optimiser))+geom_line(lwd=2)+facet_wrap(.~variable, scales = "free")
  
  #Now merge new muscle force data and replot to ensure match
  Forces_SO[,colnames(Forces_CEINMS)] <- Forces_CEINMS
  
  Plot_SO = Forces_SO[,colnames(Forces_CEINMS)]
  Plot_data = rbind.data.frame(Forces_CEINMS, Plot_SO)
  Plot_data = cbind.data.frame(Plot_data, Optimiser = rep(c("CEINMS", "OpenSim"), each=nrow(Forces_CEINMS)))
  Plot_data = reshape2::melt(Plot_data, "id.vars" = c("time", "Optimiser"))
  
  P2 = ggplot(data = Plot_data, aes(time, value, col=Optimiser, lty=Optimiser))+geom_line(lwd=2)+facet_wrap(.~variable, scales = "free")
  
  #Now let's compute reserves for actuated DOFs
  
  #first find matching names in CEINMS by appending _moment
  matching_names = stringr::str_replace(colnames(Torques_CEINMS), "$", "_moment")
  
  #then create clipped ID file with data only relevent moments, clip torque to eliminate time and last col
  ID_clipped = ID[,matching_names[-c(1,length(matching_names))]]
  Torques_CEINMS_clipped = Torques_CEINMS[,-c(1, ncol(Torques_CEINMS))]
  
  #compute reserves and rename to match SO file
  Reserves = ID_clipped - Torques_CEINMS_clipped
  colnames(Reserves) = stringr::str_replace(colnames(Reserves), "_moment$", "_reserve")
  
  #merge with so file
  Forces_SO[,colnames(Reserves)] = Reserves
  
  #now return the data ############################# UPDATE this so it only returns the forces_file (or writes to file))
  Full_results = list(Forces_SO, P1, P2)
  return(Full_results)
}






