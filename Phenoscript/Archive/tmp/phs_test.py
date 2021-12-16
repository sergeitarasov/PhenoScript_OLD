import os
os.getcwd()
os.chdir('/Users/taravser/Documents/My_papers/Phenoscript_2021/Phenoscript/src')

os.chdir('../src')

#from phs_parser import * # here is parser
#from phs_xml import * # here to make xml output
exec(open("phs_parser.py").read())
exec(open("phs_xml.py").read())

query = "n0 e0. (n1 has_part. n2 e. n3) e3. n4 e4. n5"
query = "n0@h1 !e0. n5 e1. n6; n8 e5. n10 e4. n9;"
query = "OTU=[OTU_model=[sp1 sp2. sp3 sp4. sp5;] Ophu_List=[n0['id'='val>', 'id2'=2, 'id3'=true] e0. n5 e1. n6;]]"

query = '''
OTU=[OTU_model=[sp1 sp2. sp3 sp4. sp5;] Ophu_List=[n0 e0. n5 e1. n6;]]
OTU=[OTU_model=[sp2 sp2. sp2 sp4. sp2;] Ophu_List=[n0 e0. n5 e1. n10;]]
'''

query = '''
OTU=[OTU_model=[sp1 sp2. sp3 sp4. sp5;] Ophu_List=[
  n0 e0. n5 e1. n6;
  metanotal_spine has_part. dorsal_side bearer_of. pointed;
  metanotal_spine has_part. dorsal_side bearer_of. pointed;
  ]]
OTU=[OTU_model=[sp2 sp2. sp2 sp4. sp2;] Ophu_List=[n0 e0. n5 e1. n10;]]
'''


query = '''
OTU=[OTU_model=[sp1 sp2. sp3;] Ophu_List=[n0 e0. n5;]]
'''

query ='''
    OTU=[ # this is comment
      OTU_model=[sp1@ii1 sp2. sp3;]
      Ophu_List=[
        (profemur@ii2['pr1'=1, 'pr2'=2] has_part. ventral_region@v1) has_part. apical_region2 bearer_of. punctate5;
        (profemur, eye) has_part. ventral_region9;]
    ]
'''

out=grammar1.parseString(query)
print(out)
out_xml=phenoscriptParse(out)
print(out_xml)
print(out_xml, file=open('/Users/taravser/Documents/My_papers/Phenoscript_2021/Phenoscript/ophu_xml.txt','w'))

#print(out.asXML())
nn=makeNodes(out[0], pos=1)
print(nn)

# repl_python()
# from owlready2 import *
# exit
