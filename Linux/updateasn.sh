# Pre-process cleanup
rm ~/asn-preprocess.txt
rm ~/blockedASNs.txt

# Process ASN.txt and output asn-preprocess.txt
cat ~/ASN.txt | grep -v '^#' | awk '{print $1}' | grep '^AS' | while read asn; do
  echo "Processing $asn"
  awk -F "\"*,\"*" '{if($4 == '${asn:2}') print $3}' ~/IP2LOCATION-LITE-ASN.CSV >> ~/asn-preprocess.txt
done

# Remove any defined allowed ranges
grep -vFf IPBlockExceptions.txt asn-preprocess.txt > blockedASNs.txt
