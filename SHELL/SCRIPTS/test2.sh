#!/bin/bash

NOM_SCRIPT=$(basename "$0")
echo "le script est ${NOM_SCRIPT}"

OLDIFS=$IFS
IFS=';'


checkVar(){
	
	usage () {
		 echo "Missing argument $0 -->$#" 
		}
	if [ $# != 1 ]; then
	usage
	    #exit 1
	fi

	read -ra myArray <<< "$1"

	if [ ${#myArray[@]} == 0 ]; then
		echo "Argument list must contain at least one item."
		#exit 1
	fi

	for (( i=0; i<${#myArray[@]}; i++ ));
	do

		myArrayItem=${myArray[$i]}
		myElement=$(eval "echo \$$myArrayItem")
		
		if [ -z "${myElement// }" ]; then
   			echo "Variable ${myArrayItem} is empty"
			#exit 1
		fi
	done
}


V1="FOO1"
V2="FOO2"
V3=""

MYVAR="V1;V2;RPMDEBUILD_KJC"
echo "=================================================="
echo "test 1" 
checkVar "${MYVAR}"
echo "=================================================="
echo "test 2"
checkVar
echo "=================================================="
echo "test 3"
checkVar "toto"
echo "=================================================="


IFS=$OLDIFS
exit 0
