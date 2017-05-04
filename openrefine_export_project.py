import sys
import os


sys.path.append("refine.py")
import refine

r = refine.Refine()
p = r.new_project("dates.txt")
#p.apply_operations("operations.json")
localefile = open("fichier_to_get.txt",'w')
localefile.write(p.export_rows())
put("fichier_to_get.txt", file_type='txt')


