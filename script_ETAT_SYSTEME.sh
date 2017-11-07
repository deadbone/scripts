#!/opt/bin/bash
# script etat systeme
# DeadBone 


#--------------------------------------------
# VARIABLES
#--------------------------------------------
NOM_TACHE=`basename "$0"`

source /volume1/download/SHELL/ENV/setEnv.sh
source $REP_SCRIPT/TOOLS.sh
HOST=`uname -n`
FICHIER="$REP_SCRIPT/$HOST.txt"
DATE=`donnerDate "heure"`


#--------------------------------------------
# DEBUT DU PROGRAMME
#--------------------------------------------


IP=`curl -s http://checkip.dyndns.org | sed 's/[a-zA-Z/<> :]//g'`
#echo "IP : "${IP} >> $FICHIER
#ecrirePresentation "=" 80  >> $FICHIER


#echo "Liste connexion :"  >> $FICHIER
#who >> $FICHIER
#ecrirePresentation "=" 80  >> $FICHIER

#echo "Taille Disque :"  >> $FICHIER
#df -Ph  >> $FICHIER
#ecrirePresentation "=" 80  >> $FICHIER

#echo "Configuration Reseau :"  >> $FICHIER
#ifconfig | grep inet | grep -v inet6  >> $FICHIER
#ecrirePresentation "=" 80  >> $FICHIER


#echo "Liste derniers episodes TV : $REP_TV" >> $FICHIER
#find $REP_TV -type d -mtime -1 >> $FICHIER 
#ecrirePresentation "=" 80  >> $FICHIER


#echo "Liste derniers films : $REP_FILM" >> $FICHIER
#find $REP_FILMS -type d -mtime -1 >> $FICHIER
#ecrirePresentation "=" 80 >> $FICHIER

#DESC=`cat $FICHIER`


envoyerNotification "$PUSHTOKEN_SCRIPT" "${NOM_TACHE}" "${IP}"

exit 0