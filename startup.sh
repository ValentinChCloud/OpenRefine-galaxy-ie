#!/bin/bash

sed -i "s|PROXY_PREFIX|${PROXY_PREFIX}|" /proxy.conf;
cp /proxy.conf /etc/nginx/sites-enabled/default;

# Here you would normally start whatever service you want to start. In our
# example we start a simple directory listing service on port 8000

#By default (and for security reasons) Refine only listens to TCP requests coming from localhost (127.0.0.1 on port 3333) . If you want to respond to TCP request coming to any Ip adress the machine has, #run refine like this from the command line :
#./refine -i 0.0.0.0
exec ../OpenRefine/refine -d /mnt/refine &

#load dataset into openrefine
/openrefine_import.sh &

#Check if openrefine is up to work
STATUS=$(curl --include 'http://127.0.0.1:3333' 2>&1)
while [[ ${STATUS} =~ "refused" ]]
do
  echo "waiting for openrefine: $STATUS \n"
  STATUS=$(curl --include 'http://127.0.0.1:3333' 2>&1)
  sleep 2
done

# Createnew project with the dataset
python /refine-python/openrefine_create_project_API.py /import/$DATASET_HID &

#Test export in datasheet galaxy
python /refine-python/openrefine_export_project.py &
# Launch traffic monitor which will automatically kill the container if traffic
# stops
/monitor_traffic.sh &
#And nginx in foreground mode.
nginx -g 'daemon off;'
