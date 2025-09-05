#!/usrbin/env bash

METAPATH=$"METADATA_FILE" 

cat ${1} | while IFS=$'\t' read SAMPLE_ONE SAMPLE_TWO 
	do 
	nucmer --mum -p ${SAMPLE_ONE}_${SAMPLE_TWO}_prefix -c 65 -g 90 -t 1 genome/${SAMPLE_ONE}  genome/${SAMPLE_TWO} 
	delta-filter -r -q ${SAMPLE_ONE}_${SAMPLE_TWO}_prefix.delta > ${SAMPLE_ONE}_${SAMPLE_TWO}_delta_filtered

	genome1_lenghth=$( grep $"${SAMPLE_ONE}" ${METAPATH} | cut -f 5 )
	genome2_lenghth=$( grep $"${SAMPLE_TWO}" ${METAPATH} | cut -f 5 )

	cat ${SAMPLE_ONE}_${SAMPLE_TWO}_delta_filtered | tail -n+3  | grep $'>'  -v  | grep $' ' | sed 's/ /\t/g' > ${SAMPLE_ONE}_${SAMPLE_TWO}_delta_filtered.txt
	./cal_nucmer.py	${SAMPLE_ONE}_${SAMPLE_TWO}_delta_filtered.txt ${SAMPLE_ONE} ${SAMPLE_TWO}  ${genome1_lenghth} ${genome2_lenghth} > ANI/${SAMPLE_ONE}-${SAMPLE_TWO}.ani
	mv ${SAMPLE_ONE}_${SAMPLE_TWO}_delta_filtered.txt delta 
	mv ${SAMPLE_ONE}_${SAMPLE_TWO}_delta_filtered delta 
	mv ${SAMPLE_ONE}_${SAMPLE_TWO}_prefix.delta delta 
done 
