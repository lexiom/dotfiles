# Proxmox VE Setup

## Switch to the "non-enterprise" subscription

1. Go to your Proxmox web interface, select your server, and go to Updates > Repositories
2. Disable the enterprise repository
3. Enable the repository that lists the `pve-no-subscription` component

## Remove the "No valid subscription" notice

1. Go to the proxmox-widget-toolkit directory

```sh
cd /usr/share/javascript/proxmox-widget-toolkit
```

2. Backup the original file

```sh
cp proxmoxlib.js proxmoxlib.js.bak
```

3. Edit the `proxmoxlib.js` file

```sh
vi proxmoxlib.js
```

4. Search for `No valid subscription` in the file

- Then, change this section from this:

```javascript
if (
    ...
    res.data.status.toLowerCase() !== 'active'
) {
    Ext.Msg.show({
        title: gettext('No valid subscription'),
        ...
    });
}
```

- To this:

```javascript
if (
    ...
    res.data.status.toLowerCase() == 'active'
) {
    Ext.Msg.show({
        title: gettext('No valid subscription'),
        ...
    });
}
```

5. Restart `pveproxy`

```sh
systemctl restart pveproxy.service
```

6. Clear your browser history and cookies, and log into Proxmox web interface once again

## Enable Wake-on-LAN (WoL)

### Prerequisites

- Make sure that your motherboard supports WoL and then enable it on your motherboard's configurations (BIOS/UEFI)
- Make sure the computer you want to wake up is connected to your network using an ethernet cable

### Server Configuration

1. Identify your Proxmox server's network adapter (the one that is connected to your network), then check if WoL is enabled for it:

```sh
# List network devices
ip link

# Check if your network device (e.g., nic0) currently has WoL enabled
ethtool nic0 | grep -i wake
```

2. You should see something like this:

```sh
Supports Wake-on: pumbg
Wake-on: g
```

3. If `Wake-on` is `g`, then it means that WoL is enabled. If it's not `g`, then follow the next setups.

4. Enable WoL on your current session:

```sh
ethtool -s nic0 wol g
```

5. To make the change persistent, create a new systemd service:

```sh
vi /etc/systemd/system/wol-nic0.service
```

6. Add the following contents to it:

```sh
[Unit]
Description=Enable Wake-on-LAN on nic0
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/ethtool -s nic0 wol g

[Install]
WantedBy=multi-user.target
```

7. Finally, reload systemd and enable the new service:

```sh
systemctl daemon-reload
systemctl enable --now wol-nic0.service
```

### Testing

On a Linux or macOS machine with wakeonlan installed, simply run:

```sh
# The mac address must be the one that belongs to the network card in which WoL was enabled
wakeonlan aa:bb:cc:dd:ee:ff
```
