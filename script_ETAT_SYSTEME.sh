#!/opt/bin/bash
# script gestion ressources 
# version 3.2
# DeadBone 


#--------------------------------------------
# VARIABLES
#--------------------------------------------
NOM_TACHE="script_ETAT_SYSTEME.sh"

WHO=`whoami`
source /volume1/download/SHELL/ENV/setEnv.sh
source $REP_SCRIPT/TOOLS.sh
HOST=`uname -n`
FICHIER="$REP_SCRIPT/$HOST.txt"
DATE=`donnerDate "heure"`
myoptions='sf'
sflag=false #silent mode


#--------------------------------------------
# DEBUT DU PROGRAMME
#--------------------------------------------

while getopts $myoptions myoption
do 
#echo "option =$myoption"
    case $myoption in
        s) sflag=true;;
		f) FICHIER="GLOBAL_SYSTEME.log";;
        \? ) echo "option inconnue: $myoption" >&2; exit 1;;
        :  ) echo "argument manquant pour $myoption" >&2; exit 1;;
        * ) echo "option inconnue : -$OPTARG" >&2; exit 1;;
    esac
done

if ! $sflag
	then
		effacerFichier $FICHIER
	fi

if [ "$HOST" = "localhost" ];
then    
	        echo "localhost" > $FICHIER
		        cp $FICHIER $REP_DROPBOX/Public/LOGS
			        exit 0
			fi 
#{


insertionDebutBDD "${NOM_TACHE}"


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

#insertionInformationBDD "${NOM_TACHE}" "${DESC}"

insertionFinBDD "${NOM_TACHE}" "OK"

envoyerNotification "$PUSHTOKEN_SCRIPT" "${NOM_TACHE}" "${IP}"

effacerFichier $FICHIER

exit 0