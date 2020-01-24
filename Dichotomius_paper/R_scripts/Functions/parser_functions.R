library("stringr")
library("minilexer")

Manchester.pattern <- c(
  number      = "-?\\d*\\.?\\d+",
  
  name.dot        = "\\w+\\.",
  
  name        = "\\w+-\\w+",
  name        = "\\w+",
  
  equals      = "==",
  assign      = "<-|=",
  plus        = "\\+",
  lbracket    = "\\(",
  rbracket    = "\\)",
  newline     = " \n",
  newline     = "\n",
  newline     = "\n ",
  newline     = " \n ",
  whitespace  = "\\s+",
  
  and  = "\\&",
  or  = "\\|",
  comma  = ","
  #dot  = "\\."
)


#' Title Translate words to URIs in Manchester descriptions
#'
#' @param desc.str description string
#' @param ont.names mapping terms->URIs
#' @param Manchester.pattern Pattern
#'
#' @return
#' @export
#'
#' @examples

#desc.str <- desc.str1
#translate2URIs(desc.str1, ont.names, Manchester.pattern)
# translate2URIs <- function(desc.str, ont.names, Manchester.pattern){
#   
#   desc.str <-gsub('\n', '', desc.str)
#   desc.str <-strsplit(desc.str, '\\{')
#   desc.str <-desc.str[[1]][-1]
#   desc.str <-strsplit(desc.str, '\\}')
#   
#   sp_descr <- lapply(desc.str, function(x) strsplit(x[2], ';')[[1]] )
#   sp_names <- lapply(desc.str, function(x) x[1] )
#   
#   sp_descr <- lapply(sp_descr, function(x) lapply(x, function(y) lex(y, Manchester.pattern) )  )
#   
#   sp_descr <-lapply(sp_descr, function(x) lapply(x, function(y) token2onto_ids(y, ont.names) )  )
#   
#   sp_descr <-lapply(sp_descr, function(x) unlist(x)  )
#   names(sp_descr) <- unlist(sp_names)
#   
#   # remove white at the beginning
#   sp_descr <-lapply(sp_descr, function(x) trimws(x) )
#   
#   return(sp_descr)
#   
# }

#desc.str <- Manch
translate2URIs_oneToken <- function(desc.str, ont.names, Manchester.pattern){

  sp_descr <-lex(desc.str, Manchester.pattern)
  sp_descr <-token2onto_ids(sp_descr, ont.names)
  
  return(sp_descr)
  
}


# translate words into onto ids
#ont.names <-ont.transl
#one_token <- sp_descr
token2onto_ids <- function(one_token, ont.names){
  PP <- ont.names[match(one_token, ont.names)]
  PPp <- which(PP==one_token)
  one_token[PPp] <- names(PPp)

  # remove new lines to space
  rem <- which(names(one_token)=='newline')
  one_token[rem]<- ' '
  names(one_token)[rem]<- 'whitespace'

  out <- paste0(one_token, collapse='')

  return(out)
}





#   ____________________________________________________________________________
#   Make objects for OWLREADY                                               ####

# class_id <- 'Tt_1'
# subclass_of <- 'onto.Phens'
# def <- D1[[1]][1]
# py_make_class(class_id='Test_1', subclass_of='onto.Phens', restriction='is_a', def=D1[[1]][1])

py_make_class <- function(class_id, subclass_of, restriction='is_a', def){
  paste0(
    'class ', class_id, '(', subclass_of, '): ',
    restriction, ' =[', def, ']'
  )
}


# defs <- D1
# class_prefix <- 'Trait_ex_'
# CLs <- py_make_class_batch(class_prefix='Trait_ex_', subclass_of='onto.Phens', restriction='is_a', defs=D1)

py_make_class_batch <- function(class_prefix, subclass_of, restriction='is_a', defs){
  
  out <- list()
  i <-1 
  j <- 1
  for (i in 1:length(defs)){
    for (j in 1:length(defs[[i]])){
      pref <- paste0(class_prefix, j, '_', names(defs[i]))
      out[[pref]] <- py_make_class(class_id=pref, subclass_of=subclass_of, restriction=restriction, def=defs[[i]][j])
    }
  }
  return(out) 
}


#dt <- "=3int" 
#dt <- ">3int"
parse_dataType <- function(dt){
  
  DataType.pattern1 <- c(
    number      = "-?\\d*\\.?\\d+",
    xsd.type        = "\\w+",
    math = '>=',
    math = '<=',
    math = '>',
    math = '<',
    math = '=',
    comma=","
    
  )
  
  DataType.pattern2 <- c(
    number      = "-?\\d*\\.?\\d+",
    xsd.type        = "\\w+",
    min_inclusive = '>=',
    max_inclusive = '<=',
    min_exclusive = '>',
    max_exclusive = '<',
    equals = '=',
    comma=","
    
  )
  
  pars1 <- lex(dt, DataType.pattern1)
  pars2 <- lex(dt, DataType.pattern2)
  
  # get math
  math <- pars2[which(names(pars1)=='math')] %>% names(.)
  vals <- pars2[which(names(pars1)=='math')+1]
  vals.final <- paste0('"', 'xsd:', math, '"', ":") %>% paste0(., ' ', vals )
  
  xsd.type <- pars2[which(names(pars1)=='xsd.type')]
  type <-paste0('"', "xsd:", xsd.type, '"') %>% paste0('"@type":', .)
  
  # Combine
  #length(vals.final)
  out <- c(type, vals.final) %>% paste0(., collapse = ', ')
  return(out)
}




#   ____________________________________________________________________________
#   PhenoScript                                                             ####

PhenoScript.pattern <- c(
  
  exact.num = "==(-?\\d*\\.?\\d+)",
  data.type   = "<?>?=?-?\\d*\\.?\\d+,?<?>?=?-?\\d*\\.?\\d+\\w+",
  data.type   = "<?>?=?-?\\d*\\.?\\d+,?\\w+",
  
  number      = "-?\\d*\\.?\\d+",
  
  reserved = 'not',
  reserved = 'Not',
  reserved = 'some',
  reserved = 'only',
  reserved = 'exactly',
  reserved = 'min',
  reserved = 'max',
  
  word.dot    = "\\w+\\.",
  word        = "\\w+-\\w+",
  word        = "\\w+",
  
  
  #equals      = "==",
  #assign      = "<-|=",
  plus        = "\\+",
  lbracket    = "\\(",
  rbracket    = "\\)",
  newline     = " \n",
  newline     = "\n",
  newline     = "\n ",
  newline     = " \n ",
  whitespace  = "\\s+",
  
  and  = "\\&",
  or  = "\\|",
  comma=","
  #dot  = "\\."
)

#lex(ophu, PhenoScript.pattern)


#xsd:integer[>= 0 , <= 20]
#rdflib::rdf_parse('json1.txt', "jsonld")

# x ≥ minimum
# x > exclusiveMinimum
# x ≤ maximum
# x < exclusiveMaximum

#ophu <- 'clypeus has_part.(anterior_region has_component.(exactly(==12 tooth)))'
PhenSci2json <- function(ophu, reserved.words.namespace='owl:', prop.namespace='obo:', id.prefix = '_test_', 
                         brackets.new = c('{', '}') ){
  
  pars.out <- lex(ophu, PhenoScript.pattern)
  
  pars.new <- pars.out
  #pars.new <-gsub('\\.', '', pars.new)
  pars.new[names(pars.new )=="word.dot"] <- gsub('\\.', '', pars.new[names(pars.new )=="word.dot"])
  pars.new.names <-names(pars.new )
  
  #-- SO rendering
  # generate ids
  n.SO <- which(pars.new.names=='word') %>% length()
  id.SO <- paste0(id.prefix, c(1:n.SO) )
  
  loc.SO <- which(pars.new.names=='word')
  
  # making @type
  type.at <- paste0('"', pars.new[loc.SO], '"') %>% paste0('"@type":', .)
  
  # making @id
  id.at <-paste0('"', id.SO, '"') %>% paste0('"@id":', .)
  
  # making @id and @type
  id.type.at <- paste(id.at, type.at, sep=', ')
  
  # find all those words which are not followed by brackets and add commas
  id.Comma <- pars.new.names[loc.SO+1]=='whitespace'
  id.type.at[id.Comma] <- paste0(id.type.at[id.Comma], ', ')
  
  
  #-- Prop rendering
  loc.Prop <- which(pars.new.names=='word.dot')
  prop.at <- paste0(prop.namespace, pars.new[loc.Prop]) %>% paste0('"', ., '"') %>% paste0(., ':')
  
  #-- DataType rendering
  loc.dataType <- which(pars.new.names=='data.type')
  dt <- pars.new[loc.dataType]
  #dt <- c(dt, dt)
  parsed.dt <- lapply(dt, function(x) parse_dataType(x) ) %>% unlist
  #parse_dataType(dt) %>% cat
  
  
  #-- Reserved words rendering
  loc.Res <- which(pars.new.names=="reserved")
  Res.at <- paste0(reserved.words.namespace, pars.new[loc.Res]) %>% paste0('"', ., '"') %>% paste0(., ':')
  
  #-- exact.num words rendering
  loc.exact <- which(pars.new.names=="exact.num")
  Exact.at <- paste0('\"owl:exact_number\":', pars.new[loc.exact], ',') #%>% paste0('"', ., '"') %>% paste0(., ':')
  
  
  #-- Combined rendering
  pars.new[pars.new.names=='word'] <- id.type.at
  pars.new[pars.new.names=='word.dot'] <- prop.at
  pars.new[pars.new.names=='lbracket'] <- brackets.new[1]
  pars.new[pars.new.names=='rbracket'] <- brackets.new[2]
  
  pars.new[pars.new.names=='data.type'] <- parsed.dt
  pars.new[pars.new.names=="reserved"] <- Res.at
  pars.new[pars.new.names=="exact.num"] <- Exact.at
  
  pars.new <- c('{', pars.new, '}')
  
  #cat(pars.new, sep='')
  ophu.json <- paste0(pars.new, collapse = '')
  
  # make json graph
  json.graph <- paste0('{\n "@graph":[\n', ophu.json, '\n]\n}')
  #length(json.graph)
  #cat(json.graph)
  
  return(json.graph)
}


# Read owl and extract all terms to tibble
read_onto4snippets <- function(file.name, onto.path, onto.pref){
  
  # using python function read_onto_to_R
  onto2R <- read_onto_to_R(onto_name=file.name, path_to_onto=onto.path)
  
  names(onto2R) <- c('classes', 'classes_labels', 'props', 'props_labels', 'dat', 'dat_labels', 'defs')
  
  classes <- lapply(onto2R$classes, function(x) as.character(x))  %>% unlist
  classes_lables <- lapply(onto2R$classes_labels, function(x) as.character(x))  %>% unlist
  
  props <- lapply(onto2R$props, function(x) as.character(x))  %>% unlist
  props_labels <- lapply(onto2R$props_labels, function(x) as.character(x))  %>% unlist
  
  dat <- lapply(onto2R$dat, function(x) as.character(x))  %>% unlist
  dat_labels <- lapply(onto2R$dat_labels, function(x) as.character(x))  %>% unlist
  
  defs <- lapply(onto2R$defs, function(x) as.character(x))  %>% unlist
  
  d1 <-d2 <- d3 <-  NULL
  if (!is.null(classes)) d1 <- cbind(ID=classes, label=classes_lables, type='class')
  if (!is.null(props)) d2 <-cbind(ID=props, label=props_labels, type='prop')
  if (!is.null(dat)) d3 <-cbind(ID=dat, label=dat_labels, type='data_prop')
  
  d <- rbind(d1,d2,d3)
  DT <- cbind(d, Defs=defs) %>% as_tibble()
  #DT <- mutate(DT, label.nospace=gsub(" ", "_", label))
  DT <- mutate(DT, Pref=onto.pref)
  
  return(DT)
}


make_snippets <- function(tb, ...){
  out <- c()
  for(i in 1:nrow(tb)){
    #for(i in 1:3){
    out <- c(out, make_one_snippet(tb[i,], ...) )
  }
  
  XX <- paste0(out, collapse = '')
  return(XX)
}

#make_one_snippet(term=d1[1,], col='blue', letter='P')
make_one_snippet <- function(term, col, letter){
  
  color <- paste0('<span style="color:', col, '">', letter, '</span>')
  
  iid <- strsplit(term$ID, '[.]')[[1]][2]
  url <- paste0('http://purl.obolibrary.org/obo/', iid)
  
  url.pattern <- 'obo\\.[:alpha:]+_\\d+'
  url.ex <-str_detect(term$ID, url.pattern)
  #url.ex <- url.exists(url)
  
  if (url.ex==FALSE){
  out <- paste0('  \'', term$ID, '\':\n',
                '   \'prefix\': ', '\'',term$label.final, '\'', '\n',
                '   \'body\': ', '\'', term$label.nospace, '\'', '\n',
                '   \'description\': ', '\'', term$Defs, '\'', '\n',
                '   \'leftLabelHTML\': ', '\'', color, '\'', '\n\n'
                #'   \'descriptionMoreURL\': ', '\'', url, '\'', '\n\n'
  )
  }

  if (url.ex==TRUE){
  out <- paste0('  \'', term$ID, '\':\n',
                '   \'prefix\': ', '\'',term$label.final, '\'', '\n',
                '   \'body\': ', '\'', term$label.nospace, '\'', '\n',
                '   \'description\': ', '\'', term$Defs, '\'', '\n',
                '   \'leftLabelHTML\': ', '\'', color, '\'', '\n',
                '   \'descriptionMoreURL\': ', '\'', url, '\'', '\n\n'
  )
  }
  
  
  return(out)
  
}
#---
# iid <- sn$ID
# iid <- strsplit(iid, '[.]')
# iid <- lapply(iid, function(x) x[2]) %>% unlist
# url <- paste0('http://purl.obolibrary.org/obo/', iid)
# lapply(url[1:10], function(x) url.exists(x))
# url.ex <- url.exists(url)
# library("RCurl")
# url.exists("http://www.omegahat.net/RCurlasx")
# 
# library("stringr")
# iid[1]
# url.pattern <- 'obo\\.[:alpha:]+_\\d+'
# str_detect(iid, "obo\\.[:alpha:]+_\\d+")
# str_view(iid[1], "obo\\.[:alpha:]+_\\d+")

add_HasPart_ophu <- function(ophu){
  paste0('has_part.(', ophu, ')')
}

#g <- g1
graph2Manchester_singleComponent <- function(g, qulifier='.some', prefix.remove='localhost:///', numeric.prefix='xsd:float', 
                             escaped.words = c('not', 'min', 'max', 'exactly'), add.has_part=FALSE){
  
  # rename graph E and V
  E(g)$label <- gsub('xsd:', '', E(g)$label)
  E(g)$label <- gsub('obo:', '', E(g)$label)
  E(g)$label <- gsub('owl:', '', E(g)$label)
  
  V(g)$label <- gsub(prefix.remove, '', V(g)$label)
  # mark blank nodes
  V(g)$label[str_detect(V(g)$label, "_:")] <- 'blank_node'
  #--
  
  #--- convert numeric nodes
  id.numeric <- which(V(g)$label==numeric.prefix)
  
  if (length(id.numeric)>0){
    
    i <- 1
    for (i in 1:length(id.numeric)){
      id.node <- id.numeric[i]
      
      #V(g)$label[id.node]
      #V(g)$name[id.node]
      
      edges <- E(g)[ from(V(g)$name[id.node]) ]
      node.vals <- V(g)[to(edges)]$label %>% as.numeric()
      
      # remove xsd
      #edge.label <- gsub('xsd:', '', edges$label)
      edge.label <-  edges$label
      
      #--- in caes edge has 'equals'
      if (edge.label=='equals') edge.label <- c('min_inclusive', 'max_inclusive')
      #---
      
      p1 <- paste0(edge.label, '=', node.vals, collapse = ', ')
      p2 <- paste0('ConstrainedDatatype(float, ', p1, ')' )
      #ConstrainedDatatype(float, min_inclusive = 0, max_inclusive = 20)
      
      # set node name to be py func
      V(g)$label[id.node] <- p2
      
      # remove all descendants of node
      g <- delete_vertices(g, V(g)[to(edges)]$name)
    }
  }
  
  #plot(g)
  
  #--- convert edges that are 'has component'
  #plot(g)
  id.numeric <- which(E(g)$label=='has_component')
  
  if (length(id.numeric)>0){
    
    i <- 1
    for (i in 1:length(id.numeric)){
      id.edge <- id.numeric[i]
      
      #V(g)$label[id.node]
      #V(g)$name[id.node]
      #V(g)[to(id.edge)]
      
      # entity that preceeds has component
      prev.enity <- V(g)[from(id.edge)]$label
      
      comp.g <- make_ego_graph(g, order = 2, nodes = V(g)[to(id.edge)], mode = c("out"), mindist = 0)[[1]]
      #plot(comp.g)
      restrict <- E(comp.g)[from(V(comp.g)$label=='blank_node')]$label
      entity <- V(comp.g)[to(from(V(comp.g)$label=='blank_node'))]$label
      card <- V(comp.g)[to(E(comp.g)$label=='exact_number')]$label
      
      
      
      new.node <- paste0(prev.enity, ' & has_component.', restrict, '(', card, ', ', entity, ')')
      
      
      # set node name to be py func
      V(g)[from(id.edge)]$label <- new.node
      
      # remove nodes
      g <- delete_vertices(g, V(comp.g)$name)
      #plot(g)                
    }
  }
  
  #----
  
  #----
  n.edges <- vcount(g)
  
  #--- Graph of more than 1 node
  if (n.edges>1){
    g.sort <- topo_sort(g, mode = c("in"))
    g.sort <- as.numeric(g.sort)
    
    # remove tips
    #neighborhood.size(g, order = 1, mode ="out")
    id.tips <- which(ego_size(g, order = 1, mode ="out")==1)
    g.sort <-g.sort[-match(id.tips, g.sort)]
    
    
    i <- 1
    for (i in 1:length(g.sort)){
      
      #id.node <- c(1,2)
      id.node <- g.sort[i]
      
      #
      current.node <- V(g)$label[id.node]
      edges <- E(g)[ from(V(g)$name[id.node]) ]
      
      # get descendant lapply used to presece order in edges
      descen.node <-sapply(edges, function(x) V(g)[to(x)]$label)
      #descen.node <- V(g)[to(edges)]$label
      
      # check if edge is any escaped.words
      parsed.links <- edges$label %in% escaped.words
      #parsed.links <-c("bearer_of",'owl:not') %in% escaped.words
      # add qualifiers
      parsed.edges <- edges$label
      parsed.edges[!parsed.links] <- paste0(edges$label[!parsed.links], qulifier)
      
      if(current.node=="blank_node"){
        #out <- paste0(edges$label, qulifier, '(', descen.node, ')')
        out <- paste0(parsed.edges, '(', descen.node, ')')
        out <-paste0(out, collapse = ' & ')
      }
      
      if(current.node!="blank_node"){
        #out <- paste0(edges$label, qulifier, '(', descen.node, ')')
        out <- paste0(parsed.edges, '(', descen.node, ')')
        out <-paste0(out, collapse = ' & ')
        out <-paste0(current.node, ' & ', out)
      }
      
      V(g)$label[id.node] <- out
      #V(g)$name[id.node]
    }
    
    XX <- V(g)$label[g.sort[length(g.sort)]]
  }
  
  # Graph of one node
  if (n.edges==1){
    id.node <- 1
    
    XX <- V(g)$label[id.node]
    
  }
  
  #plot(g)
  
  
  #addd has part at the end
  if (add.has_part==T){
    XX <-paste0('has_part', qulifier, '(', XX, ')')
  }
  return(XX)
}


triple2graph <- function(triple.ophu){
  
  sparql.all <-
    '
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
  PREFIX : <localhost:///>
  SELECT  ?obj ?prop ?sub  
  WHERE {
  ?obj ?prop ?sub.
  }'

  
  sparql1 <-
    '
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
  SELECT  ?obj ?sub ?prop 
  WHERE {
  ?obj ?prop ?sub.
  # FILTER ((datatype(?p)) = xsd:integer)
  FILTER (?prop != rdf:type)
  }'

  sparql2 <-
    '
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
  SELECT  ?obj ?sub ?prop 
  WHERE {
  ?obj ?prop ?sub.
  FILTER (?prop = rdf:type)
  }'
  
  #rdflib::rdf_query(triple.ophu, query=sparql1)
  #rdflib::rdf_query(triple.ophu, query=sparql2)
  tb.graph <- rdflib::rdf_query(triple.ophu, query=sparql1)
  tb.name <- rdflib::rdf_query(triple.ophu, query=sparql2)
  tb.all <- rdflib::rdf_query(triple.ophu, query=sparql.all)
  
  g <- graph_from_data_frame(tb.graph, directed = TRUE, vertices = NULL)
  #plot(g)
  
  # vertex names
  map <- match(tb.name$obj, V(g)$name)
  V(g)$label <- V(g)$name
  V(g)$label[map] <- tb.name$sub
  
  #edge names
  #map <- match(tb.name$obj, E(g)$name)
  E(g)$label <- tb.graph$prop
  
  
  
  return(g)
  
}

#---- Connected componennts


graph2Manchester <- function(g, qulifier='.some', prefix.remove='localhost:///', numeric.prefix='xsd:float', 
                                               escaped.words = c('not', 'min', 'max', 'exactly', 'Not')){
  
  # get the number of connected components
  clusters <- components(g, mode = c("weak"))
  
  cluster.manch <- c()
  
  i <- 1
  for (i in 1:clusters$no){
    
    comp <- i
    comp.nodes <- names(clusters$membership)[!(clusters$membership==comp)]
    g.comp <- delete_vertices(g, V(g)[comp.nodes]$name)
    #plot(g.comp)
    
    if (root_HasPart_graph(g.comp)){
      cluster.manch[i] <- graph2Manchester_singleComponent(g.comp, qulifier='.some', prefix.remove='localhost:///', numeric.prefix='xsd:float', 
                                           escaped.words = c('not', 'min', 'max', 'exactly', 'Not'), add.has_part=FALSE)
    }

    if (root_HasPart_graph(g.comp)==FALSE){
      cluster.manch[i] <- graph2Manchester_singleComponent(g.comp, qulifier='.some', prefix.remove='localhost:///', numeric.prefix='xsd:float', 
                                           escaped.words = c('not', 'min', 'max', 'exactly', 'Not'), add.has_part=TRUE)
    }
    
  }
  
  # combine connected copmponents
  out <- paste0(cluster.manch, collapse = ' & ')
  return(out)
  
}
 
#--------- 
# check if root in tripple graph has part
#plot(g)
root_HasPart_graph <- function(g){
  topo <- topo_sort(g, mode = c("in"))
  # select last
  root <- rev(topo)[1]
  
  # check if outhgoing edge is has_part and root node is blank
  edge <- E(g)[from(root)]$label
  out <- all(str_detect(edge, 'has_part'), str_detect(names(root), '_:') )
  return(out)
}


#----- Lieave triplr.phu entity
# Removes all non entityt node in triple opu and returns graph
#triple.ophu <- sp_descr[[1]][21]
leave_triple_entity <- function(triple.ophu){
  
  # leave "component_trait" intact
  if (trait_type(triple.ophu)=="component_trait"){
    g <- triple2graph(triple.ophu)
    return(g)
  } 
  #----
  
  sprBear <-
    '
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
  PREFIX obo: <obo:>
  SELECT  ?obj1 ?obj2
  WHERE 
  {
  {SELECT  ?obj1
  WHERE { ?obj1 obo:bearer_of ?s.}
  }
  
  {SELECT  ?obj1
  WHERE { ?a obo:inheres_in ?obj1.}
  }
  
  }'

  #rdflib::rdf_query(triple.ophu, query=sprBear)
  
  sprBear <-
    '
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
  PREFIX obo: <obo:>
  SELECT  ?obj
  WHERE {
  ?obj ?p ?sub.
  FILTER (?p IN (obo:bearer_of) )
  }'

  sprINH <-
    '
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
  PREFIX obo: <obo:>
  SELECT  ?sub
  WHERE {
  ?obj ?p ?sub.
  FILTER (?p IN (obo:inheres_in) )
  }'


  sprHSnot <-
    '
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
  PREFIX obo: <obo:>
  PREFIX owl: <owl:>
  SELECT  ?obj ?sub
  WHERE {
  ?obj ?p ?sub.
  #?sub ?p ?x.
  FILTER (?p IN (obo:has_part, owl:Not, obo:part_of) )
  }'
  
  nodes <- c(
  rdflib::rdf_query(triple.ophu, query=sprBear) %>% unlist,
  rdflib::rdf_query(triple.ophu, query=sprINH) %>% unlist,
  rdflib::rdf_query(triple.ophu, query=sprHSnot) %>% unlist
  )
  
  nodes <- unique(nodes)
  
  # revome all nodes not in nodes
  g <- triple2graph(triple.ophu)
  nodes.remove<- V(g)$name[!(V(g)$name %in% nodes)]
  
  g1 <- delete_vertices(g, nodes.remove)
  #plot(g1)
  
  return(g1)
  
}




#--------------------
# USing VIrtuosos sparql to retrive all class terms

retrieve_class_defintion <- function(ophu, con){
  
  sparql <- paste0('
                   PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
                   PREFIX phen: <http://dx.doi.org/10.5061/dryad.2gd84/3#>
                   PREFIX owl: <http://www.w3.org/2002/07/owl#>
                   PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                   PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
                   PREFIX obo: <http://purl.obolibrary.org/obo/>
                   SELECT ?p ?s
                   WHERE {
                   phen:', ophu, ' ?p ?s.
                   #OPTIONAL{?s ?x1 ?x2}.
                   }')

  
  out.init <- vos_query(con, sparql) %>% as_tibble()
  out.init <-bind_cols(o=rep(ophu, nrow(out.init) ), out.init)
  
  blanks.init <- out.init$s[str_detect(out.init$s, 'nodeID:')]
  #blanks.init <- paste0('<', out.init$s[blanks.init], '>')
  #blanks.init <- out.init$s[blanks.init]
  
  blanks.list <- blanks.init
  blanks.searched <- 0
  out.all <- out.init
  while(blanks.searched<length(blanks.list)){
    
    print(blanks.searched)
    
    blank.focal <- blanks.list[blanks.searched+1]
    
    sparql <- paste0('
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  PREFIX phen: <http://dx.doi.org/10.5061/dryad.2gd84/3#>
  PREFIX owl: <http://www.w3.org/2002/07/owl#>
  PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
  PREFIX obo: <http://purl.obolibrary.org/obo/>
  SELECT ?p ?s
  WHERE {<',
                     blank.focal, '> ?p ?s.
  #OPTIONAL{?s ?x1 ?x2}.
  }')
    
    #sparql %>% cat
    
    out.for <- vos_query(con, sparql) %>% as_tibble()
    out.for <-bind_cols(o=rep(blank.focal, nrow(out.for) ), out.for)
    
    blanks.for <- out.for$s[str_detect(out.for$s, 'nodeID:')]
    blanks.list <- c(blanks.list, blanks.for)
    blanks.searched <-blanks.searched+1
    
    out.all <- bind_rows(out.all, out.for)
    
  }
  
  return(out.all)
}

#-----------------
# Identify trait type

trait_type <- function(triple.ophu){
  sparqlClass <-
    '
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
  PREFIX obo: <obo:>
  SELECT * 
  { ?o ?p ?s.
  FILTER (?p != rdf:type)
  }'

  tb <- rdflib::rdf_query(triple.ophu, query=sparqlClass)
  
  props <- tb$p
  props <-gsub('obo:', '', props)
  props <-gsub('xsd:', '', props)
  props <-gsub('owl:', '', props)
  props <-gsub('localhost:///', '', props)
  
  # tb <- apply(tb, 2, function(x) gsub('obo:', '', x))
  # #class(tb)
  # tb <- apply(tb, 2, function(x) gsub('xsd:', '', x))
  # tb <- apply(tb, 2, function(x) gsub('owl:', '', x))
  # tb <- apply(tb, 2, function(x) gsub('localhost:///', '', x))
  # tb <- as_tibble(tb)
  
  # trait types diagnoses
  types <- c(
    'relative_comparison_trait',
    'measurement_trait',
    'relative_measurement_trait',
    'quality_trait',
    'absence_trait',
    'component_trait',
    'presence_trait'
  )
  
  
  relative_comparison_Def <- c('decreased_in_magnitude_relative_to',  'increased_in_magnitude_relative_to')
  measurement_Def <- c('has_measurement', 'has_unit', 'value')
  relative_measurement_Def <- c('has_measurement', 'has_unit', 'inheres_in')
  quality_Def<- c('bearer_of')
  absence_Def<- c('not')
  component_Def <- c('has_component')
  presence_Def<- c('.') # any symbol
  
  rep <- c(
    relative_comparison_Def %in% props %>% any,
    measurement_Def %in% props %>% all,
    relative_measurement_Def %in% props %>% all,
    quality_Def %in% props %>% all,
    absence_Def %in% props %>% all,
    #presence_Def %in% props %>% all
    component_Def %in% props %>% all,
    str_detect(props, presence_Def) %>% any
  )
  
  # get the first true
  answer <- types[which(rep==T)[1]]
  
  return(answer)
}



create_ophus <- function(ophu){
  json.graph <- PhenSci2json(ophu, reserved.words.namespace='owl:', prop.namespace='obo:', id.prefix = '_test_', 
                             brackets.new = c('{', '}') )
  
  triple.ophu <- rdflib::rdf_parse(json.graph, "jsonld")
  g <- triple2graph(triple.ophu)
  Manch <- graph2Manchester(g, qulifier='.some', prefix.remove='localhost:///', numeric.prefix='xsd:float')
  return(Manch)
}

#ophu <- sp_descr[[1]][21]
create_ophus_E <- function(ophu){
  json.graph <- PhenSci2json(ophu, reserved.words.namespace='owl:', prop.namespace='obo:', id.prefix = '_test_', 
                             brackets.new = c('{', '}') )
  
  #cat(json.graph)
  triple.ophu <- rdflib::rdf_parse(json.graph, "jsonld")
  #g <- triple2graph(triple.ophu)
  g <- leave_triple_entity(triple.ophu)
  #plot(g)
  Manch <- graph2Manchester(g, qulifier='.some', prefix.remove='localhost:///', numeric.prefix='xsd:float')
  return(Manch)
}

