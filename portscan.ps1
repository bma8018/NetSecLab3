#Author: Brendon Anderson
param(
	[string]$ip = $(Read-Host "Enter a single IP to scan or a range in the format <start>-<end>"),
	[string]$ports = $(Read-Host "Enter port list separated by commas, i.e. #,#,#,#,#")
)
$ErrorActionPreference = "silentlyContinue"

#Credit to BarryCWT on Microsoft Technet for the Get-IPrange code
#https://gallery.technet.microsoft.com/scriptcenter/List-the-IP-addresses-in-a-60c5bb6b
function Get-IPrange
{
 
param 
( 
  [string]$start, 
  [string]$end, 
  [string]$ip, 
  [string]$mask, 
  [int]$cidr 
) 
 
function IP-toINT64 () { 
  param ($ip) 
 
  $octets = $ip.split(".") 
  return [int64]([int64]$octets[0]*16777216 +[int64]$octets[1]*65536 +[int64]$octets[2]*256 +[int64]$octets[3]) 
} 
 
function INT64-toIP() { 
  param ([int64]$int) 

  return (([math]::truncate($int/16777216)).tostring()+"."+([math]::truncate(($int%16777216)/65536)).tostring()+"."+([math]::truncate(($int%65536)/256)).tostring()+"."+([math]::truncate($int%256)).tostring() )
} 
 
if ($ip) {$ipaddr = [Net.IPAddress]::Parse($ip)} 
if ($cidr) {$maskaddr = [Net.IPAddress]::Parse((INT64-toIP -int ([convert]::ToInt64(("1"*$cidr+"0"*(32-$cidr)),2)))) } 
if ($mask) {$maskaddr = [Net.IPAddress]::Parse($mask)} 
if ($ip) {$networkaddr = new-object net.ipaddress ($maskaddr.address -band $ipaddr.address)} 
if ($ip) {$broadcastaddr = new-object net.ipaddress (([system.net.ipaddress]::parse("255.255.255.255").address -bxor $maskaddr.address -bor $networkaddr.address))} 
 
if ($ip) { 
  $startaddr = IP-toINT64 -ip $networkaddr.ipaddresstostring 
  $endaddr = IP-toINT64 -ip $broadcastaddr.ipaddresstostring 
} else { 
  $startaddr = IP-toINT64 -ip $start 
  $endaddr = IP-toINT64 -ip $end 
} 
 
$ipList = @() 
for ($i = $startaddr; $i -le $endaddr; $i++) 
{ 
  $ipList += (INT64-toIP -int $i)
  
}
return $ipList
}

if ($ip.contains('/')){
	$range = 1..254
	$sub = $ip.split("/")[1]
	$ip = $ip.split("/")[0]
	if ($sub.equals("16")){
		foreach ($i in $range){
			foreach ($r in $range){
				$curr = $ip.split(".")[0] + "." + $ip.split(".")[1] +"."+ $i + "." + $r
				foreach ($p in $ports.split(",")){
					if(Test-NetConnection -InformationLevel "Quiet" -ComputerName $curr){
						Test-NetConnection -InformationLevel "Quiet" -Port $p -ComputerName $curr
					}
				}
			}
		}
	}
	if ($sub.equals("24")){
		foreach ($r in $range){
			$curr = $ip.split(".")[0] + "." + $ip.split(".")[1] +"."+ $ip.split(".")[2] + "." + $r
			if(Test-NetConnection -InformationLevel "Quiet" -ComputerName $curr){
				Test-NetConnection -InformationLevel "Quiet" -Port $p -ComputerName $curr
			}
		}
	} 
}

else{
	if($ip.contains("-")){
		$start = $ip.split("-")[0]
		$end = $ip.split("-")[1]
	
		$oPortList = @()
		$ipList = (Get-IPrange -start $start -end $end)
		foreach ($curr in $ipList){
			foreach ($p in $ports.split(",")){
				if(Test-NetConnection -InformationLevel "Quiet" -ComputerName $curr){
					if(Test-NetConnection -InformationLevel "Quiet" -Port $p -ComputerName $curr){
						Write-Host "Port $p is open on $curr"
						$oPortList += "Port $p is open on $curr"
					}
				}
			}
		}
		Write-Host $oPortList
	}
	else{
		Write-Host $ip
		foreach ($p in $ports.split(",")){
			if(Test-NetConnection -InformationLevel "Quiet" -ComputerName $ip){
				if(Test-NetConnection -InformationLevel "Quiet" -Port $p -ComputerName $ip){
					Write-Host "Port $p is open on $curr"
					$oPortList += "Port $p is open on $curr"
				}
			}
		}
	}
}