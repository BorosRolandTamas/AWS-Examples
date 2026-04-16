# Import AWS PowerShell Module
Import-Module AWSPowerShell.NetCore

# Set AWS Region
$region = "us-east-1"

# Prompt for S3 Bucket Name
$bucketName = Read-Host -Prompt 'Enter the S3 bucket name'

# Function to check if the bucket exists in your account
function BucketExists {
    param ($bucketName)
    $buckets = Get-S3Bucket
    return ($buckets.BucketName -contains $bucketName)
}

# Create S3 Bucket if it doesn't exist
if (-Not (BucketExists -bucketName $bucketName)) {
    New-S3Bucket -BucketName $bucketName -Region $region
    Write-Host "Bucket $bucketName created."
} else {
    Write-Host "Bucket $bucketName already exists."
}

# Create a sample file
$fileName = "sample.txt"
$fileContent = "Hello, S3!"
Set-Content -Path $fileName -Value $fileContent

# Upload the file to the S3 bucket
Write-S3Object -BucketName $bucketName -File $fileName -Key $fileName
Write-Host "File $fileName uploaded to bucket $bucketName."

# Clean up local file
Remove-Item -Path $fileName