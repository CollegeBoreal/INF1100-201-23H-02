# :minidisc: Service [iSCSI](http://www.open-iscsi.com)

<img src="../images/iSCSI-Techbast.png" width="675" height="410"></img>

## :a: Vérifier la présence du fichier de configuration `iscsi` 

```
sudo cat /etc/iscsi/initiatorname.iscsi
```

:bulb: si le fichier `ìnitiator` n'est pas présent, installer `open-iscsi`:

```
sudo apt-get update && sudo apt-get install open-iscsi
```

## :b: Vérifier que le service `iscsid` est disponible

:warning: Printout below shows `disabled` 

```
systemctl status iscsid 
```
> Retourne
```
● iscsid.service - iSCSI initiator daemon (iscsid)
     Loaded: loaded (/lib/systemd/system/iscsid.service; disabled; vendor preset: enabled)
     Active: inactive (dead)
TriggeredBy: ● iscsid.socket
       Docs: man:iscsid(8)
```

- [ ] Démarrer le service `iscsid`

```
sudo systemctl enable --now iscsid
```
> Retourne
```
Synchronizing state of iscsid.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable iscsid
Created symlink /etc/systemd/system/sysinit.target.wants/iscsid.service → /lib/systemd/system/iscsid.service.
```

- [ ] Vérifier qu'il est démarré et en marche `active (running)`

```
systemctl status iscsid 
```
> Retourne
```
● iscsid.service - iSCSI initiator daemon (iscsid)
     Loaded: loaded (/lib/systemd/system/iscsid.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2021-02-28 18:13:56 UTC; 8s ago
TriggeredBy: ● iscsid.socket
       Docs: man:iscsid(8)
    Process: 727335 ExecStartPre=/lib/open-iscsi/startup-checks.sh (code=exited, status=0/SUCCESS)
    Process: 727344 ExecStart=/sbin/iscsid (code=exited, status=0/SUCCESS)
   Main PID: 727346 (iscsid)
      Tasks: 2 (limit: 77183)
     Memory: 3.6M
     CGroup: /system.slice/iscsid.service
             ├─727345 /sbin/iscsid
             └─727346 /sbin/iscsid

Feb 28 18:13:56 brooks systemd[1]: Starting iSCSI initiator daemon (iscsid)...
Feb 28 18:13:56 brooks iscsid[727344]: iSCSI logger with pid=727345 started!
Feb 28 18:13:56 brooks systemd[1]: iscsid.service: Failed to parse PID from file /run/iscsid.pid: Invalid argument
Feb 28 18:13:56 brooks systemd[1]: Started iSCSI initiator daemon (iscsid).
Feb 28 18:13:57 brooks iscsid[727345]: iSCSI daemon with pid=727346 started!
```

[:back:](../#roll_of_paper-le-périphérique-block-device)

# References:

- [ ] [OpenEBS Install Prerequisites - Ubuntu](https://openebs.io/docs/user-guides/prerequisites#ubuntu)
- [ ] [Visio Stencils: Operation diagram of iSCSI Target Server](https://techbast.com/2019/06/visio-stencils-operation-diagram-of-iscsi-target-server.html)
