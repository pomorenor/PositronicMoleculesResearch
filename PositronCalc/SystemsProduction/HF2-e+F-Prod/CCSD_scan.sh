#!/usr/bin/env bash     


LC_NUMERIC="C"
CALC_NAME=$1
DATA_FILE=$2
TEMPLATE="LinearMolAnion_Template.com"

DIST=(1.5 2.0 2.5 3.0 3.2 3.4 3.5 3.6 3.8 4.5 6.0 7.0 9.4 12.5)

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

