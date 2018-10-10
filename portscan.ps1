param(
	[string]$ip = $(Read-Host "Enter a single IP to scan or a range in the format <start>-<end>"),
	[string]$ports = $(Read-Host "Enter port list separated by commas, i.e. #,#,#,#,#")
)
$length = $ip.Length
Write-Host $length
$i = $ip.IndexOf("-")
$start = $ip.Substring(0,$i)
$end = $ip.Substring($i,$length)
Write-Host $start
Write-Host $end
Write-Host $ports
