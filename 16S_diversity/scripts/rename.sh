#!/bin/bash
for i in "$@"
do
case $i in
    -f=*|--forward=*)
    FORWARD="${i#*=}"
    shift
    ;;
    -r=*|--reverse=*)
    REVERSE="${i#*=}"
    shift
    ;;
esac
done

SAMPLE=$(basename $(echo ${FORWARD}) | sed 's/_FP.uc//g')

/bin/cat ${FORWARD} | awk -v var=$SAMPLE"_FP_" \
 '{sub("^", var, $9)};1' | sed 's/ /\t/g' > tmp_forward ;

 /bin/cat ${REVERSE} | awk -v var=$SAMPLE"_RP_" \
  '{sub("^", var, $9)};1' | sed 's/ /\t/g' > tmp_reverse ;

/bin/cat tmp_forward tmp_reverse
