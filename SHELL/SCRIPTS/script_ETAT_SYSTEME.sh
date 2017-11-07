#!/opt/bin/bash
# script etat systeme
# DeadBone 


#--------------------------------------------
# VARIABLES
#--------------------------------------------
NOM_TACHE=`basename "$0"`

source /volume1/download/SHELL/ENV/setEnv.sh
source $REP_SCRIPT/TOOLS.sh

#--------------------------------------------
# DEBUT DU PROGRAMME
#--------------------------------------------

IP=`curl -s http://checkip.dyndns.org | sed 's/[a-zA-Z/<> :]//g'`
envoyerNotification "$PUSHTOKEN_SCRIPT" "${NOM_TACHE}" "${IP}"
exit 0