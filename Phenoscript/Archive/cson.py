
#pip install --target=/Users/taravser/anaconda3/envs/r-reticulate/lib/python3.7/ cson

import cson


# Opening file
f = open('snippets.cson')
obj = cson.load(f)
obj['.source.r']['BSPO_0000105']
type(obj)
obj{1}

cson.loads('a: 1')


with open('snippets.cson', 'rb') as fin:
  obj = cson.load(fin)

obj
