import sys
import os


sys.path.append("refine.py")
import refine

r = refine.Refine()
p = r.new_project(sys.argv[1])
cwd = os.getcwd()

	try:
		os.mkdir(cwd+'/temp_dossier')
	except OSError:
		pass
		with open(cwd+'/temp_dossier/project_openrefine','wb') as fichier :
		mon_pickler = pickle.Pickler(fichier)
		mon_pickler.dump(p)

