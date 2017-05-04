import sys
import os

#API to help interactive environnement get data from galaxy
from galaxy_ie_helpers import put



sys.path.append("refine.py")
import refine
r = refine.Refine()
p = r.new_project("dates.txt")
#p.apply_operations("operations.json")
localefile = open("fichier_to_get.txt",'w')
localefile.write(p.export_rows())
localefile.close()
put("fichier_to_get.txt", file_type='txt')




