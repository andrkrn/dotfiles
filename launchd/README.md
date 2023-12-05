sudo cp $(pwd)/launchd/org.andrkrn.cloudflared.plist /Library/LaunchDaemons/org.andrkrn.cloudflared.plist

sudo launchctl load -w /Library/LaunchDaemons/org.andrkrn.cloudflared.plist
