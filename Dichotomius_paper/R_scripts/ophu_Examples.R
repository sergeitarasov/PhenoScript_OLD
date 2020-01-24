
#   ____________________________________________________________________________
#   Possible operarions with Ophus                                          ####

#------------------ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# Prior creating ophus read tanslations 'Read_Onto_translations.R'
#
#--------------------------------------------------------------------


#---- Examples

ophu <- 'fore_wing has_part.(wing_vein bearer_of.(yellow))'
ophu <- 'scape bearer_of.(length has_measurement.(has_unit.(length inheres_in.(compound_eye)), has_magnitude.(>1.0,<2.0float)))'
ophu <- 'scape bearer_of.(length has_measurement.(has_unit.(length inheres_in.(compound_eye)), has_magnitude.(<2.1float)))'
ophu <-'scape bearer_of.(length increased_in_magnitude_relative_to.(length inheres_in.(compound_eye)))'
ophu <-'head has_part.(scape bearer_of.(length increased_in_magnitude_relative_to.(length inheres_in.(compound_eye))))'
ophu <-'has_part.(scape bearer_of.(length increased_in_magnitude_relative_to.(length inheres_in.(compound_eye))))'
ophu <- 'body bearer_of.(length has_measurement.(has_unit.(value.(mm)), has_magnitude.(=2float)))'

ophu <- 'pronotal_lobe has_part.(carina)'
ophu <- 'pronotal_lobe has_part.(not(carina))'
ophu <- 'pronotal_lobe not(has_part.(carina))'
ophu <-'anterolateral_mesopectal_projection has_part.(lateral_side bearer_of.(square))'
ophu <-'mandible has_part.[(not(tooth), bearer_of.(black)), (tooth bearer_of.(dark_brown))]' # this means:
# 'mandible has_part.(not(tooth), bearer_of.(black)) AND has_part.(tooth bearer_of.(dark_brown))'
ophu <-'mandible has_part.[(tooth bearer_of.(black)), (tooth bearer_of.(dark_brown))]' 
ophu <-'mandible has_part.(tooth has_component.(=3int))'
ophu <-'mandible has_component.(exactly(3 tooth))'
ophu <-'has_part.(mandible)'
ophu <- 'hypomeron has_part.(lateral_region bearer_of.(((hairy), (orange)) ))'
ophu <- 'clypeus has_part.(anterior_region has_component.(exactly(==12 tooth)))'
ophu <- 'body bearer_of.(length has_measurement.(has_unit.(value.(mm)), has_magnitude.(=12.9float)))'

#-------------------



json.graph <- PhenSci2json(ophu, reserved.words.namespace='owl:', prop.namespace='obo:', id.prefix = '_test_', 
                           brackets.new = c('{', '}') )

cat(json.graph)

# Triplestore fromat
triple.ophu <- rdflib::rdf_parse(json.graph, "jsonld")

# get type
trait_type(triple.ophu)

# plot
g <- triple2graph(triple.ophu)
plot(g)

# get Manchester fromat owlready
Manch <- graph2Manchester(g, qulifier='.some', prefix.remove='localhost:///', numeric.prefix='xsd:float', 
                          escaped.words = c('not', 'min', 'max'))

# translate
translate2URIs_oneToken(Manch, ont.transl, Manchester.pattern)

# get triple Entity
g.E <- leave_triple_entity(triple.ophu)
plot(g.E)

# Manchester
Manch.E <- graph2Manchester(g.E, qulifier='.some', prefix.remove='localhost:///', numeric.prefix='xsd:float', 
                            escaped.words = c('not', 'min', 'max'))


translate2URIs_oneToken(Manch.E, ont.transl, Manchester.pattern)

