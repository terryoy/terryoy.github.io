# Networking in Docker
- date: 2018-01-12 11:41
- tags: linux,docker
- category: guides
-------

After installed an Ubuntu container in my docker, now I'm trying to learn the networking tools in Ubuntu and Docker.

1. Networking Tools in Ubuntu Again

```bash
# package for ifconfig(which is too old)
$ apt install net-tools

# newer package for networking
$ apt install iproute2

# ping command
$ apt install iputils-ping

# check network interface
$ ifconfig
eth0      Link encap:Ethernet  HWaddr 02:42:ac:11:00:02  
          inet addr:172.17.0.2  Bcast:0.0.0.0  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:5956 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3345 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:8376715 (8.3 MB)  TX bytes:186204 (186.2 KB)
```


2. Docker Commands for Networking

There are three types of networks in docker, and the `bridge` network is by default presented in all docker instances.

```bash
# List networks in Docker
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
a6bf46c2bc44        bridge              bridge              local
e3826e52e7e6        host                host                local
08a134ed472c        none                null                local

# Check docker's network detail
$ docker network inspect bridge
[
    {
        "Name": "bridge",
        "Id": "a6bf46c2bc44dc16523ac28edd5524fccef79b779ae52602c868001763cd21c4",
        "Created": "2018-01-09T11:36:15.168104899Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
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
            "cfc178841a7940b6cbf43c8e0dbd7fb6672af3b3e8a9020632c75352685ec685": {
                "Name": "ubuntu",
                "EndpointID": "8c14adc4a61eacdc8bd2b261d2af4f17c7a966d9fcfb8c61b5f9284fa2eded45",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]


``` 

### 3. Internal Networking

By default, the container is connected within a local network(172.17.0.1/16) bridged to the host machine, host can access the net gateway ip `172.17.0.1`. The contianers should be able to access each other in the local network provided by this net gateway. When you use the command `docker network inspect bridge`, you could see the list of containers and their IPs assigned.

#### 3.1 Accessing container's service by port mapping

Some containers as Nginx provide a service through a local port, in which case you could use port forwarding by your local IP. For example, you can check this port forwarding by `docker port` command or just listing the containers:

```bash
# list ports for container
$ docker port nginx
80/tcp -> 0.0.0.0:5000

# list containers
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                   PORTS                  NAMES
cfc178841a79        ubuntu              "/bin/bash"              3 weeks ago         Up 4 hours                                      ubuntu
0200f61f5d65        nginx               "nginx -g 'daemon of…"   2 months ago        Up 3 minutes             0.0.0.0:5000->80/tcp   webserver



```

Now you can see there is a port mapping from `host:5000` to `container:80`. 

By default, no port is opened for a container to host, you need to specify the port mapping at `docker run` command with `-p`. 

```
# `-d` is when you needed it run as a daemon.
$ docker run nginx -d -p 5000:80 --name nginx nginx

```

To open a port mapping for an existing container is very tricky. It is often said that you need to create another container instance based on the current just to open a port.




