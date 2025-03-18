#!/usr/bin/env bash     


LC_NUMERIC="C"
DATA_FILE=$1

#DISTANCE=$1	
#FIT_FILE=$2
#POTENTIAL_FILE="POTENTIALSTEP"
#POTENTIALS_FOLDER="/home/pohl/Desktop/LOWDIN/dependencies/bin/.lowdin2/lib/potentials"
#LOWDIN_FILE=$3
#LOWDIN_OUTPUT=$4
#DATA_RESULTS=$5
#TEMPLATE_ONLY_P="/home/pohl/Desktop/PositronWork/Be_OCT28/template_posi.lowdin"
TEMPLATE_USUAL_CALC="template_usual.lowdin"




DIST=()

for i in $(seq 1.5 0.5 20); do
	DIST+=($i)
done 

STEP=0

for STEP in "${!DIST[@]}"; do

	echo -e "T$STEP \n"


    	#WFN_FILE="c_guess_$STEP.vec"
	LOWDIN_FILE_USUAL="c_step_$STEP.lowdin"
	LOWDIN_OUTPUT_USUAL="c_step_$STEP.out"

	#echo -e "Renaming wave function file \n" 
	#cp lowdin.wfn WFN_FILE

	
	echo -e "Editing LOWDIN files \n"
	
	
	sed "3s|POS|"${DIST[$STEP]}"|g" $TEMPLATE_USUAL_CALC > $LOWDIN_FILE_USUAL
	sed -i "7s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_USUAL
	sed -i "11s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_USUAL
	

	echo -e "Running LOWDIN calculations \n"


	lowdin2 -i $LOWDIN_FILE_USUAL -n 5
	
	echo -e "Extracting total Energy \n"
	ENERGY_USUAL=$(awk '/E\(MP/ {print $3}' $LOWDIN_OUTPUT_USUAL)
       	TOTAL_ENERGY=$(awk '/TOTAL ENERGY = / {print $4}' $LOWDIN_OUTPUT_USUAL)	
	#echo -e "$ENERGY_ONLY_POSI \n"
	echo -e "${DIST[$STEP]} \t $ENERGY_USUAL $TOTAL_ENERGY \n"

	echo "${DIST[$STEP]} $ENERGY_USUAL $TOTAL_ENERGY"  >> $DATA_FILE 

done

