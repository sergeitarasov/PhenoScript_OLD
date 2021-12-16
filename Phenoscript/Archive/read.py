# setwd("~/Documents/My_papers/Phenoscript_2021/Gryonoides/Phenoscript/example")

from pathlib import Path

# read in descriptions
#txt = Path('ex1.r').read_text()
#txt = Path('Gryo_test.r').read_text()
#txt = txt.replace('\n', '')

#from phs_parser import * # here is parser
#from phs_xml import * # here to make xml output
path_src="/Users/taravser/Documents/My_papers/Phenoscript_2021/Gryonoides/Phenoscript/src/"
exec(open(path_src+"phs_xml.py").read())
exec(open(path_src+"phs_parser.py").read())
exec(open(path_src+"phs_lbs2iri.py").read())
# exec(open("/Users/taravser/Documents/My_papers/Phenoscript_2021/Phenoscript/src/phs_parser.py").read())
# exec(open("/Users/taravser/Documents/My_papers/Phenoscript_2021/Phenoscript/src/phs_xml.py").read())
# exec(open("/Users/taravser/Documents/My_papers/Phenoscript_2021/Phenoscript/src/phs_lbs2iri.py").read())

#txt = Path('Gryo.txt').read_text()
#txt = Path('ex1.r').read_text()
#txt = Path('Gryo_test.r').read_text()
txt = Path('phenoscriptsnewGryonoides_final.txt').read_text()
# check if brackets are balanced
isBalanced(txt)
out=grammar1.parseString(txt)
print(out)
out_xml=phenoscriptParse(out)
print(out_xml)
#print(out_xml, file=open('ex1_xml.txt','w'))
print(out_xml, file=open('Gryo_xml.txt','w'))

#---- Translate IRIs
# get phs Dictionary
#fl='aismDic.csv'
fl='/Users/taravser/Documents/My_papers/Phenoscript_2021/Gryonoides/Phenoscript/phsDictionary/Gryo_dic.csv'
iriDic=labels2IRI(fl)
iriDic.translate('part_of')
iriDic.translate('sp')
iriDic.translate('bearer_of')
iriDic.translate('mesoscutum')

# read in file and translate
#tree = ET.parse('ex1_xml.txt')
tree = ET.parse('Gryo_xml.txt')
ET.register_namespace('phs', 'https://github.com/sergeitarasov/PhenoScript')
#ns = {'phs': 'https://github.com/sergeitarasov/PhenoScript'}
root1 = tree.getroot()
translatePhs(root1, iriDic)
print(ET.tostring(root1, encoding='utf8').decode('utf8'))
#tree.write('ex1_transl.xml')
tree.write('Gryo_trans.xml')
