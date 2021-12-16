#----
# read phenoscript with python functions to parse, translate and save
# then use these functions to convert it to owl
#
#---

#setwd("~/Documents/My_papers/Phenoscript_2021/Gryonoides/Phenoscript/example")

library(xml2)
library(dplyr)
library(stringr)
library(XML)
source('R/phsFunctions.R')


PhenoScriptToOWL <- function(PS, phs.namespace, onto.in, xml_instances.out, file.out){
  owl=init_phsXMLtoOWL(PS, phs.namespace)

  # check if xml_owl is ok
  cat('Checking if OWL is ok...\n')
  tmp <- saveXML(owl)
  owl.chk <- read_xml(tmp, options = c( "NOERROR"))
  cat('Saving instances only to... ', xml_instances.out, '\n')
  saveXML(owl, xml_instances.out)

  cat('Running ROBOT to merge OWL files...\n')
  #robot merge --input Gryonoides_merged_ontologies.owl --input xml_root.xml --output results/merged2.owl
  merge_onto <-paste0('robot merge --input ', onto.in, ' --input ', xml_instances.out, ' --output ', file.out)
  system(merge_onto)
  cat('DONE.\n')
}



init_phsXMLtoOWL <- function(PS, phs.namespace){

  doc = newXMLDoc( )
  root = newXMLNode('rdf:RDF',
                    namespace = phs.namespace,
                    attrs=c(xml="http://www.w3.org/XML/1998/namespace"),
                    parent=doc)



  #---------
  # The phsxml file PS should come with the declared namespaces
  # this namespaces should be inhered by the new XML
  # iri's are parsed accordingly due to thos namespaces




  #   ____________________________________________________________________________
  #   Create all nodes                                                        ####

  cat('Creating all instance nodes, this may take a while...\n')

  ns <- xmlNamespaceDefinitions(root)
  #print(ns)

  # get all nodes
  #xml_ns_strip(PS)
  allN <- xml_find_all(PS, ".//phs:node")
  un.id <- xml_attr(allN, attr='node_id') %>% unique()

  #-- for speeding up
  allN.node_id=xml_attr(allN, attr='node_id')
  #length(allN.node_id)
  date <-  Sys.Date()
  date <-str_replace_all(date, '-','.')
  #--

  # create all nodes (individuals)
  # library(profvis)
  # profvis({

  for (i in un.id){
  #for (i in un.id[1:100]){
    # i=un.id[1]
    #print(i)
    # i='1'

    #--------
    # x.all <- xml_find_all(PS, sprintf('.//*[@phs:node_id="%s"]', i)) # node id
    # x <- x.all[1]
    #x <-xml_find_first(PS, sprintf('.//*[@phs:node_id="%s"]', i))
    #x <-xml_find_all(PS, sprintf('.//phs:node[@phs:node_id="%s"]', i))[1]
    x <- allN[match(i, allN.node_id)]
    #--------

    ind <- newXMLNode("owl:NamedIndividual", attrs=c('rdf:about'=i), parent=root ) # define Ind
    #-- node label if no ["rdfs:label"="Gen Sp"] is provided then use iri for label
    rdfsLabel <- phs_get_nodeName(x)
    newXMLNode("rdfs:label", rdfsLabel, attrs=c('xml:lang'="en"), parent=ind) # label
    #newXMLNode("rdfs:label", basename(i), attrs=c('xml:lang'="en"), parent=ind) # label
    #--

    newXMLNode("oboI:created_by", 'Phenoscript', parent=ind)
    newXMLNode("oboI:creation_date", date, parent=ind)

    # only one class for the same iri
    newXMLNode("rdf:type", attrs=c('rdf:resource'=xml_attr(x, attr='iri')), parent=ind) # class of Ind

    #multiclasses for the same iri
    # for (j in x.all){
    #   newXMLNode("rdf:type", attrs=c('rdf:resource'=xml_attr(j, attr='iri')), parent=ind) # class of Ind
    # }

  }
  #}) #profvis



  ##  ............................................................................
  ##  Compile N E N: phs:node pos=1 -> E pos=2 -> (phs:node | phs:nested_node | phs:lis_node)  pos=3    ####

  cat('Adding edges between nodes...\n')

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

  cat('Adding edges between nested and list nodes...\n')

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


  ##  ............................................................................
  ##  Linking OTU and OPHUs    ####

  cat('Linking OTU model with OPHUs...\n')

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
      root <- otu2ophus(root=root, prop_source_i=prop_i, ophu_list_i=ophu_list_i, ns)
    }
  }

  cat('DONE.\n')
  #print(root)
  return(root)
} #---- END function

