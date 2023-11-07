AppID=openbooks
AppDir=${UMBREL_ROOT}/app-data/unique-$AppID
ConfDir=${UMBREL_ROOT}/data/storage/unique-store/$AppID
source $AppDir/unique-store.sh

export RM_NAME_name=$(curl -s https://randomuser.me/api/)
export RM_NAME_first=$(echo $RM_NAME_name | jq ."results[0]".name.first | sed 's/"//g')
export RM_NAME_last=$(echo $RM_NAME_name | jq ."results[0]".name.last | sed 's/"//g')
export RM_NAME="$RM_NAME_first"_"$RM_NAME_last"

export UMBREL_EBOOK_DOWNLOADS=${UMBREL_ROOT}/data/storage/downloads/ebooks
mkdir -p $UMBREL_EBOOK_DOWNLOADS