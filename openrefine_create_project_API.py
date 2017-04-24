import sys
import os


sys.path.append("refine.py")
import refine

r = refine.Refine()
p = r.new_project(sys.argv[1])
#p.apply_operations("operations.json")
print p.export_rows()

