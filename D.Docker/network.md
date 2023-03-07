# Docker Network


```
docker network create ubuntu-network   
```
> 93b6e64b9819912b67bae4531925af66eaa9a5a42b28bb6dbaf278732991ea27

```
docker network ls
```
> Outputs :
<pre>
NETWORK ID     NAME             DRIVER    SCOPE
fa06f156af39   bridge           bridge    local
c18cb2c9cc16   host             host      local
ebe55c889a1f   kind             bridge    local
162f8bf7915b   none             null      local
93b6e64b9819   ubuntu-network   bridge    local
</pre>

```
docker container run --network ubuntu-network --interactive --tty --detach ubuntu
```
> da5364a3e3561e9377bceaa3cc2e4aa8aad809c5b268c1823b536fb157366695

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

```
docker container ls
```
> Outputs :
<pre>
CONTAINER ID   IMAGE   COMMAND      CREATED         STATUS         PORTS   NAMES
da5364a3e356   ubuntu  "/bin/bash"  4 minutes ago   Up 4 minutes           jolly_brattain
</pre>
