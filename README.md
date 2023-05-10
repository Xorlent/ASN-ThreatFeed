# ASN Threat Feeds
Generates a threat feed IP list from a user-furnished ASN list.  The output can then be consumed by firewalls and filtering tools.

## Input files
   ASN.txt : list of AS numbers in format ASn[n..] to add to the block list, exactly one per line, comment with a "#" followed by text.  See the repo ASN.txt file for examples.  
   IPBlockExceptions.exe : Specific ASN IP ranges to never block (MUST exactly match an entry in the ASN database), one CIDR per line.  

## For Linux/Bash
   buildasn.sh : Downloads a fresh copy of the ASN IP database and rebuilds the BlockASNs.txt list.  
   updateasn.sh : Regenerates the BlockASNs.txt list using the pre-existing copy of the ASN IP database.  

## For Windows/PowerShell
   buildasn.ps1 : Downloads a fresh copy of the ASN IP database and rebuilds the BlockASNs.txt list.  
   updateasn.ps1 : Regenerates the BlockASNs.txt list using the pre-existing copy of the ASN IP database.  

## Output
   BlockedASNs.txt (PowerShell version running on webprod2019-01 will automatically move the output file to the web folder for pickup)
