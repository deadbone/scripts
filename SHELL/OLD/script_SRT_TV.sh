#!/opt/bin/bash
#--------------------------------------------
#
# Declaration des variables
#
#--------------------------------------------
NOM_TACHE="Recherche_SRT_TV"
FICHIER="TRACE_${NOM_TACHE}.log"

if [ "$HOME" = "" ] ; then
    HOME=~Thierry
    export HOME
fi


#--------------------------------------------
# DEBUT DU PROGRAMME
#--------------------------------------------

source $REP_SCRIPT/TOOLS.sh

DATE=`donnerDate "inverse"`

#----------------------------------------------------
#
# PROGRAMME
#
#----------------------------------------------------

insertionDebutBDD "${NOM_TACHE}"

./subli_findTV.sh "$REP_TV">> $FICHIER


DESC=`cat $FICHIER`

insertionInformationBDD "${NOM_TACHE}" "${DESC}"

insertionFinBDD "${NOM_TACHE}" "OK"


envoyerNotification "$PUSHTOKEN_SCRIPT" "${NOM_TACHE}" "fin de script"
