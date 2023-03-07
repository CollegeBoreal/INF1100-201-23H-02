# Docker Network

## :one: Create a network bridge

- [ ] Create the network

```
docker network create ubuntu-network   
```
> 93b6e64b9819912b67bae4531925af66eaa9a5a42b28bb6dbaf278732991ea27

- [ ] Check the network creation

```
docker network ls
```
> Outputs :
<pre>
NETWORK ID     NAME             DRIVER    SCOPE
fa06f156af39   bridge           bridge    local
c18cb2c9cc16   host             host      local
162f8bf7915b   none             null      local
93b6e64b9819   ubuntu-network   bridge    local
</pre>

## :two: Use the network bridge

- [ ] Create a container using the network bridge

```
docker container run --network ubuntu-network --interactive --tty --detach ubuntu
```
> da5364a3e3561e9377bceaa3cc2e4aa8aad809c5b268c1823b536fb157366695

- [ ] Inspect the network bridge

* [IPAM: IP Address Management](https://www.docker.com/blog/docker-networking-design-philosophy)

```
docker network inspect ubuntu-network
```
> Otuputs :
```json
[
  {
    "Name": "ubuntu-network",
    "Id": "93b6e64b9819912b67bae4531925af66eaa9a5a42b28bb6dbaf278732991ea27",
    "Created": "2023-03-07T19:21:54.843428006Z",
    "Scope": "local",
    "Driver": "bridge",
    "EnableIPv6": false,
    "IPAM": {
      "Driver": "default",
      "Options": {},
      "Config": [
        {
          "Subnet": "172.19.0.0/16",
          "Gateway": "172.19.0.1"
        }
      ]
    },
    "Internal": false,
    "Attachable": false,
    "Ingress": false,
    "ConfigFrom": {
      "Network": ""
    },
    "ConfigOnly": false,
    "Containers": {
      "da5364a3e3561e9377bceaa3cc2e4aa8aad809c5b268c1823b536fb157366695": {
        "Name": "jolly_brattain",
        "EndpointID": "59707ad00ec4f7248ac05026accbba19dfd88cc40ac8caa7dad4349896d633dc",
        "MacAddress": "02:42:ac:13:00:02",
        "IPv4Address": "172.19.0.2/16",
        "IPv6Address": ""
      }
    },
    "Options": {},
    "Labels": {}
  }
]
```

## :three: Check the IP Address

- [ ] find the `container_id`

```
docker container ls
```
> Outputs :
<pre>
CONTAINER ID   IMAGE   COMMAND      CREATED         STATUS         PORTS   NAMES
da5364a3e356   ubuntu  "/bin/bash"  4 minutes ago   Up 4 minutes           jolly_brattain
</pre>

- [ ] get onto the container

```
docker container exec --interactive --tty da5364a3e356 bash
```

- [ ] Install the `iproute2` package from `APT`

```
apt update; apt install iproute2 --yes
```

- [ ] Check the IP address match the `docker network inspect` command

```
ip addr
```
> Outputs :
<pre>
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
44: eth0@if45: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:13:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.19.0.2/16 brd 172.19.255.255 scope global eth0
       valid_lft forever preferred_lft forever
</pre>

```
docker network rm ubuntu-network   
```
> Outputs :
<pre>
Error response from daemon: error while removing network: network ubuntu-network id 93b6e64b9... has active endpoints
</pre>

# References

- [ ] [How Docker Networking Works and the Importance of IPAM Functionality](https://blogs.infoblox.com/community/how-docker-networking-works-and-the-importance-of-ipam)
