#change to SilentlyContinue to avoid getting bogged down with progress bar
$ProgressPreference = "SilentlyContinue" 


try {$creds = Get-Content "./creds.json" -Raw | ConvertFrom-Json
#check to make sure no missing values
foreach ($parameter in $creds.PSobject.Properties) {
    if ($parameter.Value.Length -le 0) {
        throw "Error: value missing from file"
    }
}}
catch {Write-Output($_)}

$login_params = @{
    Uri = "https://pastebin.com/api/api_login.php"
    Body = @{
        api_dev_key = $creds.api_dev_key
        api_user_name = $creds.username
        api_user_password = $creds.password
    }
}

$response = Invoke-WebRequest -Method Post @login_params
$user_key = $response.content




foreach ($arg in $args) {
    try {

        $code = Get-Content $arg -Raw
        $parameters = @{
            Uri = "https://pastebin.com/api/api_post.php"
            Body = @{
            api_dev_key = "dZACgL95bM7QADqijDJA2Y1yZwJ7HTKy"
            api_user_key = $user_key
            api_paste_code = $code
            api_option = "paste"
            }
            
        }

        Invoke-WebRequest -Method Post @parameters
    }
    catch {
        Write-Output($_)
    }
}

Write-Output("success")