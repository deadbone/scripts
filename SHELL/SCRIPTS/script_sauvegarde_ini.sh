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

echo "repertoire ${REP_BACKUP}"

#Sauvegarde sabnzbd.ini
echo "Sauvegarde sabnzbd"
mkdir sabnzbd
cp -p /usr/local/sabnzbd/var/config.ini  ${REPDATE}/sabnzbd
cp -p -r /usr/local/sabnzbd/var/scripts/* ${REPDATE}/sabnzbd

#Sauvegarde headphones.ini
echo "Sauvegarde headphones"
mkdir headphones
cp -p /usr/local/headphones/var/config.ini  ${REPDATE}/headphones

#Sauvegarde sickbeard-custom (sickrage)
echo "Sauvegarde sickbeard-custom"
mkdir sickbeard-custom
cp -p /usr/local/sickbeard-custom/var/config.ini  ${REPDATE}/sickbeard-custom

echo "Sauvegarde fichiers HomeBridge"
mkdir -p homebridge/persist
cp -p /volume1/docker/homebridge/*.*  ${REPDATE}/homebridge
cp -p /volume1/docker/homebridge/persist/*.*  ${REPDATE}/homebridge/persist
 
echo "Sauvegarde fichiers HomeBridgeHue"
mkdir -p homebridgehue/persist
cp -p /volume1/docker/homebridgehue/*  ${REPDATE}/homebridgehue
cp -p /volume1/docker/homebridgehue/persist/*.*  ${REPDATE}/homebridgehue/persist

#Notification
envoyerNotification "$PUSHTOKEN_SCRIPT" "${NOM_TACHE}" "Fin de script"
exit 0
