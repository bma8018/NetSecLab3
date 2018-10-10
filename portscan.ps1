param(
	[string]$ip = $(Read-Host "Enter a single IP to scan or a range in the format <start>-<end>"),
	[string]$ports = $(Read-Host "Enter port list separated by commas, i.e. #,#,#,#,#")
)


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
			Write-Host $curr
		}
	} 
}

else{
$length = $ip.Length
Write-Host $length
$i = $ip.IndexOf("-")
$start = $ip.Substring(0,$i)
$end = $ip.Substring($i,$length)


}