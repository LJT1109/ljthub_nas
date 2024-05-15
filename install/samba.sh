sudo mkdir /mnt/storage0
sudo mount /dev/sda2 /mnt/storage0/

sudo docker run -d -p 139:139 -p 445:445 --hostname $HOSTNAME \
    --name samba --restart unless-stopped \
    -v ljt:/mnt/storage0 elswork/samba \
    -u "$(id -u):$(id -g):$(id -un):$(id -gn):Aa27378745" \
    -s "ljt:/mnt/storage0:rw:$(id -un)"

sudo docker stop samba
sudo docker rm samba
sudo rm -r /mnt/storage0/*