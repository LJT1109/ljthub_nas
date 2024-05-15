# ljthub_nas
 
Quick Start
-----------
 
```bash
# install git and open-ssh-server
sudo apt-get install -y git openssh-server

# clone the repository
git clone https://github.com/ljthub/ljthub_nas.git

# change to the repository directory
cd ljthub_nas
```

```bash
#Set up ssh key
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
#mac/linux
ssh-copy-id user@server_ip
#windows
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh user@server_ip "cat >> .ssh/authorized_keys"

```



host setup
----------
 
```bash
# change to the host directory
cd host

# run the setup script
./setup.sh
```