#!/usr/bin/env bash     


LC_NUMERIC="C"
DATA_FILE=$1
INPUT_NAME=$2
TEMPLATE_USUAL_CALC="propagatorTemplateProd.lowdin"



DIST=(2.5 3.5 4.0 4.5 5.0 6.0)

STEP=0

for STEP in "${!DIST[@]}"; do

	echo -e "T$STEP \n"

	LOWDIN_FILE_USUAL="$INPUT_NAME$STEP.lowdin"
	LOWDIN_OUTPUT_USUAL="$INPUT_NAME$STEP.out"

	echo -e "Editing LOWDIN files \n"
	
	sed "3s|POS|"${DIST[$STEP]}"|g" $TEMPLATE_USUAL_CALC > $LOWDIN_FILE_USUAL
	sed -i "7s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_USUAL
	sed -i "11s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_USUAL


	echo -e "Running LOWDIN calculations"

	openlowdin -i $LOWDIN_FILE_USUAL -n 10 

	echo -e "Extracting total Energy \n"
	PROPAGATOR_ENERGY=$(awk '/SUMMARY OF PROPAGATOR RESULTS FOR THE SPIN-ORBITAL: 1  OF SPECIES:POSITRON/ {target_line = NR} NR == target_line+11 {print}' $LOWDIN_OUTPUT_USUAL | awk '/REN-P3/ {print $2*0.03674931}')
	echo -e "${DIST[$STEP]} \t $PROPAGATOR_ENERGY \n"

	echo "${DIST[$STEP]} $PROPAGATOR_ENERGY" >> $DATA_FILE 

done

