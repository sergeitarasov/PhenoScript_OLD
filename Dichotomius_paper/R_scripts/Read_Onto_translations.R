# #devtools::install_github('coolbutuseless/minilexer')
# library(reticulate)
# library("minilexer")
# setwd("~/Documents/My_papers/Semantic_discriptions/Protege/OWLAPI")
# source('parser_functions.R')
# source_python('py_func.R')
# library("ontologyIndex")
# #devtools::install_github("gadenbuie/regexplain")
# #library("regexplain")
# library("igraph")
# library("stringr")
# library("dplyr")


#   ____________________________________________________________________________
#   Read onto translationds for using in translate2URIs_oneToken()         ####


#--- onto names for translations
# see Snippets.R, object 'all'
setwd("~/Documents/My_papers/Semantic_discriptions/Protege/PhenoScript_R/PhenoScript/Dichotomius_paper/R_scripts/data")

all <- read.csv(file='all_ontologies_tibble4Snippets.csv', stringsAsFactors = F)
all <-as_tibble(all)

all
# make lables for onto translations
all <-all %>% mutate(label.transl=label.final)
# add dot to properties and data_props
all <-all %>% mutate(label.transl=replace(label.transl, type=='prop', paste0(filter(all, type=='prop')$label.transl, '.') ))
all <-all %>% mutate(label.transl=replace(label.transl, type=='data_prop', paste0(filter(all, type=='data_prop')$label.transl, '.') ))

# add dot to IDs of properties and data_props
all <-all %>% mutate(ID.transl=ID)
all <-all %>% mutate(ID.transl=replace(ID.transl, type=='prop', paste0(filter(all, type=='prop')$ID.transl, '.') ))
all <-all %>% mutate(ID.transl=replace(ID.transl, type=='data_prop', paste0(filter(all, type=='data_prop')$ID.transl, '.') ))

filter(all, type=='prop')
filter(all, type=='prop') %>% select(label.transl, ID.transl)
all$label.transl
all$ID.transl

all$label.transl[all$label.transl=='SCARAB.has_measurement.']
# Remove SCARAB in labels
all$label.transl <- gsub('SCARAB.', '', all$label.transl)
all$ID.transl <- gsub('SCARAB.', 'scarab.', all$ID.transl)

all$label.transl[all$label.transl=='has_measurement.']

# make ttranslation obj
ont.transl <- all$label.transl
names(ont.transl) <-all$ID.transl
