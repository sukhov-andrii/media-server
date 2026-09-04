
# Docker commands

List of docker commands for my home server.


# Organization
1. Using
2. Installation setup


# Using
## Running
cd media-server
docker compose up -d
docker compose down
sudo docker restart qbittorrent

## Debugging
docker logs gluetun

### Gluetun setup

Request api 
Proton vpn -> Downloads -> WireGuard configuration
(expires in 1 year, currently  Mediaserver - Ubuntu Mar 7, 2027)

### Check status
watch -n 2 sudo docker compose ps
sudo docker compose ps

sudo systemctl status docker

### Port forwarding
```
sudo docker logs gluetun | grep -i port
```
2026-03-07T21:02:42Z INFO [port forwarding] port forwarded is 51531
Now go to qBittorrent Web UI → Tools → Options → Connection and set the listening port to 51531.
One thing to be aware of — this port number is dynamically assigned by ProtonVPN and will change every time Gluetun reconnects. So if you restart Gluetun, you'll need to check the logs again and update qBittorrent with the new port.


### Check ip leak
You need to answer these continuously:

* What is my public IP right now?
* Is traffic actually going through Gluetun?
* Is Tailscale reachable from outside?
* Are containers leaking outside VPN?


sudo docker inspect qbittorrent | grep NetworkMode
curl ifconfig.me
 sudo docker exec -it qbittorrent curl ifconfig.me

### Check tailscale
ip addr show tailscale0
sudo ss -tlnp | grep 8096
 sudo ufw status
 sudo docker exec tailscale tailscale status

 ### Setup adguard
 ipv4 94.140.14.14, 94.140.15.15
 ipv6 2a10:50c0::1:ff, 2a10:50c0::2:ff


# Installation setup 

Create docker file `docker-compose.yml`

### automatically start docker on boot
sudo systemctl enable docker - 

### setup hard drive access rights
nautilus -q
sudo mount /dev/sdb1 /mnt/media_hdd
ls /mnt/media_hdd
sudo chown -R $USER:$USER /mnt/media_hdd
 sudo chmod -R 755 /mnt/media_hdd
 sudo nano /etc/fstab
 pwd

### Misc commands
id andrii

#### Check disk health
sudo apt install smartmontools
lsblk --> drive name (e.g. sdb)
sudo smartctl -H /dev/sdb
sudo smartctl -a /dev/sdb
sudo smartctl -t long /dev/sdbn      


#### Setup reverse proxy
Docker nginx proxy manager
Get dns (free [duckdns] or paid[namecheap, godaddy] etc)

duckdns setup
Current ip 92.65.205.186 (???)
Changed to 192.168.10.25 (IDK WHICH ONE S CRRECT)

if you are using a different ip provider, need to create an additional cname record for all the subdomains

####
Qbittorent not working as integration in Homarr

https://www.reddit.com/r/selfhosted/comments/181v06v/why_doesnt_qbittorrent_open_from_homarr/

Solution: Disable clickjacking and CSRF protection in the settings of qBittorrent. Located in the Web UI tab under security. 