# Pre-process cleanup
rm ~/asn-preprocess.txt
rm ~/blockedASNs.txt
rm ~/IP2LOCATION-LITE-ASN.ZIP
rm ~/IP2LOCATION-LITE-ASN.CSV

# REQUIRED: Replace ****** with your IP2Location Lite account token
curl "https://www.ip2location.com/download/?token=******&file=DBASNLITE" --output ~/IP2LOCATION-LITE-ASN.ZIP
unzip ~/IP2LOCATION-LITE-ASN.ZIP

# Process ASN.txt and output asn-preprocess.txt
cat ~/ASN.txt | grep -v '^#' | awk '{print $1}' | grep '^AS' | while read asn; do
  echo "Processing $asn"
  awk -F "\"*,\"*" '{if($4 == '${asn:2}') print $3}' ~/IP2LOCATION-LITE-ASN.CSV >> ~/asn-preprocess.txt
done

# Remove any defined allowed ranges
grep -vFf IPBlockExceptions.txt asn-preprocess.txt > blockedASNs.txt
