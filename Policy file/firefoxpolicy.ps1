# Define policies for Firefox
$firefoxHomepage = "https://www.google.com"
$firefoxDisablePrivateBrowsing = 1
$firefoxWebsiteFilter = @("https://www.twitch.tv/*", "https://www.threads.net/*")
$firefoxUrlPopupList = @("https://solo-launcher.s3.amazonaws.com")
$firefoxHomepageList = @("https://www.google.com")
$firefoxBrowsingDataList = @("Cache", "Cookies", "Downloads", "FormData", "History", "Sessions", "SiteSettings", "OfflineApps", "Locked")
$firefoxManagedBookmarks = @(
    @{toplevel_name = "Bookmarks"},
    @{name = "Homepage"; url = "https://solo-launcher.s3.amazonaws.com/homepage.html"},
    @{name = "Facebook Lookup-ID"; url = "https://lookup-id.com"},
    @{name = "Facebook CommentPicker"; url = "https://commentpicker.com"},
    @{name = "Twitter CodeNinja"; url = "https://codeofaninja.com/tools/find-twitter-id"},
    @{name = "Instagram Instafollowers"; url = "http://instafollowers.co/find-instagram-user-id"},
    @{name = "YouTube CommentPicker"; url = "https://commentpicker.com/youtube-channel-id.php"}
)

# Define registry paths
$firefoxRegistryPath = "HKLM:\SOFTWARE\Policies\Mozilla\Firefox"
$firefoxBookmarkPath = "$firefoxRegistryPath\Bookmarks\1"
$firefoxWebsiteFilterPath = "$firefoxRegistryPath\WebsiteFilter\Block"
$firefoxBlockedPopupPath = "$firefoxRegistryPath\PopupBlocking\Allow"
$firefoxHomePagePath = "$firefoxRegistryPath\Homepage\URL"
$firefoxTrackingProtectionPath = "$firefoxRegistryPath\EnableTrackingProtection"
$firefoxTrackingProtectionPathExceptions = "$firefoxRegistryPath\EnableTrackingProtection\Exceptions"
$firefoxCookiePath = "$firefoxRegistryPath\Cookies"
$firefoxCookiePathAllow = "$firefoxCookiePath\Allow"
$firefoxCookiePathAllowSession = "$firefoxCookiePath\AllowSession"
$firefoxCookiePathBlock = "$firefoxCookiePath\Block"
$firefoxHistoryPath = "$firefoxRegistryPath\SanitizeOnShutdown"

# Function to ensure a registry path exists
function Ensure-RegistryPath {
    param (
        [string]$path
    )
    $pathExists = Test-Path $path
    if ($pathExists -eq $false) {
        New-Item -Path $path -Force
    }
    return $pathExists
}

# Function to set Firefox bookmarks
function Set-FirefoxBookmarks {
    Ensure-RegistryPath $firefoxBookmarkPath
    Set-ItemProperty -Path "$firefoxBookmarkPath" -Name Title -Type String -Value "Instagram"
    Set-ItemProperty -Path "$firefoxBookmarkPath" -Name URL -Type String -Value "https://instagram.com"
    Set-ItemProperty -Path "$firefoxBookmarkPath" -Name Favicon -Type String -Value "https://instagram.com/favicon.ico"
    Set-ItemProperty -Path "$firefoxBookmarkPath" -Name Placement -Type String -Value "toolbar"
    Set-ItemProperty -Path "$firefoxBookmarkPath" -Name Folder -Type String -Value "Social Media"
}

# Function to set tracking protection in Firefox
function Set-FirefoxTrackingProtection {
    Ensure-RegistryPath $firefoxTrackingProtectionPath
    Ensure-RegistryPath $firefoxTrackingProtectionPathExceptions
    Set-ItemProperty -Path "$firefoxTrackingProtectionPath" -Name Value -Type DWord -Value 0
    Set-ItemProperty -Path "$firefoxTrackingProtectionPath" -Name Locked -Type DWord -Value 0
    Set-ItemProperty -Path "$firefoxTrackingProtectionPath" -Name Cryptomining -Type DWord -Value 0
    Set-ItemProperty -Path "$firefoxTrackingProtectionPath" -Name Fingerprinting -Type DWord -Value 0
    Set-ItemProperty -Path "$firefoxTrackingProtectionPathExceptions" -Name 1 -Type String -Value "https://instagram.com/"
}

# Function to set cookie policies in Firefox
function Set-FirefoxCookiePolicies {
    Ensure-RegistryPath $firefoxCookiePath
    Ensure-RegistryPath $firefoxCookiePathAllow
    Ensure-RegistryPath $firefoxCookiePathAllowSession
    Ensure-RegistryPath $firefoxCookiePathBlock
    Set-ItemProperty -Path "$firefoxCookiePathAllow" -Name 1 -Type String -Value "https://example.com"
    Set-ItemProperty -Path "$firefoxCookiePathAllowSession" -Name 1 -Type String -Value "https://example.edu"
    Set-ItemProperty -Path "$firefoxCookiePathBlock" -Name 1 -Type String -Value "https://example.org"
    Set-ItemProperty -Path "$firefoxCookiePath" -Name Behavior -Type String -Value "accept"
    Set-ItemProperty -Path "$firefoxCookiePath" -Name BehaviorPrivateBrowsing -Type String -Value "accept"
    Set-ItemProperty -Path "$firefoxCookiePath" -Name Locked -Type DWord -Value 1
}

# Function to set Firefox homepage
function Set-FirefoxHomepage {
    Ensure-RegistryPath $firefoxRegistryPath
    Set-ItemProperty -Path $firefoxRegistryPath -Name "Homepage" -Value $firefoxHomepage -Type String
}

# Function to disable private browsing in Firefox
function Disable-FirefoxPrivateBrowsing {
    Ensure-RegistryPath $firefoxRegistryPath
    Set-ItemProperty -Path $firefoxRegistryPath -Name "DisablePrivateBrowsing" -Value $firefoxDisablePrivateBrowsing -Type DWord
}

# Function to block access to about:config
function Block-FirefoxAboutConfig {
    Ensure-RegistryPath $firefoxRegistryPath
    Set-ItemProperty -Path $firefoxRegistryPath -Name "BlockAboutConfig" -Value 1 -Type DWord
}

# Function to configure managed bookmarks in Firefox
function Configure-FirefoxManagedBookmarks {
    Ensure-RegistryPath $firefoxRegistryPath
    $managedBookmarksJson = $firefoxManagedBookmarks | ConvertTo-Json
    Set-ItemProperty -Path $firefoxRegistryPath -Name ManagedBookmarks -Type String -Value $managedBookmarksJson
}

# Function to set Firefox website filters
function Set-FirefoxWebsiteFilters {
    Ensure-RegistryPath $firefoxWebsiteFilterPath
    for ($i = 0; $i -lt $firefoxWebsiteFilter.Count; $i++) {
        New-ItemProperty -Path $firefoxWebsiteFilterPath -Name ([string]($i + 1)) -Value $firefoxWebsiteFilter[$i] -PropertyType String -Force
    }
}

# Function to allow pop-ups on certain websites
function Allow-FirefoxPopups {
    Ensure-RegistryPath $firefoxBlockedPopupPath
    for ($i = 0; $i -lt $firefoxUrlPopupList.Count; $i++) {
        New-ItemProperty -Path $firefoxBlockedPopupPath -Name ([string]($i + 1)) -Value $firefoxUrlPopupList[$i] -PropertyType String -Force
    }
}

# Function to clear browsing data on shutdown
function Clear-FirefoxBrowsingDataOnShutdown {
    Ensure-RegistryPath $firefoxHistoryPath
    for ($i = 0; $i -lt $firefoxBrowsingDataList.Count; $i++) {
        New-ItemProperty -Path $firefoxHistoryPath -Name $firefoxBrowsingDataList[$i] -Value 1 -PropertyType DWord -Force
    }
}

# Function to apply all Firefox policies
function Apply-FirefoxPolicies {
    Set-FirefoxBookmarks
    Set-FirefoxTrackingProtection
    Set-FirefoxCookiePolicies
    Set-FirefoxHomepage
    Disable-FirefoxPrivateBrowsing
    Block-FirefoxAboutConfig
    Configure-FirefoxManagedBookmarks
    Set-FirefoxWebsiteFilters
    Allow-FirefoxPopups
    Clear-FirefoxBrowsingDataOnShutdown

    Write-Output "Firefox policies have been applied successfully."
}

# Apply all policies
Apply-FirefoxPolicies
