#!/usr/bin/env bash     


LC_NUMERIC="C"
CALC_NAME=$2
DATA_FILE=$1
TEMPLATE="LinearMolAnion_Template.com"

DIST=(3.2 3.6 4.0 4.2)

#for i in $(seq 1.5 0.5 20); do
#	DIST+=($i)
#done 

STEP=0

for STEP in "${!DIST[@]}"; do

	echo -e "Step number $STEP \n"
	GAUSSIAN_INPUT_FILE="$CALC_NAME_$STEP.com"
	GAUSSIAN_OUTPUT_FILE="$CAL_CNAME_$STEP.log"

	echo -e "Editing Gaussian16 File"
	sed "9s|POS|"${DIST[$STEP]}"|g" $TEMPLATE > $GAUSSIAN_INPUT_FILE
	
	echo -e "Running Gaussian16 SP calculation"
	g16 < $GAUSSIAN_INPUT_FILE > $GAUSSIAN_OUTPUT_FILE
	
	echo -e "Extracting CCSD Energy \n"
	CCSD_ENERGY=$(awk -F '\\' '{for(i=1;i<NF;i++){if($i~/CCSD=/){split($i,a,"=");print a[2]}}}' $GAUSSIAN_OUTPUT_FILE )

	echo -e "${DIST[$STEP]} \t $CCSD_ENERGY \n"

	echo "${DIST[$STEP]} $CCSD_ENERGY "  >> $DATA_FILE 

done

