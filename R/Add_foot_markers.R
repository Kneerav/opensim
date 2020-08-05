#' Add foot markers for GRF decomposition
#'
#' Add foot markers for GRF decomposition
#' @param model_file string containing initial model name. Must end in ".osim".
#' @param output_model_file string containing final model name. Must end in ".osim".
#' @param r_fp_heel1 string containing location of right heel marker 1 in caln reference frame. Must be in format "X Y Z". Default is "0.01 0 -0.05".
#' @param r_fp_heel2 string containing location of right heel marker 2 in caln reference frame. Must be in format "X Y Z". Default is "0 0 0.03".
#' @param r_fp_mt1 string containing location of right mt marker 1 in caln reference frame. Must be in format "X Y Z". Default is "0.135 0 0.07".
#' @param r_fp_mt2 string containing location of right mt marker 2 in caln reference frame. Must be in format "X Y Z". Default is "0.205 0 -0.05".
#' @param r_fp_toe string containing location of right toe marker in caln reference frame. Must be in format "X Y Z". Default is "0.275 0 0.02".
#' @param l_fp_heel1 string containing location of left heel marker 1 in caln reference frame. Must be in format "X Y Z". Default is "0.01 0 0.05".
#' @param l_fp_heel2 string containing location of left heel marker 2 in caln reference frame. Must be in format "X Y Z". Default is "0 0 -0.03".
#' @param l_fp_mt1 string containing location of left mt marker 1 in caln reference frame. Must be in format "X Y Z". Default is "0.135 0 -0.07".
#' @param l_fp_mt2 string containing location of left mt marker 2 in caln reference frame. Must be in format "X Y Z". Default is "0.205 0 0.05".
#' @param l_fp_toe string containing location of left toe marker in caln reference frame. Must be in format "X Y Z". Default is "0.275 0 -0.02".
#' @return OpenSim model with new markers appended.
#' @export
Add_foot_markers = function(model_file,
                            output_model_file,
                            r_fp_heel1 = "0.01 0 -0.05",
                            r_fp_heel2 = "0 0 0.03",
                            r_fp_mt1 = "0.135 0 0.07",
                            r_fp_mt2 = "0.205 0 -0.05",
                            r_fp_toe = "0.275 0 0.02",
                            l_fp_heel1 = "0.01 0 0.05",
                            l_fp_heel2 = "0 0 -0.03",
                            l_fp_mt1 = "0.135 0 -0.07",
                            l_fp_mt2 = "0.205 0 0.05",
                            l_fp_toe = "0.275 0 -0.02"){

  #Read data
  x = XML::xmlParse(model_file)

  #set up data to add markers
  root = XML::xmlRoot(x)
  nodes = XML::getNodeSet(x, "//MarkerSet//objects")
  nodes2 = XML::getNodeSet(x, "//MarkerSet//objects//Marker")


  #Add markers
  Marker_R1 = XML::newXMLNode("Marker", parent = nodes)
  XML::newXMLNode("calcn_r",  name = "body", parent = Marker_R1)
  XML::newXMLNode(r_fp_heel1,  name = "location", parent = Marker_R1)
  XML::newXMLNode("false",  name = "fixed", parent = Marker_R1)
  XML::addAttributes(Marker_R1, name="r_fp_heel1")

  Marker_R2 = XML::newXMLNode("Marker", parent = nodes)
  XML::newXMLNode("calcn_r",  name = "body", parent = Marker_R2)
  XML::newXMLNode(r_fp_heel2,  name = "location", parent = Marker_R2)
  XML::newXMLNode("false",  name = "fixed", parent = Marker_R2)
  XML::addAttributes(Marker_R2, name="r_fp_heel2")

  Marker_R3 = XML::newXMLNode("Marker", parent = nodes)
  XML::newXMLNode("calcn_r",  name = "body", parent = Marker_R3)
  XML::newXMLNode(r_fp_mt1,  name = "location", parent = Marker_R3)
  XML::newXMLNode("false",  name = "fixed", parent = Marker_R3)
  XML::addAttributes(Marker_R3, name="r_fp_mt1")

  Marker_R4 = XML::newXMLNode("Marker", parent = nodes)
  XML::newXMLNode("calcn_r",  name = "body", parent = Marker_R4)
  XML::newXMLNode(r_fp_mt2,  name = "location", parent = Marker_R4)
  XML::newXMLNode("false",  name = "fixed", parent = Marker_R4)
  XML::addAttributes(Marker_R4, name="r_fp_mt2")

  Marker_R5 = XML::newXMLNode("Marker", parent = nodes)
  XML::newXMLNode("calcn_r",  name = "body", parent = Marker_R5)
  XML::newXMLNode(r_fp_toe,  name = "location", parent = Marker_R5)
  XML::newXMLNode("false",  name = "fixed", parent = Marker_R5)
  XML::addAttributes(Marker_R5, name="r_fp_toe")

  Marker_L1 = XML::newXMLNode("Marker", parent = nodes)
  XML::newXMLNode("calcn_l",  name = "body", parent = Marker_L1)
  XML::newXMLNode(l_fp_heel1,  name = "location", parent = Marker_L1)
  XML::newXMLNode("false",  name = "fixed", parent = Marker_L1)
  XML::addAttributes(Marker_L1, name="l_fp_heel1")

  Marker_L2 = XML::newXMLNode("Marker", parent = nodes)
  XML::newXMLNode("calcn_l",  name = "body", parent = Marker_L2)
  XML::newXMLNode(l_fp_heel2,  name = "location", parent = Marker_L2)
  XML::newXMLNode("false",  name = "fixed", parent = Marker_L2)
  XML::addAttributes(Marker_L2, name="l_fp_heel2")

  Marker_L3 = XML::newXMLNode("Marker", parent = nodes)
  XML::newXMLNode("calcn_l",  name = "body", parent = Marker_L3)
  XML::newXMLNode(l_fp_mt1,  name = "location", parent = Marker_L3)
  XML::newXMLNode("false",  name = "fixed", parent = Marker_L3)
  XML::addAttributes(Marker_L3, name="l_fp_mt1")

  Marker_L4 = XML::newXMLNode("Marker", parent = nodes)
  XML::newXMLNode("calcn_l",  name = "body", parent = Marker_L4)
  XML::newXMLNode(l_fp_mt2,  name = "location", parent = Marker_L4)
  XML::newXMLNode("false",  name = "fixed", parent = Marker_L4)
  XML::addAttributes(Marker_L4, name="l_fp_mt2")

  Marker_L5 = XML::newXMLNode("Marker", parent = nodes)
  XML::newXMLNode("calcn_l",  name = "body", parent = Marker_L5)
  XML::newXMLNode(l_fp_toe,  name = "location", parent = Marker_L5)
  XML::newXMLNode("false",  name = "fixed", parent = Marker_L5)
  XML::addAttributes(Marker_L5, name="l_fp_toe")

  cat(XML::saveXML(x,
                   indent = TRUE,
                   prefix = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"),
      file=(output_model_file))
}
