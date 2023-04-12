# Terraform Azure RM


## :a: Create the VM

```
terraform init
```

```
terraform plan
```

```
terraform apply
```


## :b: Docker Context

https://blog.mikesir87.io/2019/08/using-ssh-connections-in-docker-contexts/

- [ ] Set the `SSH` agent and key 

- [ ] Create the context

```
docker context create machine-CB-AZ-300000000 --docker "host=ssh://terraform@20.63.68.184"
```

- [ ] Use the context 

```
docker context use machine-CB-AZ-300000000
```


# References

https://github.com/hashicorp/terraform-provider-azurerm

https://www.phillipsj.net/posts/cloud-init-with-terraform/

- [ ] Portail Azure

https://portal.azure.com/

[Resssource Blade Machines Virtuelles](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/Microsoft.Compute/VirtualMachines)

- [ ] image list [VM 2nd Generation](https://docs.microsoft.com/en-us/azure/virtual-machines/generation-2)

```
az vm image list --publisher Canonical --sku gen2 --output table --all
```
>
```
Offer                                         Publisher    Sku                           Urn                                                                                          Version
--------------------------------------------  -----------  ----------------------------  -------------------------------------------------------------------------------------------  ---------------
0001-com-ubuntu-confidential-vm-experimental  Canonical    18_04-gen2                    Canonical:0001-com-ubuntu-confidential-vm-experimental:18_04-gen2:18.04.20210309             18.04.20210309
0001-com-ubuntu-confidential-vm-experimental  Canonical    20_04-gen2                    Canonical:0001-com-ubuntu-confidential-vm-experimental:20_04-gen2:20.04.20210309             20.04.20210309
0001-com-ubuntu-confidential-vm-focal         Canonical    20_04-lts-gen2                Canonical:0001-com-ubuntu-confidential-vm-focal:20_04-lts-gen2:20.04.202107090               20.04.202107090
0001-com-ubuntu-confidential-vm-focal         Canonical    20_04-lts-gen2                Canonical:0001-com-ubuntu-confidential-vm-focal:20_04-lts-gen2:20.04.202107200               20.04.202107200
0001-com-ubuntu-confidential-vm-focal         Canonical    20_04-lts-gen2                Canonical:0001-com-ubuntu-confidential-vm-focal:20_04-lts-gen2:20.04.202109080               20.04.202109080
0001-com-ubuntu-confidential-vm-focal         Canonical    20_04-lts-gen2                Canonical:0001-com-ubuntu-confidential-vm-focal:20_04-lts-gen2:20.04.202110290               20.04.202110290
```


# :x: Error

:one: cloud init not starting

```
sudo systemctl status cloud-init
```
> 
```
Feb 12 20:21:06 machine-CB-AZ-INF1087 systemd[1]: cloud-init.service: Failed with result 'exit-code'.
Feb 12 20:21:06 machine-CB-AZ-INF1087 systemd[1]: Failed to start Initial cloud-init job (metadata service crawler).
```

:bulb: Restart cloud init service

```
sudo systemctl start cloud-init
```

:two: `netstat -ltn` not showing `2376` port 

```
docker-machine -D create --driver generic \
               --generic-ip-address=$(terraform output --json | jq '.public_ip_address.value' --raw-output) \
               --generic-ssh-user=terraform \
               --generic-ssh-key ~/.ssh/b300098957@ramena.pk \
               machine-CB-AZ-300000000
```


```
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp6       0      0 :::22                   :::*                    LISTEN
tcp6       0      0 :::2376                 :::*                    LISTEN
```

```
docker-machine -D regenerate-certs machine-CB-AZ-300000000
```