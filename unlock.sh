#!/bin/bash
$USERNAME = user
$PASSWORD = pass
$DOOR_ID = DOOR_ID_HERE
$URL = IP_ADDRESS_HERE
SESSIONID=$(curl -X POST --data "debug=0&fldUserName=$USERNAME&fldPassword=$PASSWORD" --header "Content-Length: 55" http://$URL/Site_SMS/SF_User_Login/cgi-bin/process_login.cgi -v 2>&1 | grep Location | cut -c51-58)
echo "${SESSIONID}"
curl -X POST --data "hfldSessionId=$SESSIONID&debug=0&statusResponse=1&hfldButton=executeMRO&hfldDeviceId=$DOOR_ID&hfldDeviceList=&hfldMROTypeId=1&hdlfDuration=10" http://$URL/Site_SMS/SF_SSC/cgi-bin/sms-ssh.cgi
curl -X POST --data "hfldSessionId=$SESSIONID&hfldReason=0" http://$URL/Site_SMS/cgi-bin/logout.cgi
