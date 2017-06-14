# OpenRefine-galaxy-ie
Galaxy Interactive Environment for theOpenRefine spreadsheet application

To deploy Openrefine as IE in galaxy :

#Add openrefine as interactive environnement
```
#############################################

mkdir $HOME/openrefine-install && cd /$HOME/openrefine-install && git clone https://github.com/ValentinChCloud/OpenRefine-galaxy-ie 
mkdir $HOME/galaxy/config/plugins/interactive_environments/openrefine
path_galaxy_openrefine=$(echo $HOME/galaxy/config/plugins/interactive_environments/openrefine)
path_install_openrefine=$(echo $HOME/openrefine-install/OpenRefine-galaxy-ie)
mv $path_install_openrefine/GIE/config $path_galaxy_openrefine && \
	mv $path_install_openrefine/GIE/static $path_galaxy_openrefine && \
		mv $path_install_openrefine/GIE/templates $path_galaxy_openrefine
			
			rm -r $HOME/openrefine-install/OpenRefine-galaxy-ie/GIE

```
# Add the path to the interactives environnements if isn't already set
```
#############################################
test_path_interactive_set=$(cat $GALAXY_ROOT/config/galaxy.ini |grep "interactive_environment_plugins_directory =" |cut -d"=" -f2)
if [ -n "$test_path_ineractive" ]; then
	echo "The path is already set : $test_path_interactive_set"
	else
		echo "Add the path to config/plugins/interactive_environments to galaxy.ini"
			sed -i 's/\(#interactive_environment_plugins_directory =\)/interactive_environment_plugins_directory = config\/plugins\/interactive_environments/' "$GALAXY_ROOT/config/galaxy.ini"
			fi


cd $HOME/openrefine-install/OpenRefine-galaxy-ie
docker build -t openrefine 
```
