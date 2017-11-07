#!/opt/bin/bash

#Input parameters

#All parameters (except 1) can be empty, meaning a default value.
# 1 : Name of the NZB (no path, no ".nzb")
# 2 : Post Processing (PP) flags: 0 = Download, 1 = +Repair, 2 = +Unpack, 3 = +Delete
# 3 : Category
# 4 : Script (no path)
# 5 : Priority (-100 = Default, -2 = Paused, -1 = Low, 0 = Normal, 1 = High, 2 = Force)
# 6 : Size of the download (in bytes)
# 7 : Group list (separated by spaces)
# 8 : Show name
# 9 : Season (1..99)
# 10 : Episode (1..99)
# 11: Episode name


# Return parameters
# 
# The script writes the results to the console, each parameter on a separate line.
# Each parameter (except 1) can be an empty line, meaning the original value.
# 1 : 0=Refuse, 1=Accept
# 2 : Name of the NZB (no path, no ".nzb")
# 3 : Post Processing (PP) flags: 0 = Download, 1 = +Repair, 2 = +Unpack, 3 = +Delete
# 4 : Category
# 5 : Script (basename)
# 6 : Priority (-100 = Default, -2 = Paused, -1 = Low, 0 = Normal, 1 = High, 2 = Force)
# 7 : Group to be used (in case your provider doesn't carry all groups and there are multiple groups in the NZB)


#--------------------------------------------
# VARIABLES
#--------------------------------------------
. /volume1/download/SCRIPTS/setEnv.sh
source $REP_SCRIPT/TOOLS.sh

CATUNKNOW="*"
JOB_TITLE="$1"
JOB_CAT="$3"
CAT_TV="TV"
EXIT_ACCEPT_NZB="1"
#--------------------------------------------
# DEBUT DU PROGRAMME
#--------------------------------------------
	echo 1
	
	DATE=`donnerDate "heure"`
 	
  	#envoyerNotification $PUSHTOKEN_SABNZBD "[$JOB_TITLE]:  [$2] [$3] [$4] [$5] [$6]" "$DATE" 
      
	#Si categorie differente de unknow, on sort car sabnzbd gere le deplacement.
	if [ "$JOB_CAT" != "" ]
	then
		  	exit $EXIT_ACCEPT_NZB
	fi
	
	#envoyerNotification $PUSHTOKEN_SABNZBD "$JOB_TITLE -> $JOB_CAT"

		if [[ "$JOB_TITLE" =~ [sS]{1}[0-9]{2}[eE]{1}[0-9]{2} ]] 
			then

			#envoyerNotification $PUSHTOKEN_SABNZBD "$JOB_TITLE -> categorie TV" "$DATE"
			#echo 1
			echo " "
			echo " "
			echo $CAT_TV
			#echo " "
			#echo " "			
			#echo " "	
				
			#echo "1" "$JOB_TITLE" " " "$CAT_TV"	
						
			exit 0	

		fi
		
		exit $EXIT_ACCEPT_NZB	