
setwd("~/Documents/My_papers/Semantic_discriptions/Protege/PhenoScript_R/PhenoScript/Dichotomius_paper/R_scripts")

#devtools::install_github('coolbutuseless/minilexer')
library(reticulate)
library("minilexer")
library("ontologyIndex")
#devtools::install_github("gadenbuie/regexplain")
#library("regexplain")
library("igraph")
library("stringr")
library("dplyr")
library("rdflib")
library(tidyr)
library(tibble)
library(jsonld)
library("redland")

setwd("~/Documents/My_papers/Semantic_discriptions/Protege/PhenoScript_R/PhenoScript/Dichotomius_paper/R_scripts/Functions")
source('parser_functions.R')
source_python('py_func.R')


# Setwd Descritions
setwd("~/Documents/My_papers/Semantic_discriptions/Protege/PhenoScript_R/PhenoScript/Dichotomius_paper/Description")

#   ____________________________________________________________________________
#   Read in descriptions                                                    ####


descr <- readLines('D_annin.txt')

# remove comments
descr <- str_remove(descr, '#.+')
# merge
descr <- paste0(descr, collapse = ' ')
# remove 2 or more whitespaces
descr <-str_squish(descr)
#str_view_all(descr, '\\s')
descr <-gsub('\n', '', descr)
descr <-strsplit(descr, '\\{')
descr <-descr[[1]][-1]
descr <-strsplit(descr, '\\}')
#
sp_names <- descr[[1]][1]
descr <-descr[[1]][2]
# remove unnecessary white speces (Ws, Ws)
descr <-str_replace_all(descr, '\\s\\)', '\\)')
descr <-str_replace_all(descr, '\\(\\s', '\\(')
# change not() to Not()
descr <-str_replace_all(descr, 'not\\(', 'Not\\(')
sp_descr <- lapply(descr, function(x) strsplit(x, ';')[[1]] )
# remove white at the beginning
sp_descr <-lapply(sp_descr, function(x) trimws(x))
names(sp_descr) <- sp_names[[1]]


# ADD HAS PART  
sp_descr[[1]] <- sapply(sp_descr[[1]], function(x) add_HasPart_ophu(x), USE.NAMES = F )




#   ____________________________________________________________________________
#   Create ophus in owlready fromate and translate descriptions             ####

#------------------ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# Prior creating ophus read tanslations 'Read_Onto_translations.R'
#
#--------------------------------------------------------------------

man.syn <- sapply(sp_descr[[1]], function(x) create_ophus(x), USE.NAMES = F)
owl.syn <- sapply(man.syn, function(x) translate2URIs_oneToken(x, ont.transl, Manchester.pattern), USE.NAMES = F)



#   ____________________________________________________________________________
#   Read in ontology   in Python                                           ####

setwd("~/Documents/My_papers/Semantic_discriptions/Protege/PhenoScript_R/PhenoScript/Dichotomius_paper/Ontologies")

repl_python()

from owlready2 import *
  onto_path.append("~/Documents/My_papers/Semantic_discriptions/Protege/PhenoScript_R/PhenoScript/Dichotomius_paper/Ontologies")

scarab = get_ontology("SCARAB_merged.owl")
scarab.load()
obo = scarab.get_namespace("http://purl.obolibrary.org/obo/")
pato = scarab.get_namespace("http://purl.obolibrary.org/obo/pato")

exit


#   ____________________________________________________________________________
#   Export ophus to the ontology                                            ####



##  ............................................................................
##  Export EQ ophus                                                         ####

# py_run_string(
#   'with scarab:
#   class OPHU_EQ(Thing):
#   pass', convert = F)


j <- 1
#for (j in 1:3){
for (i in 1:length(owl.syn)){
  #  for (i in 1:5){
  # CL1 <- py_make_class(class_id=paste0('ophu_sp_',j,'_', i), subclass_of='scarab.OPHU_EQ', restriction='is_a', def=owl.syn[i])
  # py_run_string(CL1, local = FALSE, convert = F)
  
  CL1 <- py_make_class(class_id=paste0('ophu_sp_',j,'_', i), subclass_of='scarab.OPHU_EQ', restriction='equivalent_to', def=owl.syn[i])
  py_run_string(CL1, local = FALSE, convert = F)
  #  }
}

py_run_string('scarab.save(file = "SCARAB_merged.owl", format = "rdfxml")', local = FALSE, convert = F)


##  ............................................................................
##  Export E ophus                                                          ####

# py_run_string(
#   'with scarab:
#   class OPHU_E(Thing):
#   pass', convert = F)


man.syn.E <- sapply(sp_descr[[1]], function(x) create_ophus_E(x), USE.NAMES = F)
owl.syn.E <- sapply(man.syn.E, function(x) translate2URIs_oneToken(x, ont.transl, Manchester.pattern), USE.NAMES = F)

for (i in 1:length(owl.syn.E)){
  CL1 <- py_make_class(class_id=paste0('ophu_E_',i), subclass_of='OPHU_E', restriction='is_a', def=owl.syn.E[i])
  py_run_string(CL1, local = FALSE, convert = F)
}

py_run_string('scarab.save(file = "SCARAB_merged.owl", format = "rdfxml")', local = FALSE, convert = F)

