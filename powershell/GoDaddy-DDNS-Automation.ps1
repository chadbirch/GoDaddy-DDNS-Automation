# https://github.com/chadbirch/GoDaddy-DDNS-Automation
# Copyright 2018 - Chad Birch
# 
# Script references:
#   https://www.jokecamp.com/blog/invoke-restmethod-powershell-examples/
#   https://gallery.technet.microsoft.com/scriptcenter/Get-ExternalPublic-IP-c1b601bb

Param(

    # The domain name; example.com.
    [Parameter(Mandatory = $true,HelpMessage = "The domain name; example.com.")]
    [ValidateNotNullorEmpty()]
    [string] $domain, 
    
    # The type of record; A, CNAME, MX, etc.
    [Parameter(Mandatory = $true,HelpMessage = "The type of record; A, CNAME, MX, etc.")]
    [ValidateNotNullorEmpty()]
    [string] $recordType,
    
    # The name of the Record; @, server, mail, vpn, etc.
    [Parameter(Mandatory = $true,HelpMessage = "The name of the Record; @, server, mail, vpn, etc.")]
    [ValidateNotNullorEmpty()]
    [string] $record,
    
    # The TTL in seconds. This defaults to 600 in the script, but GoDaddy defaults to 3600.
    [int] $ttl = 600,
    
    # The production Key generated from https://developer.godaddy.com/keys/
    [Parameter(Mandatory = $true,HelpMessage = "The production Key generated from https://developer.godaddy.com/keys/")]
    [ValidateNotNullorEmpty()]
    [string] $key,
    
    # The Secret that corresponds to the key generated above.
    [Parameter(Mandatory = $true,HelpMessage = "The Secret that corresponds to the key generated above.")]
    [ValidateNotNullorEmpty()]
    [string] $secret
)

# Create the Header object and add the authorization header
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "sso-key ${key}:${secret}")

# Get the IP from http://ipinfo.io/json
$ip = Invoke-RestMethod http://ipinfo.io/json | Select-Object -exp ip

try {

    # Capture existing record
    $dnsRecord = Invoke-RestMethod "https://api.godaddy.com/v1/domains/$domain/records/$recordType/$record" -Method Get -Headers $headers

    # Modify the `data` property with the new IP address
    $dnsRecord[0].data = $ip

    # Convert to JSON
    $json = $dnsRecord | ConvertTo-Json

    # Call the Put method for the specified domain with the body and headers defined above.
    Invoke-RestMethod "https://api.godaddy.com/v1/domains/$domain/records/$recordType/$record" -Method Put -Headers $headers -Body [$json] -ContentType 'application/json'

    # Call the Get method to show the output of the call`
    Invoke-RestMethod "https://api.godaddy.com/v1/domains/$domain/records/$recordType/$record" -Method Get -Headers $headers

    # If the call is succesful, return and Exit Code of 0
    exit 0
} catch {

    # If the call fails, return and Exit Code of 1
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
    exit 1
}
