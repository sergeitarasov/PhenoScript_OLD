#---------------------------------------
#
# This is the workflow that translates
#  Phenoscript into OWL for Gryonoides
#
# author: Sergei Tarasov
#
#---------------------------------------

library(reticulate)

#   ____________________________________________________________________________
#   Input and Output                                                        ####

# Input
dic.path.in <- 'phsDictionary'
data.path.in <- 'data'
onto.in <- file.path(data.path.in, 'Gryonoides_merged_ontologies.owl')
phs.file.in <- file.path(data.path.in, 'Gryonoides.phs')

# Output
results.out <- 'results'
dic.path.out <- 'results/dictionary'
dic.out <- file.path(dic.path.out, 'Gryo_dic.csv')
xml.out <- file.path(results.out, 'phs_Gryo.xml')
instance_IRI='https://orcid.org/0000-0001-5237-2330/'


#   ____________________________________________________________________________
#   Make Dictionary & Snippets for Atom                                     ####

##  ............................................................................
##  Make Dictionary                                                         ####
make_dic <-paste0('./', file.path(dic.path.in, 'cmdPhsDic.R'), ' ', onto.in, ' ', dic.out )
system(make_dic)

##  ............................................................................
##  Make Snippets                                                           ####
make_snps <-paste0('./', file.path(dic.path.in, 'cmdSnips.R'), ' ', dic.out, ' ', 'results/dictionary/snippets.cson' )
system(make_snps)


#   ____________________________________________________________________________
#   PhenoScript to XML                                                      ####

py_run_file("src/phs_init.py")

pyPhenoScriptToXML <- sprintf("PhenoScriptToXML(file_phs='%s', file_phsDic='%s', xml_out='%s', instance_IRI='%s')",
                                               phs.file.in, dic.out, xml.out, instance_IRI)

# !!! For manial parsing see src/phs_manual_parse.py
py_run_string(pyPhenoScriptToXML)



#   ____________________________________________________________________________
#   Compile: PhenoScript XML into OWL                                       ####

library(xml2)
source('R/write_xml.R')

# Namespace for XML to OWL
gryo.namespace =c('obo'="http://purl.obolibrary.org/obo/",
                  rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#",
                  'owl'="http://www.w3.org/2002/07/owl#",
                  rdfs="http://www.w3.org/2000/01/rdf-schema#",
                  sta ="https://orcid.org/0000-0001-5237-2330/",
                  'oboI'="http://www.geneontology.org/formats/oboInOwl#",
                  'newT'="http://github.com/sergeitarasov/PhenoScript/gryo/",
                  'pato'="http://purl.obolibrary.org/obo/pato#"
)

# let's read xml PhS: xml.out
phs <- read_xml(xml.out)
print(phs)

# Now compiling xml PhS into OWL
PhenoScriptToOWL(PS=phs, phs.namespace=gryo.namespace, onto.in,
                 xml_instances.out='results/Gryo_only_instances.owl', file.out='results/phsGryo_merged.owl')
