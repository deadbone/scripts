#!/opt/bin/bash
#--------------------------------------------
# VARIABLES

. /volume1/download/SHELL/ENV/setEnv.sh
source ${REP_SCRIPT}/TOOLS.sh

NOM_TACHE=`basename "$0"`
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

#Notification
envoyerNotification "$PUSHTOKEN_SCRIPT" "${NOM_TACHE}" "Fin de script"
exit 0