
# Set up working folders.  Adjust these values as necessary
$WorkingDir = "C:\Scripts\BlockByASN"
$ASNFile = "C:\Scripts\BlockByASN\ASN.txt"
$IPExceptions = "C:\Scripts\BlockByASN\IPBlockExceptions.txt"

$ASNDB = "C:\Scripts\BlockByASN\IP2LOCATION-LITE-ASN.CSV"
$ASNDBHeaders = 'Start','End','IPBlock','ASN','Organization'

# Final output locations.  $BlockList is updated at runtime, $ProdASNFile is copied from the final output to a web server directory for pick up by a firewall or other system.
$BlockList = "C:\Scripts\BlockByASN\BlockedASNs.txt"
$ProdASNFile = "D:\Block_List\blockedASNs.txt"

# Delete any previous output file
rm $BlockList

# Open the IP2Location database
$IP2LocationObject = Import-Csv -Path $ASNDB -Header $ASNDBHeaders
$IPExceptionsObject = Get-Content $IPExceptions

# Check for matches from the ASN.txt file, adding any CIDRs from the IP2Location database
Get-Content $ASNFile | Where-Object { $_ -notmatch '^#' } | ForEach-Object {
    $fields = $_.Split(" ")
    $asn = $fields[0]
    if ($asn -match '^AS')
        {
        Write-Output "Processing $asn"
        $asn = $asn.Substring(2)
	    ForEach ($DBASN in $IP2LocationObject) {
    		if ($DBASN.ASN -eq $asn)
                {
                $ExceptionCount = 0
                ForEach ($IPException in $IPExceptionsObject) {
                    if ($IPException -eq $DBASN.IPBlock)
                        {
                        $ExceptionCount += 1
                        }
                    }
                if ($ExceptionCount -eq 0)
                    {
        	        Add-Content -Path $BlockList -Value $DBASN.IPBlock
                    }
    		    } 
	        }
        }
    }

# Finally, copy the output file to the web server directory for pick-up
cp $BlockList $ProdASNFile
