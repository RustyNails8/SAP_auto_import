# Start of Script file
#! This script will add transports to buffer one by one sequentially.
# The list of transport should be given in <TRANSPORT-LIST.txt> file where
# each transport should be in new line.
###
TPLIST=$1
TPSTATUS=${TPLIST}_add_to_buffer.log

for i in `cat ${TPLIST}`
do
tp addtobuffer $i $2 u1 pf=$3
      RC=$?
    echo  "`date`...Transport ${i} :: add to buffer Status RC=${RC}" >> ${TPSTATUS}
    echo  "`date`...Transport ${i} :: add to buffer Status RC=${RC}" >> ${TPSTATUS}
done
# End of script file