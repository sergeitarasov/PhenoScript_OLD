#------------------
#
# Contains script for making Phenoscript dictionaries 
# and Atom snippets
#
# use cmd tools cmdPhsDic.R and cmdSnips.R
#
#------------------

# ROBOT
# robot query --input aism_instances.xml \
# --queries get_class.sparql get_op.sparql get_dp.sparql \
# --output-dir results/


setwd("~/Documents/My_papers/Phenoscript_2021/Phenoscript/sparql")
library("dplyr")
library(stringr)
source('parser_functions.R')


#bspo$type %>% unique

cl <- read.csv('results/get_class.csv', stringsAsFactors = FALSE) %>% as_tibble() %>% mutate(type='class')
dp <- read.csv('results/get_dp.csv', stringsAsFactors = FALSE) %>% as_tibble() %>% mutate(type='data_prop')
op <- read.csv('results/get_op.csv', stringsAsFactors = FALSE) %>% as_tibble() %>% mutate(type='prop')

tb <- bind_rows(cl, dp, op)
colnames(tb) <- c('IRI', 'label', 'Defs', 'type')

# remove ID with no httpp
tb <- tb[str_detect(tb$IRI, 'http:'),]

#make ID short
#str_split('http://purl.obolibrary.org/obo/AISM_000', '/')
x <- str_split(tb$IRI, '/')
ID.short <- lapply(x, function(y) {y[length(y)]}) %>% unlist
tb <- mutate(tb, ID.short=ID.short, ID=ID.short)

# namespaces
nm <- lapply(x, function(y) { y[1:(length(y)-1)]} %>% paste0(., collapse = '/') ) %>% unlist
cat('Unique namespaces: ', unique(nm), '\n')


### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### Filter/change terms for output                                          ####

# if lable is na then put ID
tb <-tb %>% mutate(label.final=replace(label, label=='na', filter(tb, label=='na')$ID))
#filter(tb, label=='na')
# filter(tb, label=='')

# make no space labels
tb <-tb %>% mutate(label.nospace=gsub(" ", "_", label.final))

# remove space in lablel.final as well
tb <-tb %>% mutate(label.final=gsub(" ", "_", label.final))

# add dot to properties and data_props
tb <-tb %>% mutate(label.nospace=replace(label.nospace, type=='prop', paste0(filter(tb, type=='prop')$label.nospace, '.') ))
tb <-tb %>% mutate(label.nospace=replace(label.nospace, type=='data_prop', paste0(filter(tb, type=='data_prop')$label.nospace, '.') ))
#paste0(filter(all, type=='prop')$label.nospace, '.')
#filter(all, type=='prop')

# # add attibutes '($1)$2)' to props and data_props
# tb <-tb %>% mutate(label.nospace=replace(label.nospace, type=='prop', paste0(filter(tb, type=='prop')$label.nospace, '($1)$2' )))
# tb <-tb %>% mutate(label.nospace=replace(label.nospace, type=='data_prop', paste0(filter(tb, type=='data_prop')$label.nospace, '($1)$2' )))
# #filter(all, type=='prop')

# dupicates
# reomve duplicates in ID
tb <-distinct(tb, ID, .keep_all = TRUE)
cat('Removing duplicated iri... Duplicated iri: ', any(duplicated(tb$ID)), '\n')

# rsolve duplicates in label
cat('Duplicated labels: ', any(duplicated(tb$label.final)), '\n')
dup <- tb$label[duplicated(tb$label)]
dup.id <- which(!is.na(match(tb$label, dup))==TRUE)
#tb[dup.id,]
iri <- c(tb[dup.id,'ID.short'])[[1]]
lf <- c(tb[dup.id,'label.final'])[[1]]
ls <- c(tb[dup.id,'label.nospace'])[[1]]
tb[dup.id,'label.final'] <- paste0(lf,'[iri="', iri, '"]')
tb[dup.id,'label.nospace'] <- paste0(ls,'[iri="', iri, '"]')

cat('Resolving.. Duplicated labels: ', any(duplicated(tb$label.final)), '\n')

# change unwanted symbols i.e, ' to \'
tb <-tb %>% mutate(Defs=gsub("\'", "\\\\'", Defs), label.final=gsub("\'", "\\\\'", label.final),
                     label.nospace=gsub("\'", "\\\\'", label.nospace) )

### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### Write translatopn to tb                                                  ####

#cat()
#write.csv(tb, file='dict_phs.csv')
### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### Make snippets                                                           ####
cat('Making Atom snippets....\n')
d1 <-filter(tb, type=='prop')
d2 <-filter(tb, type=='class')
d3 <-filter(tb, type=='data_prop')
s1 <-s2 <- s3 <-  NULL
if (nrow(d1)>0) s1 <- make_snippets(d1, col='#64B5F6', letter='P')
if (nrow(d2)>0) s2 <- make_snippets(d2, col='#FDD835', letter='C')
if (nrow(d3)>0) s3 <- make_snippets(d3, col='#4CAF50', letter='D')

#--- SAVE SNIPPETS TO FILE
# Copy paste the snippets to Atom's snippet.cson
# snippet.cson is located as Atom-> snippets
# add '.source.r': or so
# install Atom package snippet-injector https://atom.io/packages/snippet-injector

#setwd("~/Documents/My_papers/Semantic_discriptions/Protege/Snippets")
snips <- paste0(c(s1,s2,s3), collapse = '')
cat(snips, file='snippets.cson')

#make_one_snippet(d1[1,], col='blue', letter='P')
