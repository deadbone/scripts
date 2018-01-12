#!/opt/bin/bash
# Script de mise à jour de la configuration de nginx suite mise à jour DSM pour l'acces aux websocket
# version 1
# DeadBone 


#--------------------------------------------
# VARIABLES
#--------------------------------------------
NOM_TACHE=`basename "$0"`

#repertoire nginx
D_PRODUCTION="/usr/syno/share/nginx/"
#Fichier utilisé par nginx
F_PRODUCTION="Portal.mustache"
#Repertoire de comparaison
D_BACKUP="${REP_DLD}/SAVE_CONFIG/NGINX/"
#Fichier modifié pour websocket
F_MODIFIED="Portal.mustache.new"
#Fichier "normal" de DSM
F_BACKUP="Portal.mustache.orig"
#fichier de test uniquement
F_TEST="Portal.mustache.test"

source $REP_SCRIPT/TOOLS.sh
#--------------------------------------------
# PROGRAMME PRINCIPAL
#--------------------------------------------
DIFF=`diff ${D_PRODUCTION}${F_PRODUCTION} ${D_BACKUP}${F_MODIFIED}`

#Verification de la version prod avec la version modifiée voulue
if  [ "${DIFF}" == "" ]; then
	echo "Fichier identique : RAS"
	envoyerNotification "$PUSHTOKEN_SCRIPT" ${NOM_TACHE} "Fichier identique : RAS"
	exit 0;
	else
		echo "Difference"
		DIFF=`diff ${D_PRODUCTION}${F_PRODUCTION} ${D_BACKUP}${F_BACKUP}`
		
	if  [ "${DIFF}" == "" ]; then
		echo "Retour a original"
		cp ${D_BACKUP}${F_MODIFIED} ${D_PRODUCTION}${F_PRODUCTION}
		synoservicecfg --restart nginx	
		envoyerNotification "$PUSHTOKEN_SCRIPT" ${NOM_TACHE} "Configuration nginx restauree"
	else
		echo "Nouveau format de fichier"
		envoyerNotification "$PUSHTOKEN_SCRIPT" ${NOM_TACHE} "Attention : nouvelle configuration nginx"
		exit 0;
	fi
	
fi

exit 0