#from owlready2 import *

def read_onto_to_R(onto_name, path_to_onto):
    #--- Python
    onto_path.append(path_to_onto)
    
    onto = get_ontology(onto_name)
    onto.load()
    
    obo = onto.get_namespace("http://purl.obolibrary.org/obo/")
    
    #----- CLASSES
    classes=list(onto.classes())
    classes_labels=list()
    
    for i in classes:
      if len(i.label)>0:
        classes_labels.append(i.label[0])
      elif len(i.label)==0:
        classes_labels.append('na')
    
    #len(classes)
    #len(classes_labels)
    #----- Obj. Prop
    props=list(onto.object_properties())
    props_labels=list()
    
    for i in props:
      if len(i.label)>0:
        props_labels.append(i.label[0])
      elif len(i.label)==0:
        props_labels.append('na')
    
    #----- Data Prop
    dat=list(onto.data_properties())
    dat_labels=list()
    
    for i in dat:
      if len(i.label)>0:
        dat_labels.append(i.label[0])
      elif len(i.label)==0:
        dat_labels.append('na')
    
    #----- Defintitions
    terms=classes+props+dat
    defs=list()
    
    
    for i in terms:
      if len(i.IAO_0000115)>0:
        defs.append(i.IAO_0000115[0])
      elif len(i.IAO_0000115)==0:
        defs.append('na')
    
    onto2R=[classes, classes_labels, props, props_labels, dat, dat_labels, defs]
    #-------
    #del onto
    #del onto_path
    
    return onto2R;
    
