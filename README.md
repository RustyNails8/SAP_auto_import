# SAP_auto_import
Import Mass Transports into SAP system

# Steps:
1. Login to CI server
2. Switch to sidadm
3. cd to /usr/sap/trans/bin directory. Please check what is the transport direcory **DIR_TRANS** on your system first.
4. Execute the following commands:

```bash
bash
pwd
vi TRANSPORT.list            # Create the Transport List, with each TR in 1 line
cat TRANSPORT.list	         # Check contents of transport list
vi auto_transport_buffer.sh  # Create the add to buffer script
vi auto_transport_import.sh  # Create the import script
chmod +x auto_transport_buffer.sh auto_transport_import.sh  # Makes the scripts ececutable

sh auto_transport_buffer.sh TRANSPORT.list SID /usr/sap/trans/bin/TP_DOMAIN_SID.PFL		# Replace SID and transport profile file name TP_DOMAIN_SID.PFL
sh auto_transport_buffer.sh TRANSPORT.list SID 100 /usr/sap/trans/bin/TP_DOMAIN_SID.PFL		# Replace SID and 100(your SAP client number) and the transport profile file name TP_DOMAIN_SID.PFL
```

**IMP:** It is important that the scripts are created in trans bin directory **DIR_TRANS**/bin and executed from this location - `/usr/sap/trans/bin`
**IMP:** Also important is to execute this from bash prompt.






