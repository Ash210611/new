#!/bin/bash

# Function to apply policies on macOS
apply_mac_policies() {
    echo "Applying policies on macOS..."
    # Define the plist file path for Chrome policies
    plist_path="/Library/Managed Preferences/com.google.Chrome.plist"

    # Ensure the directory exists
    mkdir -p "$(dirname "$plist_path")"

    # Apply policies
    /usr/libexec/PlistBuddy -c "Set :SafeBrowsingEnabled true" "$plist_path"
    /usr/libexec/PlistBuddy -c "Set :HomepageLocation 'https://www.example.com'" "$plist_path"
    /usr/libexec/PlistBuddy -c "Set :IncognitoModeAvailability 1" "$plist_path"
    /usr/libexec/PlistBuddy -c "Set :SyncDisabled true" "$plist_path"
    /usr/libexec/PlistBuddy -c "Set :DefaultPopupsSetting 2" "$plist_path"

    # Apply URL blocklist
    /usr/libexec/PlistBuddy -c "Add :URLBlocklist array" "$plist_path"
    /usr/libexec/PlistBuddy -c "Add :URLBlocklist:0 string 'http://www.example1.com'" "$plist_path"
    /usr/libexec/PlistBuddy -c "Add :URLBlocklist:1 string 'http://www.example2.com'" "$plist_path"

    # Apply URL allowlist
    /usr/libexec/PlistBuddy -c "Add :URLAllowlist array" "$plist_path"
    /usr/libexec/PlistBuddy -c "Add :URLAllowlist:0 string 'http://www.allowedexample.com'" "$plist_path"

    echo "Chrome policies have been applied successfully on macOS."
}

# Function to apply policies on Linux
apply_linux_policies() {
    echo "Applying policies on Linux..."
    # Define the JSON file path for Chrome policies
    json_path="/etc/opt/chrome/policies/managed/my_policy.json"

    # Ensure the directory exists
    mkdir -p "$(dirname "$json_path")"

    # Create the JSON policies
    cat <<EOF > "$json_path"
{
    "SafeBrowsingEnabled": true,
    "HomepageLocation": "https://www.example.com",
    "IncognitoModeAvailability": 1,
    "SyncDisabled": true,
    "DefaultPopupsSetting": 2,
    "URLBlocklist": ["http://www.example1.com", "http://www.example2.com"],
    "URLAllowlist": ["http://www.allowedexample.com"]
}
EOF

    echo "Chrome policies have been applied successfully on Linux."
}

# Function to apply policies on Windows
apply_windows_policies() {
    echo "Applying policies on Windows..."
    # PowerShell script to apply policies on Windows
    powershell -Command "
# PowerShell Script to Apply Chrome Enterprise Policies on Windows

# Define the registry path for Chrome policies
\$registryPath = 'HKLM:\\Software\\Policies\\Google\\Chrome'

# Function to create registry path if it does not exist
function Ensure-RegistryPathExists {
    param (
        [string]\$path
    )
    if (-not (Test-Path \$path)) {
        New-Item -Path \$path -Force
    }
}

# Ensure the Chrome policies registry path exists
Ensure-RegistryPathExists -path \$registryPath

# Set Chrome policies by adding values to the registry

# Example: Enable Safe Browsing
Set-ItemProperty -Path \$registryPath -Name 'SafeBrowsingEnabled' -Value 1 -Type DWord

# Example: Set Homepage
Set-ItemProperty -Path \$registryPath -Name 'HomepageLocation' -Value 'https://www.example.com' -Type String

# Example: Disable Incognito Mode
Set-ItemProperty -Path \$registryPath -Name 'IncognitoModeAvailability' -Value 1 -Type DWord

# Example: Disable Chrome Sync
Set-ItemProperty -Path \$registryPath -Name 'SyncDisabled' -Value 1 -Type DWord

# Example: Enable Pop-up Blocking
Set-ItemProperty -Path \$registryPath -Name 'DefaultPopupsSetting' -Value 2 -Type DWord

# Example: Block access to a list of URLs
\$urlBlockList = @('http://www.example1.com', 'http://www.example2.com')
New-Item -Path '\$registryPath\\URLBlocklist' -Force
for (\$i = 0; \$i -lt \$urlBlockList.Count; \$i++) {
    Set-ItemProperty -Path '\$registryPath\\URLBlocklist' -Name \$i -Value \$urlBlockList[\$i] -Type String
}

# Example: Allow specific URLs
\$urlAllowList = @('http://www.allowedexample.com')
New-Item -Path '\$registryPath\\URLAllowlist' -Force
for (\$i = 0; \$i -lt \$urlAllowList.Count; \$i++) {
    Set-ItemProperty -Path '\$registryPath\\URLAllowlist' -Name \$i -Value \$urlAllowList[\$i] -Type String
}

Write-Output 'Chrome policies have been applied successfully on Windows.'
"
}

# Detect the OS and apply the appropriate policies
case "$OSTYPE" in
    darwin*) apply_mac_policies ;;
    linux-gnu*) apply_linux_policies ;;
    msys*|cygwin*|win32*) apply_windows_policies ;;
    *) echo "Unsupported OS type: $OSTYPE" ; exit 1 ;;
esac

