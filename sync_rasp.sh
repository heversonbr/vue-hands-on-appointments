#!/bin/bash

source .env

echo "**************************************************"
echo "Rsync local repository and  rasp $HOST"
echo "**************************************************"

echo "rsync -avh $SRC_PATH $USER@$HOST:$REMOTE_PATH --exclude=$EXCLUDE_FILES"
echo "--------------------------------------------------"
rsync -avh $SRC_PATH $USER@$HOST:$REMOTE_PATH --exclude=$EXCLUDE_FILES
echo "--------------------------------------------------"
echo "Done !!!" 