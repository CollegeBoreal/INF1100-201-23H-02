# :up: Upgrade

```
lsb_release  -a
```
> Outputs :
<pre>
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.4 LTS
Release:	20.04
Codename:	focal
</pre>

```
apt list --upgradable
```
> Outputs :
<pre>
Listing... Done
alsa-ucm-conf/focal-updates 1.2.2-1ubuntu0.13 all [upgradable from: 1.2.2-1ubuntu0.12]
apparmor/focal-updates 2.13.3-7ubuntu5.2 amd64 [upgradable from: 2.13.3-7ubuntu5.1]
apport/focal-updates 2.20.11-0ubuntu27.25 all [upgradable from: 2.20.11-0ubuntu27.24]
apt-utils/focal-updates 2.0.9 amd64 [upgradable from: 2.0.6]
apt/focal-updates 2.0.9 amd64 [upgradable from: 2.0.6]
base-files/focal-updates 11ubuntu5.7 amd64 [upgradable from: 11ubuntu5.5]
bind9-dnsutils/focal-updates 1:9.16.1-0ubuntu2.14 amd64 [upgradable from: 1:9.16.1-0ubuntu2.12]
bind9-host/focal-updates 1:9.16.1-0ubuntu2.14 amd64 [upgradable from: 1:9.16.1-0ubuntu2.12]
bind9-libs/focal-updates 1:9.16.1-0ubuntu2.14 amd64 [upgradable from: 1:9.16.1-0ubuntu2.12]
bolt/focal-updates 0.9.1-2~ubuntu20.04.2 amd64 [upgradable from: 0.8-4ubuntu1]
cloud-init/focal-updates 23.1.1-0ubuntu0~20.04.1 all [upgradable from: 22.2-0ubuntu1~20.04.3]
containerd.io/focal 1.6.19-1 amd64 [upgradable from: 1.6.18-1]
distro-info-data/focal-updates 0.43ubuntu1.11 all [upgradable from: 0.43ubuntu1.10]
docker-buildx-plugin/focal 0.10.4-1~ubuntu.20.04~focal amd64 [upgradable from: 0.10.2-1~ubuntu.20.04~focal]
docker-ce-cli/focal 5:23.0.2-1~ubuntu.20.04~focal amd64 [upgradable from: 5:23.0.1-1~ubuntu.20.04~focal]
docker-ce-rootless-extras/focal 5:23.0.2-1~ubuntu.20.04~focal amd64 [upgradable from: 5:23.0.1-1~ubuntu.20.04~focal]
docker-ce/focal 5:23.0.2-1~ubuntu.20.04~focal amd64 [upgradable from: 5:23.0.1-1~ubuntu.20.04~focal]
docker-compose-plugin/focal 2.17.2-1~ubuntu.20.04~focal amd64 [upgradable from: 2.16.0-1~ubuntu.20.04~focal]
fwupd-signed/focal-updates 1.51~20.04.1+1.2-3ubuntu0.2 amd64 [upgradable from: 1.27.1ubuntu7+1.2-2~20.04.1]
fwupd/focal-updates 1.7.9-1~20.04.1 amd64 [upgradable from: 1.7.5-3~20.04.1]
grub-common/focal-updates 2.04-1ubuntu26.16 amd64 [upgradable from: 2.04-1ubuntu26.13]
grub-pc-bin/focal-updates 2.04-1ubuntu26.16 amd64 [upgradable from: 2.04-1ubuntu26.13]
grub-pc/focal-updates 2.04-1ubuntu26.16 amd64 [upgradable from: 2.04-1ubuntu26.13]
grub2-common/focal-updates 2.04-1ubuntu26.16 amd64 [upgradable from: 2.04-1ubuntu26.13]
isc-dhcp-client/focal-updates 4.4.1-2.1ubuntu5.20.04.5 amd64 [upgradable from: 4.4.1-2.1ubuntu5.20.04.4]
isc-dhcp-common/focal-updates 4.4.1-2.1ubuntu5.20.04.5 amd64 [upgradable from: 4.4.1-2.1ubuntu5.20.04.4]
kmod/focal-updates 27-1ubuntu2.1 amd64 [upgradable from: 27-1ubuntu2]
landscape-common/focal-updates 19.12-0ubuntu4.3 amd64 [upgradable from: 19.12-0ubuntu4.2]
libapparmor1/focal-updates 2.13.3-7ubuntu5.2 amd64 [upgradable from: 2.13.3-7ubuntu5.1]
libapt-pkg6.0/focal-updates 2.0.9 amd64 [upgradable from: 2.0.6]
libc-bin/focal-updates 2.31-0ubuntu9.9 amd64 [upgradable from: 2.31-0ubuntu9.7]
libc6/focal-updates 2.31-0ubuntu9.9 amd64 [upgradable from: 2.31-0ubuntu9.7]
libfwupd2/focal-updates 1.7.9-1~20.04.1 amd64 [upgradable from: 1.7.5-3~20.04.1]
libfwupdplugin5/focal-updates 1.7.9-1~20.04.1 amd64 [upgradable from: 1.7.5-3~20.04.1]
libkeyutils1/focal-updates 1.6-6ubuntu1.1 amd64 [upgradable from: 1.6-6ubuntu1]
libkmod2/focal-updates 27-1ubuntu2.1 amd64 [upgradable from: 27-1ubuntu2]
libmbim-glib4/focal-updates 1.26.2-1~ubuntu20.04.1 amd64 [upgradable from: 1.24.8-1~20.04]
libmbim-proxy/focal-updates 1.26.2-1~ubuntu20.04.1 amd64 [upgradable from: 1.24.8-1~20.04]
libmm-glib0/focal-updates 1.18.6-1~ubuntu20.04.1 amd64 [upgradable from: 1.16.6-2~20.04.1]
libnetplan0/focal-updates 0.104-0ubuntu2~20.04.2 amd64 [upgradable from: 0.104-0ubuntu2~20.04.1]
libnl-3-200/focal-updates 3.4.0-1ubuntu0.1 amd64 [upgradable from: 3.4.0-1]
libnl-genl-3-200/focal-updates 3.4.0-1ubuntu0.1 amd64 [upgradable from: 3.4.0-1]
libqmi-glib5/focal-updates 1.30.4-1~ubuntu20.04.1 amd64 [upgradable from: 1.28.6-1~20.04.1]
libqmi-proxy/focal-updates 1.30.4-1~ubuntu20.04.1 amd64 [upgradable from: 1.28.6-1~20.04.1]
libsnmp-base/focal-updates 5.8+dfsg-2ubuntu2.7 all [upgradable from: 5.8+dfsg-2ubuntu2.6]
libsnmp35/focal-updates 5.8+dfsg-2ubuntu2.7 amd64 [upgradable from: 5.8+dfsg-2ubuntu2.6]
libtss2-esys0/focal-updates 2.3.2-1ubuntu0.20.04.1 amd64 [upgradable from: 2.3.2-1]
libunwind8/focal-updates 1.2.1-9ubuntu0.1 amd64 [upgradable from: 1.2.1-9build1]
linux-firmware/focal-updates 1.187.36 all [upgradable from: 1.187.29]
locales/focal-updates 2.31-0ubuntu9.9 all [upgradable from: 2.31-0ubuntu9.7]
modemmanager/focal-updates 1.18.6-1~ubuntu20.04.1 amd64 [upgradable from: 1.16.6-2~20.04.1]
motd-news-config/focal-updates 11ubuntu5.7 all [upgradable from: 11ubuntu5.5]
netplan.io/focal-updates 0.104-0ubuntu2~20.04.2 amd64 [upgradable from: 0.104-0ubuntu2~20.04.1]
open-vm-tools/focal-updates 2:11.3.0-2ubuntu0~ubuntu20.04.4 amd64 [upgradable from: 2:11.3.0-2ubuntu0~ubuntu20.04.3]
openssh-client/focal-updates 1:8.2p1-4ubuntu0.5 amd64 [upgradable from: 1:8.2p1-4ubuntu0.4]
openssh-server/focal-updates 1:8.2p1-4ubuntu0.5 amd64 [upgradable from: 1:8.2p1-4ubuntu0.4]
openssh-sftp-server/focal-updates 1:8.2p1-4ubuntu0.5 amd64 [upgradable from: 1:8.2p1-4ubuntu0.4]
python-apt-common/focal-updates 2.0.1ubuntu0.20.04.1 all [upgradable from: 2.0.0ubuntu0.20.04.7]
python3-apport/focal-updates 2.20.11-0ubuntu27.25 all [upgradable from: 2.20.11-0ubuntu27.24]
python3-apt/focal-updates 2.0.1ubuntu0.20.04.1 amd64 [upgradable from: 2.0.0ubuntu0.20.04.7]
python3-distupgrade/focal-updates 1:20.04.41 all [upgradable from: 1:20.04.37]
python3-problem-report/focal-updates 2.20.11-0ubuntu27.25 all [upgradable from: 2.20.11-0ubuntu27.24]
python3-software-properties/focal-updates 0.99.9.11 all [upgradable from: 0.99.9.8]
python3-update-manager/focal-updates 1:20.04.10.11 all [upgradable from: 1:20.04.10.10]
sbsigntool/focal-updates 0.9.2-2ubuntu1.1 amd64 [upgradable from: 0.9.2-2ubuntu1]
snapd/focal-updates 2.58+20.04 amd64 [upgradable from: 2.57.5+20.04ubuntu0.1]
software-properties-common/focal-updates 0.99.9.11 all [upgradable from: 0.99.9.8]
sosreport/focal-updates 4.4-1ubuntu0.20.04.1 amd64 [upgradable from: 4.3-1ubuntu0.20.04.2]
tcpdump/focal-updates 4.9.3-4ubuntu0.2 amd64 [upgradable from: 4.9.3-4ubuntu0.1]
ubuntu-advantage-tools/focal-updates 27.13.6~20.04.1 amd64 [upgradable from: 27.6~20.04.1]
ubuntu-release-upgrader-core/focal-updates 1:20.04.41 all [upgradable from: 1:20.04.37]
unattended-upgrades/focal-updates 2.3ubuntu0.3 all [upgradable from: 2.3ubuntu0.1]
update-manager-core/focal-updates 1:20.04.10.11 all [upgradable from: 1:20.04.10.10]
update-notifier-common/focal-updates 3.192.30.17 all [upgradable from: 3.192.30.10]
</pre>
