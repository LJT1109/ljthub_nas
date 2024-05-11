#!/bin/bash

# 更新系统
sudo apt-get update -y
sudo apt-get upgrade -y

# 安装软件包
sudo apt install curl samba nginx build-essential php8.3 php8.3-fpm php8.3-cgi mysql-server -y

# 安装Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc 
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# 安装gcc
brew install gcc

# 配置Samba共享
sudo tee -a /etc/samba/smb.conf > /dev/null <<EOF
[www]
    comment = nginx
    path = /var/www/html
    read only = no
    browsable = yes
    valid users = @users
    
[homes]
    comment = Home Directories
    browseable = no
    read only = no
    create mask = 0700
    directory mask = 0700
    valid users = %S


EOF

# 修改Nginx配置
# fastcgi_pass unix:/var/run/php/php-fpm.sock
sudo nano /etc/nginx/sites-available/default

# 设置文件夹权限
sudo chown -R www-data:www-data /var/www

sudo smbpasswd -a ljt

brew install docker
# sudo wget https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.zip -O /var/www/html/phpMyAdmin.zip
# sudo unzip /var/www/html/phpMyAdmin.zip -d /var/www/html
# sudo mv /var/www/html/phpMyAdmin-5.2.1-all-languages /var/www/html/phpMyAdmin
# sudo chown -R www-data:www-data /var/www/html/phpMyAdmin
# sudo rm /var/www/html/phpMyAdmin.zip
sudo apt install phpmyadmin -y

#install nextcloud
sudo wget https://download.nextcloud.com/server/installer/setup-nextcloud.php -O /var/www/html/setup-nextcloud.php
sudo apt install php-zip php-dom php-xml php-mbstring php-gd php-curl php-mysql -y
sudo systemctl restart php8.3-fpm


#run php 


# 重启Samba服务并允许访问
sudo systemctl restart smbd
sudo systemctl restart nginx
sudo ufw allow samba

