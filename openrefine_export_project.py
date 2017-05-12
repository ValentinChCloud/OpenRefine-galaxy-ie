import sys
import os

#API to help interactive environnement get data from galaxy
from galaxy_ie_helpers import put

sys.path.append("refine.py")
import refine
r = refine.Refine()


if os.path.isfile("fichier_donnee.txt"):
	print "sortie erreur"
	os.remove("fichier_donnee.txt")

else:
	print "Mon coco"
	cwd = os.getcwd()

	localefile= open('fichier_donnee.txt','w')	
	localefile.write('true')
	print('Le fichier a bien ete crer  pas vrai?: ')
	print(os.path.isfile('fichier_donnee.txt'))


	try:
		os.mkdir(cwd+'/temp_dossier')
	except OSError:
		pass
	with open (cwd+'/temp_dossier/project_openrefine','rb') as fichier :
		mon_depickler = pickle.Unpickler(fichier)
		score_recupere = mon_depickler.load()
	print score_recupere.export_rows()
	localefile= open('fichier_to_get.txt','w')	
	localefile.write(score_recupere.export_rows())
	put("fichier_to_get.txt", file_type='txt')
	sys.exit()






