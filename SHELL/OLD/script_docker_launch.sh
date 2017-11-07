#!/opt/bin/bash
# script gestion ressources 
# version 3.2
# DeadBone 


#--------------------------------------------
# VARIABLES
#--------------------------------------------
NOM_TACHE="script_Docker_Launch.sh"
source $REP_SCRIPT/TOOLS.sh

if [ $# != 2 ]; then

    exit 1
fi

envoyerNotification "$PUSHTOKEN_SCRIPT" "$2" "$1 en cours"
docker $1 $2
envoyerNotification "$PUSHTOKEN_SCRIPT" "$2" "$1 ok"


exit 0