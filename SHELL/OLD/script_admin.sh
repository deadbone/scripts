#!/opt/bin/bash
HOST=`uname -n`
DATEFILE=`date +%Y%m%d`
DATE=`date +%d/%m/%Y`
LIGNE='-------------------------------------'
SEPARATION='#############################################################'
# Construction d'un tableau contenant les scripts
# faisant partie du menu principal
i=0

for element in `ls script_*.sh | grep -v script_admin | sed s/\.sh/\ / | sed s/script_/\/ | sed s/screen_/\/ | sed s/SYS_/\/ | sort -d` 
	do 
		fichier[$i]=$element
		((i++)) 
	done
# On ajoute un element supplementaire pour donner 
# la possibilité de sortir du script

((i++))
fichier[$i]="MENU"
((i++))
fichier[$i]="SORTIR"

PS3="$SEPARATION
MENU   --> $((${#fichier[@]}-1 ))
SORTIR --> $((${#fichier[@]} ))
Votre choix : "



# Affichage du menu 
REPONSE=0
while [ $REPONSE -ne 3 ]
do

echo $SEPARATION
echo "#                                                           #"
echo "#                 Script d'administration                   #"
echo "#                                                           #"
echo $SEPARATION
echo "HOST : $HOST"
echo "USER : $USER"
echo "DATE : $DATE"
echo $SEPARATION

	select SCRIPT in "${fichier[@]}";
	do
	
		# la sortie est le dernier element
		# dont exit si selectionné
		if [ "$REPLY" == ${#fichier[@]} ]
		then
			echo "Fin de script"
			exit
		fi
		
if [ "$REPLY" == $((${#fichier[@]}-1 )) ]
then 
j=1
echo "============================================================="
echo "========================     MENU    ========================"
echo "============================================================="
	for sub_menu in "${fichier[@]}";
do
printf "%s %s ($j)\n" $sub_menu ${LIGNE:${#sub_menu}}
       	((j++))
done
echo "============================================================="
	

	#reaffichage_menu ${fichier[*]}
else

		#Si choix inexistant, on previent
		if [ -z "$SCRIPT" ]; then
				echo $SEPARATION
				echo
    			echo '----> MAUVAIS CHOIX'
    			echo
    			#echo $SEPARATION
    		else
    		    echo $SEPARATION
    			echo "Choix : $SCRIPT"
    			REALNAME=`ls | grep script_*$SCRIPT.sh`
			
			if [ "$REALNAME" != "" ]
			then
			
			CMD=`echo $REALNAME | grep -i screen`
			
				if [ "$CMD" == "" ];
				then
					echo "--> Commande en sortie standard"
					#sh "script_$SCRIPT.sh"
					sh $REALNAME
				else
					echo "--> Commande en mode screen"
					#screen -d -m ./"script_$SCRIPT.sh"
					screen -d -m ./$REALNAME
				fi
			fi			

			REPONSE=$REPLY
			#echo $SEPARATION
		fi

fi	
	done 
	
	echo "==================================================="
done
