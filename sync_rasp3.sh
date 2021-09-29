#!/bin/bash

SRC_PATH='./dist/*'
REMOTE_PATH='/home/heversonbr/nginx_home/content/http/appointments_app'
HOST='my-rasp3'
USER='heversonbr'
EXCLUDE_FILES={'sync_rasp3.sh'}

echo "**************************************************"
echo "Rsync local repository and  rasp $HOST"
echo "**************************************************"

echo "rsync -avh $SRC_PATH $USER@$HOST:$REMOTE_PATH --exclude=$EXCLUDE_FILES"
echo "--------------------------------------------------"
rsync -avh $SRC_PATH $USER@$HOST:$REMOTE_PATH --exclude=$EXCLUDE_FILES
echo "--------------------------------------------------"
echo "Done !!!" 