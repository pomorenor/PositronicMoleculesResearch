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
#TEMPLATE_WFN_CALC="/home/pohl/Desktop/PositronMoleculeSystems/PositronicMoleculesResearch/PositronCalc/F2-e+F-/template_nowfn.lowdin"



DIST=(1.5 2.0 2.5 3.0 3.2 3.4 3.5 3.6 3.8 4.5 6.0 7.0 9.4 12.5)

#for i in $(seq 1.5 0.5 20); do
#	DIST+=($i)
#done 

STEP=0

for STEP in "${!DIST[@]}"; do

	echo -e "T$STEP \n"

    	WFN_FILE="c_step_$STEP.vec"
	LOWDIN_FILE_NOW="c_step_nw_$STEP.lowdin"
	LOWDIN_FILE_USUAL="c_step_$STEP.lowdin"
	LOWDIN_OUTPUT_USUAL="c_step_$STEP.out"



	
	#echo -e "Editing LOWDIN files \n"
	
	
	#sed "3s|POS|"${DIST[$STEP]}"|g" $TEMPLATE_WFN_CALC > $LOWDIN_FILE_NOW
	#sed -i "6s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_NOW
	#sed -i "9s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_NOW
	

	#echo -e "Running LOWDIN calculations fow wfn \n"


	#openlowdin -i $LOWDIN_FILE_NOW -n 9 -w


	#echo -e "Renaming wave function file \n"
	#cp lowdin.wfn $WFN_FILE
	#mv lowdin.wfn auxiliary
	#mv auxiliary lowdin.wfn

	echo -e "Editing LOWDIN files \n"
	

	sed "3s|POS|"${DIST[$STEP]}"|g" $TEMPLATE_USUAL_CALC > $LOWDIN_FILE_USUAL
	sed -i "7s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_USUAL
	sed -i "11s|POS|"${DIST[$STEP]}"|g" $LOWDIN_FILE_USUAL


	echo -e "Running LOWDIN calculations"

	lowdinwork -i $LOWDIN_FILE_USUAL -n 22 
	
	echo -e "Extracting total Energy \n"
	ENERGY_USUAL=$(awk '/E\(MP/ {print $3}' $LOWDIN_OUTPUT_USUAL)
       	TOTAL_ENERGY=$(awk '/TOTAL ENERGY = / {print $4}' $LOWDIN_OUTPUT_USUAL)	
	#echo -e "$ENERGY_ONLY_POSI \n"
	echo -e "${DIST[$STEP]} \t $ENERGY_USUAL $TOTAL_ENERGY \n"

	echo "${DIST[$STEP]} $ENERGY_USUAL $TOTAL_ENERGY"  >> $DATA_FILE 

	#rm lowdin.wfn
done

