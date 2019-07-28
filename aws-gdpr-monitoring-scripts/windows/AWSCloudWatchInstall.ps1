#Download official package with Amazon CloudWatch 

$url = "https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/AmazonCloudWatchAgent.zip"
$output = "$env:TEMP\AmazonCloudWatchAgent.zip"
$start_time = Get-Date

Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

#Extract archive to temp folder

Expand-Archive -Path "$env:TEMP\AmazonCloudWatchAgent.zip" -DestinationPath "$env:TEMP\AmazonCloudWatchAgent"

#copy config file

cp config.json "$env:TEMP\AmazonCloudWatchAgent"

#run installation

Set-Location -Path "$env:TEMP\AmazonCloudWatchAgent"
.\install.ps1

# Fetch config and run Amazon CloudWatch

Set-Location -Path 'C:\Program Files\Amazon\AmazonCloudWatchAgent\'

.\amazon-cloudwatch-agent-ctl.ps1 -a fetch-config -m ec2 -c file:"$env:TEMP\AmazonCloudWatchAgent\config.json" -s
