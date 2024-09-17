# PowerShell script to apply Chrome policies on Windows

# Define policies for Chrome
$chromeHomepage = "https://www.google.com"
$chromeUrlBlockList = @("https://www.twitch.tv", "https://www.threads.net")
$chromeUrlPopupList = @("solo-launcher.s3.amazonaws.com")
$chromeSafeBrowsingEnabled = 1
$chromeIncognitoModeAvailability = 1
$chromeSyncDisabled = 1
$chromeDefaultPopupsSetting = 2

# Define registry paths
$chromeRegistryPath = "HKLM:\SOFTWARE\Policies\Google\Chrome"
$chromeUrlBlockListPath = "$chromeRegistryPath\URLBlocklist"
$chromePoups = "$chromeRegistryPath\PopupsAllowedForUrls"

# Function to ensure a registry path exists
function Ensure-RegistryPath {
    param (
        [string]$path
    )
    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force
    }
}

# Function to apply Chrome policies
function Apply-ChromePolicies {
    #For ensuring that the registry path exists
    Ensure-RegistryPath $chromeRegistryPath

    #This policy sets Home Page for Chrome
    Set-ItemProperty -Path $chromeRegistryPath -Name "HomepageLocation" -Value $chromeHomepage -Type String

    #This policy enables Safe Browsing for Chrome
    Set-ItemProperty -Path $chromeRegistryPath -Name "SafeBrowsingEnabled" -Value $chromeSafeBrowsingEnabled -Type DWord

    #This policy enables or disbales Incognoto mode for Chrome
    Set-ItemProperty -Path $chromeRegistryPath -Name "IncognitoModeAvailability" -Value $chromeIncognitoModeAvailability -Type DWord

    #This policy enables or disables Sync for Chrome
    Set-ItemProperty -Path $chromeRegistryPath -Name "SyncDisabled" -Value $chromeSyncDisabled -Type DWord

    #This policy sets Popup Settings  for Chrome
    Set-ItemProperty -Path $chromeRegistryPath -Name "DefaultPopupsSetting" -Value $chromeDefaultPopupsSetting -Type DWord

    #this blocks sets up the extensions that needs to be insatlled in chrome
    # Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist" -Name 1 -Value "haebnnbpedcbhciplfhjjkbafijpncjl;https://clients2.google.com/service/update2/crx" -Type String
    # Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist" -Name 2 -Value "immpkjjlgappgfkkfieppnmlhakdmaab;https://clients2.google.com/service/update2/crx" -Type String
    # Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist" -Name 3 -Value "fkjbliednplpohojfpgnbpcppgdnhklb;https://clients2.google.com/service/update2/crx" -Type String
    # Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\ExtensionInstallForcelist" -Name 3 -Value "djflhoibgkdhkhhcedjiklpkjnoahfmg;https://clients2.google.com/service/update2/crx" -Type String
    
    #This policy sets Managed Bookmarks for Chrome
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\" -Name ManagedBookmarks -Type String -Value '[{"toplevel_name": "Bookmarks"},{"name": "Homepage", "url": "https://solo-launcher.s3.amazonaws.com/homepage.html"},{"name": "Facebook Lookup-ID", "url": "https://lookup-id.com"},{"name": "Facebook CommentPicker", "url": "https://commentpicker.com"},{"name": "Twitter CodeNinja", "url": "https://codeofaninja.com/tools/find-twitter-id"},{"name": "Instagram Instafollowers", "url": "http://instafollowers.co/find-instagram-user-id"}, {"name": "YouTube CommentPicker", "url": "https://commentpicker.com/youtube-channel-id.php"}]'
    
    #This policy Enabes or disables Bookmark Settings for Chrome
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\" -Name BookmarkBarEnabled -Type DWord -Value 1
     
    #This policy Enabes or disables AutoFill Address Settings for Chrome
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\" -Name AutofillAddressEnabled -Type DWord -Value 0
     
    #This policy Enabes or disables AutoFill Credit Card Settings for Chrome
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\" -Name AutofillCreditCardEnabled -Type DWord -Value 0
    
    #This policy Enabes or disables Shortcut Bookmark Settings for Chrome
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\" -Name ShowAppsShortcutInBookmarkBar -Type DWord -Value 0
     
    #This policy blocks extension for Chrome
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\" -Name BlockExternalExtensions -Type DWord -Value 1
    
    #This policy changes User Data Directory for Chrome
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\" -Name UserDataDir -Type String -Value "C:\BrowserData\Chrome\"
    
    #this policy stop sor alllows chrome from checking whetehr it is the dfault browser or not.
    Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\" -Name DefaultBrowserSettingEnabled -Type DWord -Value 0

    #ths group sets the proxy server settings in chrome 
    #Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome\" -Name ProxySettings -Type String -Value '{"ProxyMode":"fixed_servers","ProxyServer":"none"}'
    #Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Update\" -Name ProxyMode -Type String -Value "fixed_servers"
    #Set-ItemProperty -Path "HKLM:\Software\Policies\Google\Update\" -Name ProxyServer -Type String -Value "us-east-1.solohostedzone:3128"

    #this sets up the url to be blocked in chrome
    Ensure-RegistryPath $chromeUrlBlockListPath
    for ($i = 0; $i -lt $chromeUrlBlockList.Count; $i++) {
        New-ItemProperty -Path $chromeUrlBlockListPath -Name "$i" -Value $chromeUrlBlockList[$i] -PropertyType String -Force
    }

    #this sets up the pop-ups to be blocked in chrome
    Ensure-RegistryPath $chromePoups
    for ($i = 0; $i -lt $chromeUrlPopupList.Count; $i++) {
        New-ItemProperty -Path $chromePoups -Name "$i" -Value $chromeUrlPopupList[$i] -PropertyType String -Force
    }
    Write-Output "Chrome policies have been applied successfully."
}

# Apply policies
Apply-ChromePolicies