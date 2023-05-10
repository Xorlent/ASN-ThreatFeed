$WorkingDir = "C:\Scripts\BlockByASN"
$ASNFile = "C:\Scripts\BlockByASN\ASN.txt"
$IPExceptions = "C:\Scripts\BlockByASN\IPBlockExceptions.txt"

$ASNDBZip = "C:\Scripts\BlockByASN\IP2LOCATION-LITE-ASN.ZIP"
$ASNDB = "C:\Scripts\BlockByASN\IP2LOCATION-LITE-ASN.CSV"
$ASNDBHeaders = 'Start','End','IPBlock','ASN','Organization'

$BlockList = "C:\Scripts\BlockByASN\BlockedASNs.txt"
$ProdASNFile = "D:\Block_List\blockedASNs.txt"

rm $ASNDBZip
