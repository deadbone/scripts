#!/opt/bin/bash
#--------------------------------------------
# VARIABLES
#######################################################
# Ce script utilise le user ROOT dans la plannification
#
#/volume1/download/SCRIPTS/setEnv.sh;
# /volume1/download/SCRIPTS/script_sauvegarde_ini.sh > /volume1/download/SCRIPTS/log.txt 2>&1
######################################################


. /volume1/download/SHELL/ENV/setEnv.sh

source ${REP_SCRIPT}/TOOLS.sh

NOM_TACHE="script_sauvegarde_ini.sh"
FICHIER="/volume1/download/SCRIPTS/TRACE_${NOM_TACHE}.log"
REP_BACKUP="/volume1/dropbox/Prive/BACKUP_WEB/CONFIG"

#--------------------------------------------
# DEBUT DU PROGRAMME
#--------------------------------------------

#insertionDebutBDD "${NOM_TACHE}"

DATE=`donnerDate "inverse"`

REPDATE="${REP_BACKUP}/${DATE}"

cd ${REP_BACKUP}

rm -fr ${DATE}

mkdir ${DATE}
cd ${DATE}

echo "repertoire ${REP_BACKUP}" > ${FICHIER}

#Sauvegarde sabnzbd.ini
echo "Sauvegarde sabnzbd" >> ${FICHIER}
mkdir sabnzbd >> ${FICHIER}
cp -p /usr/local/sabnzbd/var/config.ini  ${REPDATE}/sabnzbd >> ${FICHIER}
cp -p -r /usr/local/sabnzbd/var/scripts/* ${REPDATE}/sabnzbd >> ${FICHIER}
#penser a copier les script pre et post

#Sauvegarde headphones.ini
echo "Sauvegarde headphones" >> ${FICHIER}
mkdir headphones >> ${FICHIER}
cp -p /usr/local/headphones/var/config.ini  ${REPDATE}/headphones >> ${FICHIER}

#Sauvegarde sickbeard-custom (sickrage)
echo "Sauvegarde sickbeard-custom" >> ${FICHIER}
mkdir sickbeard-custom >> ${FICHIER}
cp -p /usr/local/sickbeard-custom/var/config.ini  ${REPDATE}/sickbeard-custom >> ${FICHIER}

echo "Sauvegarde fichiers HomeBridge" >> ${FICHIER}
mkdir -p homebridge/persist >> ${FICHIER}
cp -p /volume1/docker/homebridge/*.*  ${REPDATE}/homebridge >> ${FICHIER}
cp -p /volume1/docker/homebridge/persist/*.*  ${REPDATE}/homebridge/persist >> ${FICHIER}
 
echo "Sauvegarde fichiers HomeBridgeHue" >> ${FICHIER}
mkdir -p homebridgehue/persist >> ${FICHIER}
cp -p /volume1/docker/homebridgehue/*  ${REPDATE}/homebridgehue >> ${FICHIER}
cp -p /volume1/docker/homebridgehue/persist/*.*  ${REPDATE}/homebridgehue/persist >> ${FICHIER}

#echo "Sauvegarde fichiers HomeBridgeTest2" >> ${FICHIER}
#mkdir -p homebridgetest2/persist >> ${FICHIER}
#cp -p /volume1/docker/homebridgetest2/*.*  ${REPDATE}/homebridgetest2 >> ${FICHIER}
#cp -p /volume1/docker/homebridgetest2/persist/*.*  ${REPDATE}/homebridgetest2/persist >> ${FICHIER}

DESC=`cat $FICHIER`
effacerFichier $FICHIER 


#MAJ BDD
#insertionInformationBDD "${NOM_TACHE}" "${DESC}"
#insertionFinBDD "${NOM_TACHE}" "OK"

#Notification
envoyerNotification "$PUSHTOKEN_SCRIPT" "${NOM_TACHE}" "Fin de script"
exit 0