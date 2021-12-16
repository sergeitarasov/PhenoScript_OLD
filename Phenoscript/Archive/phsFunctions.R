#----
# ns <- xmlNamespaceDefinitions(root)
# uri <- "http://purl.obolibrary.org/obo/AISM_0000003"
# makeBasePrefix(uri, ns)
# "http://purl.obolibrary.org/obo/AISM_0000003" converts to "obo:AISM_0000003"
#makeBasePrefix(uri=e.iri, ns)
makeBasePrefix <- function(uri, ns){

  ns.uri <- lapply(ns, function(x) x$uri ) %>% unlist
  # ns.uri <- ns.uri[-1]
  # substract strings
  rem <- stringr::str_remove(uri, ns.uri)
  # filter out identities
  y <- rem!=uri
  if (all(!y)) {stop("Namespace in not declared. Declare it.\n")}
  pref=names(ns.uri)[y]
  base=rem[y]

  # in case of duplicates select the shortest
  ln=lapply(str_split(base,  ''), function(x) length(x)) %>% unlist
  base=base[ln==min(ln)]
  pref=pref[ln==min(ln)]

  return(paste0(pref,':', base))
}

#returns node value if its text has "rdfs:label"
phs_get_rdfs_label <- function(node){
  props <- xml_find_all(node, './/phs:node_property')
  rdfs_label <- props[xml_text(props)=="rdfs:label"]
  rdfs_label <- xml_attr(rdfs_label, "value")
  return(rdfs_label)
}

# Returns rdfs:labels if its specified, otherwise uses iri
# node <- x


phs_get_nodeName <- function(node, sep=':'){
  rdfs_label <- phs_get_rdfs_label(node)
  if (length(rdfs_label)==0){
    out <- xml_attr(node, "node_id")
    out <- basename(out)

    class <- xml_attr(node, attr='node_name')
    out <-paste0(class,sep, out)

  } else if (length(rdfs_label)==1){
    out <- rdfs_label
  } else {
    cat("Error in phs_get_nodeName()")
  }
  return(out)
}

# type for numeric node
numNodeType <- function(N3){
  tp.list <- list(
    real="http://www.w3.org/2001/XMLSchema#float",
    int="http://www.w3.org/2001/XMLSchema#integer"
  )
  tp <- xml_attr(N3, 'numeric_type')
  tp.list[tp][[1]]
}

#-----


make_rdfDescription <- function(xml.root, assertion, source, edge, target){
  # <rdf:Description>
  #   <rdf:type rdf:resource="http://www.w3.org/2002/07/owl#NegativePropertyAssertion"/>
  #   <owl:sourceIndividual rdf:resource="https://orcid.org/0000-0001-5237-2330/_auto_3"/>
  #   <owl:assertionProperty rdf:resource="http://purl.obolibrary.org/obo/BFO_0000051"/>
  #   <owl:targetIndividual rdf:resource="https://orcid.org/0000-0001-5237-2330/_auto_4"/>
  # </rdf:Description>

  descr <- newXMLNode('rdf:Description', parent=xml.root )
  newXMLNode('rdf:type',  attrs=c('rdf:resource'=assertion), parent=descr )
  newXMLNode('owl:sourceIndividual',  attrs=c('rdf:resource'=source), parent=descr )
  newXMLNode('owl:assertionProperty',  attrs=c('rdf:resource'=edge), parent=descr )
  newXMLNode('owl:targetIndividual',  attrs=c('rdf:resource'=target), parent=descr )
  return(descr)
}


# This function take a property node i with to_Ophu_List, finds its parent (eg organism) and links it with the set of ophus
#
# otu2ophus(root=root, prop_source_i=prop_source_nodes[1], ophu_list_i=ophu_list_i)
otu2ophus <- function(root, prop_source_i, ophu_list_i){

  # get a parent of the prop node
  prop_parent <-xml_parent(prop_source_i)
  prop_parent_iri <-xml_attr(prop_parent, 'node_id')
  source <- getNodeSet(root, sprintf('.//owl:NamedIndividual[@rdf:about="%s"]', prop_parent_iri) )[[1]]

  e.iri <- xml_attr(prop_source_i, "iri")
  e.iri <- makeBasePrefix(e.iri, ns)

  # ophus
  ophuL <-xml_find_all(ophu_list_i, './/phs:node')

  # now link source ie otus with ophus
  for (j in ophuL){
    # print(j)
    # j=ophuL[1]
    newXMLNode(e.iri, attrs=c('rdf:resource'=xml_attr(j, 'node_id')), parent=source )
  }
  return(root)
}

