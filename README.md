# Snort + Rules
#asdsad


netsh advfirewall set allprofiles state off
New-NetFirewallRule -DisplayName "Allow CheckMK Agent" -Direction Inbound -Protocol TCP -LocalPort 6556 -Action Allow
