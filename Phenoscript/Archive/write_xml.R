#----
# read phenoscript with read.py to parse, translate and save
# then use this script to convert it to owl
#
#---


library(xml2)
library(dplyr)
library(stringr)
library(XML)
source('phsFunctions.R')

setwd("~/Documents/My_papers/Phenoscript_2021/Gryonoides/Phenoscript/example")



#---
#---------

# doc = newXMLDoc( namespace =c(obo="http://purl.obolibrary.org/obo/", rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#",
#                               owl="http://www.w3.org/2002/07/owl#", rdfs="http://www.w3.org/2000/01/rdf-schema#", xml="http://www.w3.org/XML/1998/namespace"))

doc = newXMLDoc( )
root = newXMLNode('rdf:RDF',
                  namespace =c('obo'="http://purl.obolibrary.org/obo/",
                               rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#",
                               'owl'="http://www.w3.org/2002/07/owl#",
                              rdfs="http://www.w3.org/2000/01/rdf-schema#",
                               sta ="https://orcid.org/0000-0001-5237-2330/",
                              'oboI'="http://www.geneontology.org/formats/oboInOwl#",
                              'newT'="http://github.com/sergeitarasov/PhenoScript/gryo/",
                              'pato'="http://purl.obolibrary.org/obo/pato#"
                              ),
                  attrs=c(xml="http://www.w3.org/XML/1998/namespace"),
                  parent=doc)



#---------
# The phsxml file PS should come with the declared namespaces
# this namespaces should be inhered by the new XML
# iri's are parsed accordingly due to thos namespaces

#PS <- read_xml("ex1_transl_test.xml")
PS <- read_xml("Gryo_trans.xml")
print(PS)


#   ____________________________________________________________________________
#   Create all nodes                                                        ####

ns <- xmlNamespaceDefinitions(root)

# get all nodes
allN <- xml_find_all(PS, ".//phs:node")
un.id <- xml_attr(allN, attr='node_id') %>% unique()

# create all nodes (individuals)
for (i in un.id){
  # i=un.id[1]
  #print(i)
  # i='1'
  x.all <- xml_find_all(PS, sprintf('.//*[@phs:node_id="%s"]', i)) # node id
  x <- x.all[1]
  ind <- newXMLNode("owl:NamedIndividual", attrs=c('rdf:about'=i), parent=root ) # define Ind

  #-- node label if no ["rdfs:label"="Gen Sp"] is provided then use iri for label
  rdfsLabel <- phs_get_nodeName(x)
  newXMLNode("rdfs:label", rdfsLabel, attrs=c('xml:lang'="en"), parent=ind) # label
  #newXMLNode("rdfs:label", basename(i), attrs=c('xml:lang'="en"), parent=ind) # label
  #--

  newXMLNode("oboI:created_by", 'Phenoscript', parent=ind)
  date <-  Sys.Date()
  date <-str_replace_all(date, '-','.')
  newXMLNode("oboI:creation_date", date, parent=ind)

  # only one class for the same iri
  #newXMLNode("rdf:type", attrs=c('rdf:resource'=xml_attr(x, attr='iri')), parent=ind) # class of Ind

  #multiclasses for the same iri
  for (j in x.all){
    newXMLNode("rdf:type", attrs=c('rdf:resource'=xml_attr(j, attr='iri')), parent=ind) # class of Ind
  }

}

print(PS)


# root

##  ............................................................................
##  Compile N E N: phs:node pos=1 -> E pos=2 -> (phs:node | phs:nested_node | phs:lis_node)  pos=3    ####


# select node triple_pos=1
N1 <- xml_find_all(PS, './/phs:node[@phs:triple_pos="1"]')
# select unique names for node triple_pos=1
un.N1 <- xml_attr(N1, attr='node_id') %>% unique()

# make N E N
for (n_id in un.N1){
  # this should be nexted!!!
  #print(i)
  # n_id=un.N1[6]

  #get nodes with the same id N1j pos=1
  N1j <- N1[xml_attr(N1, attr='node_id')==n_id] #xml_find_all(N1, sprintf('.//phs:node[@phs:node_id="%s"]', n_id) )

  for (j in N1j){
    # j=N1j[1]
    sibs <- xml_siblings(j)
    N3 <- sibs[xml_attr(sibs, 'triple_pos')==3]
    Ed <- sibs[xml_attr(sibs, 'triple_pos')==2]

    if (xml_name(N3)=='node'){

      neg.edge <- as.logical(xml_attr(Ed, 'negative_prop'))

      # check if edge is ! or not ! and make asserions
      if (neg.edge==FALSE){
        node.id <- xml_attr(j, 'node_id')
        target <- getNodeSet(root, sprintf('.//owl:NamedIndividual[@rdf:about="%s"]', node.id) )[[1]]
        e.iri <- xml_attr(Ed, 'iri')
        # convert to pref:iri
        e.iri <- makeBasePrefix(e.iri, ns)
        xx <- newXMLNode(e.iri, attrs=c('rdf:resource'=xml_attr(N3, 'node_id')), parent=target )

      } else if (neg.edge==TRUE){
        node.id <- xml_attr(j, 'node_id')
        tar <- xml_attr(N3, 'node_id')
        e.iri <- xml_attr(Ed, 'iri')
        make_rdfDescription(xml.root=root, assertion="http://www.w3.org/2002/07/owl#NegativePropertyAssertion",
                            source=node.id, edge=e.iri, target=tar)
      } else {
        cat('Error in negative edge handlling \n')
      }

    } else if (xml_name(N3)=='nested_node') {
      node.id <- xml_attr(j, 'node_id')
      target <- getNodeSet(root, sprintf('.//owl:NamedIndividual[@rdf:about="%s"]', node.id) )[[1]]
      e.iri <- xml_attr(Ed, 'iri')
      # convert to pref:iri
      e.iri <- makeBasePrefix(e.iri, ns)

      # get all children from N3
      N3kids <- xml_find_all(N3, './/phs:node')
      for (kid in N3kids){
        # kid=N3kids[1]
        newXMLNode(e.iri, attrs=c('rdf:resource'=xml_attr(kid, 'node_id')), parent=target )
      } # end if


    } else if (xml_name(N3)=='list_node') {
      node.id <- xml_attr(j, 'node_id')
      target <- getNodeSet(root, sprintf('.//owl:NamedIndividual[@rdf:about="%s"]', node.id) )[[1]]
      e.iri <- xml_attr(Ed, 'iri')
      # convert to pref:iri
      e.iri <- makeBasePrefix(e.iri, ns)

      # get all children from N3
      N3kids <- xml_find_all(N3, './/phs:node')
      for (kid in N3kids){
        # kid=N3kids[1]
        newXMLNode(e.iri, attrs=c('rdf:resource'=xml_attr(kid, 'node_id')), parent=target )
      } # end if

    } else if (xml_name(N3)=='numeric_node'){
      node.id <- xml_attr(j, 'node_id')
      target <- getNodeSet(root, sprintf('.//owl:NamedIndividual[@rdf:about="%s"]', node.id) )[[1]]
      e.iri <- xml_attr(Ed, 'iri')
      # convert to pref:iri
      e.iri <- makeBasePrefix(e.iri, ns)
      num <- xml_attr(N3, 'node_name')
      xx <- newXMLNode(e.iri, num, attrs=c('rdf:datatype'=numNodeType(N3)), parent=target )

    } else {
      cat('Invalid Input \n')
    }

  }
}




##  ............................................................................
##  Compile N E N: (phs:nested_node | phs:lis_node) pos=1 -> E pos=2 -> (phs:node | phs:nested_node | phs:lis_node) pos=3    ####

# select node triple_pos=1
#N1 <- xml_find_all(PS, './/phs:node[@phs:triple_pos="1"]')
NNL <- xml_find_all(PS, './/phs:nested_node[@phs:triple_pos="1"] | //phs:list_node[@phs:triple_pos="1"]')

for (nnli in NNL){
  # nnli=NNL[1]
  sibs <- xml_siblings(nnli)
  N3 <- sibs[xml_attr(sibs, 'triple_pos')==3]
  Ed <- sibs[xml_attr(sibs, 'triple_pos')==2]

  # get all children from N1
  N1kids <- xml_find_all(nnli, './/phs:node')

  for (kid in N1kids){
    # kid=N1kids[1]
    node.id <- xml_attr(kid, 'node_id')
    target <- getNodeSet(root, sprintf('.//owl:NamedIndividual[@rdf:about="%s"]', node.id) )[[1]]
    e.iri <- xml_attr(Ed, 'iri')
    # convert to pref:iri
    e.iri <- makeBasePrefix(e.iri, ns)
    newXMLNode(e.iri, attrs=c('rdf:resource'=xml_attr(N3, 'node_id')), parent=target )
  } # end for

}


# END



##  ............................................................................
##  Linking OTU and OPHUs    ####

otu_object <- xml_find_all(PS, './/phs:otu_object')

# loop over otu_objects ie species. in each otu_obj identify nodes that link all ophus
for (i in otu_object){
  #i <- otu_object[1]
  # get all phs:node_property
  otu_obj_i_props <- xml_find_all(i, './/phs:otu_properties//phs:node_property')
  prop_source_nodes <- otu_obj_i_props[xml_text(otu_obj_i_props)=="to_Ophu_List"]

  # the tarfet ophus
  ophu_list_i <- xml_find_all(i, './/phs:ophu_list')

  # for each propoerty node  in prop_source_nodes
  for (prop_i in prop_source_nodes){
    # This function take a property node i with to_Ophu_List, finds its parent (eg organism) and links it with the set of ophus
    root <- otu2ophus(root=root, prop_source_i=prop_i, ophu_list_i=ophu_list_i)
  }

}



# # get all phs:node_property
# props <- xml_find_all(PS, './/phs:node_property')
# # get those node_property nodes that have text to_Ophu_List
# nodes2ophus <- props[xml_text(props)=="to_Ophu_List"]
# # get their parents that should be linked with ouåhus
# nodes2ophus_parent <-xml_parent(nodes2ophus)
#
# # get ophuList
# ophuL <- xml_find_all(PS, './/phs:ophu_list')
# # get all odes of  ophuList
# ophuL <-xml_find_all(ophuL, './/phs:node')
# #ophuL.id <- xml_attr(ophuL, attr='node_id')
# #ophuL_NodeSet <- getNodeSet(root, sprintf('.//owl:NamedIndividual[@rdf:about="%s"]', ophuL.id ) )
#
# # for all nodes that have prop. to_Ophu_List
# for (i in 1:length(nodes2ophus)){
#   # i=1
#   from.node <- nodes2ophus_parent[i]
#   node.id <- xml_attr(from.node, 'node_id')
#
#   target <- getNodeSet(root, sprintf('.//owl:NamedIndividual[@rdf:about="%s"]', node.id) )[[1]]
#   e.iri <- xml_attr(nodes2ophus[i], "iri")
#   e.iri <- makeBasePrefix(e.iri, ns)
#
#   # for each node from Ophu list make edges to corresponding OTU nodes
#   for (j in ophuL){
#     # print(j)
#     # j=ophuL[1]
#     newXMLNode(e.iri, attrs=c('rdf:resource'=xml_attr(j, 'node_id')), parent=target )
#   }
#
# }




#------
print(root)
#XML::saveXML(root, file='xml_IND.xml')


#--- merge indv with onto usning xml2
tmp <- saveXML(root)
my_ind <- read_xml(tmp, options = c( "NOERROR"))
saveXML(root, 'xml_root.xml')
#my_ind <-read_xml('xml_root.xml')


#onto <- read_xml("aism_instances.xml")
#onto <- read_xml("../phsDictionary/looofasz.owl")
onto <- read_xml("../phsDictionary/Gryonoides_merged_ontologies.owl")


doc2children <- xml_children(my_ind)

for (child in doc2children) {
  xml_add_child(onto, child)
}

#onto
#write_xml(onto, file='aism_new1.owl')
write_xml(onto, file='Gryo_out.owl')

