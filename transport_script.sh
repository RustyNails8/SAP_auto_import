#!/bin/bash

# Start of Script file
# This script will import transports one by one sequentially 
# and capture both OS and SAP Transport Management return codes
###

set -x
TPLIST=$1
TPSTATUS=${TPLIST}.RClog
TPERRORS=${TPLIST}.errors

# Ensure error log file exists
touch ${TPERRORS}

# Redirect output to capture detailed information
exec 2>&1

for i in `cat ${TPLIST}`
do
    # Capture full output of tp command
    OUTPUT=$(echo "y" | tp import $i $2 client=$3 u0126 pf=$4 2>&1)
    
    # Capture OS return code
    RC=$?
    
    # Extract SAP Transport Management return code
    SAP_RC=$(echo "${OUTPUT}" | grep -E "RC=[0-9]+" | awk -F'RC=' '{print $2}' | head -n 1)
    
    # Log detailed information
    echo "`date`...Transport ${i} OS RC=${RC} SAP RC=${SAP_RC}" >> ${TPSTATUS}
    echo "`date`...Transport ${i} OS RC=${RC} SAP RC=${SAP_RC}"
    
    # Log full output if there's an error
    if [ "$RC" -ne 0 ] || [ -n "$SAP_RC" ] && [ "$SAP_RC" -ne 0 ]; then
        echo "Error importing transport ${i}:" >> ${TPERRORS}
        echo "${OUTPUT}" >> ${TPERRORS}
    fi
    
    # Decide whether to continue or break
    if [ "$RC" -ne 0 ] && [ "$RC" -ne 4 ]; then
        echo "Critical error occurred. Stopping import process." >> ${TPSTATUS}
        break
    fi
    
    # Optional: Add a small pause between imports
    sleep 2
done

# Final status
echo "Transport import process completed." >> ${TPSTATUS}