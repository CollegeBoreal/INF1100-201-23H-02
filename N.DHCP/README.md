# DHCP 

### :gear: Se connecter au routeur

```
$ ssh amirali12@10.13.237.200
Password: Terminal@12
```

### :a: Configurer DHCP sur le routeur

- [ ] Configurer le pool DHCP qu'on nommera `hyper-v` 

```
Arta_group> enable
Password: cisco
Arta_group# configure terminal 
Enter configuration commands, one per line.  End with CNTL/Z.
Arta_group(config)# ip dhcp pool hyper-v
Arta_group(dhcp-config)# network 10.13.237.0 255.255.255.0
Arta_group(dhcp-config)# dns-server 1.0.0.1 1.1.1.1
Arta_group(dhcp-config)# default-router 10.13.237.1
Arta_group(dhcp-config)# end
Arta_group(config)#^Z
```

- [ ] Configurer les adresses IP à exclure

```
Arta_group# configure terminal 
Enter configuration commands, one per line.  End with CNTL/Z.
Arta_group(config)#ip dhcp excluded-address 10.13.237.1 10.13.237.191
```

### :b: Vérifier la configuration

```
Arta_group# show running-config
...
ip dhcp excluded-address 10.13.237.1 10.13.237.191
...
!
ip dhcp pool hyper-v
 network 10.13.237.0 255.255.255.0
 default-router 10.13.237.1 
 dns-server 1.0.0.1 1.1.1.1 
...
```

### :ab: Consulter le pool `hyper-v`

- [ ] Son utilisation

``` 
Arta_group# show ip dhcp pool hyper-v

Pool hyper-v :
 Utilization mark (high/low)    : 100 / 0
 Subnet size (first/next)       : 0 / 0 
 Total addresses                : 254
 Leased addresses               : 1
 Excluded addresses             : 1
 Pending event                  : none
 1 subnet is currently in the pool :
 Current index        IP address range                    Leased/Excluded/Total
 10.13.237.194        10.13.237.1      - 10.13.237.254     1     / 1     / 254  
```

- [ ] les liens DHCP associés

```
Arta_group#show ip dhcp binding     
Bindings from all pools not associated with VRF:
IP address      Client-ID/ 		Lease expiration 	Type       State      Interface
		Hardware address/
		User name
10.13.237.193   0012.5f30.949d          Feb 02 2021 09:57 PM    Automatic  Selecting  GigabitEthernet0/0/1
10.13.237.194   0100.155d.ed58.01       Feb 03 2021 09:35 PM    Automatic  Active     GigabitEthernet0/0/1
```

# References

https://www.cisco.com/en/US/docs/ios/12_4t/ip_addr/configuration/guide/htdhcpsv.html

