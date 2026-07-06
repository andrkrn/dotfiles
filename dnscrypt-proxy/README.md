# dnscrypt-proxy (encrypted DNS)

Local DNS-over-HTTPS resolver. Replaces `cloudflared proxy-dns`, which
Cloudflare removed in `cloudflared` v2026.2.0.

`script/setup` symlinks `dnscrypt-proxy.toml` to
`/opt/homebrew/etc/dnscrypt-proxy.toml` (Apple Silicon Homebrew prefix).
The steps below need `sudo` (bind port 53 / change system DNS), so they
are run manually — like `launchd` used to be.

## Install

```sh
# Config is symlinked by script/setup; if doing it by hand:
ln -sfnv "$PWD/dnscrypt-proxy/dnscrypt-proxy.toml" /opt/homebrew/etc/dnscrypt-proxy.toml
mkdir -p /opt/homebrew/var/dnscrypt-proxy   # cache dir for the resolver list

# Start as a root service (bind :53) and keep it running at boot
sudo brew services start dnscrypt-proxy

# Point the system at it (repeat per network service, e.g. "Ethernet")
sudo networksetup -setdnsservers Wi-Fi 127.0.0.1
```

## Verify

```sh
dnscrypt-proxy -config /opt/homebrew/etc/dnscrypt-proxy.toml -resolve cloudflare.com
dig @127.0.0.1 example.com +short
scutil --dns | grep 'nameserver\[0\]'
```

## Revert to normal DNS

```sh
sudo networksetup -setdnsservers Wi-Fi Empty   # back to DHCP-provided DNS
sudo brew services stop dnscrypt-proxy
```

## Migrating from cloudflared proxy-dns

The old `launchd/org.andrkrn.cloudflared.plist` LaunchDaemon is obsolete.
Remove it if it's still installed:

```sh
sudo launchctl bootout system /Library/LaunchDaemons/org.andrkrn.cloudflared.plist 2>/dev/null
sudo rm -f /Library/LaunchDaemons/org.andrkrn.cloudflared.plist
```
