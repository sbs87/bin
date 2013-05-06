#!/usr/bin/python
import sys

#union=["Gene1","Gene2","Gene3"]
f_union=open(sys.argv[1],"r")
union=f_union.readlines()
f_union.close()
union = map(lambda s: s.strip(), union)

f_list=open(sys.argv[2],"r")
list=f_list.readlines()
f_list.close()
list = map(lambda s: s.strip(), list)

#list={"Gene1":"Val1","Gene3":"Val3"}
for key in union:
    print key,
    if key in list:
        print "\tX"
    else:
        print "\t"