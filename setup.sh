#!/bin/bash

# 更新系统
sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install -y tasksel

sudo apt install phpmyadmin
# 安装软件包
sudo apt install curl samba build-essential -y

# 安装Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc 
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# 安装gcc
brew install gcc

# 安装LAMP And PHPMyAdmin
sudo tasksel install lamp-server
sudo apt install phpmyadmin -y

sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
sudo mysql -u root -p
#run this command in mysql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Aa27378745';
FLUSH PRIVILEGES;
exit
sudo a2enconf phpmyadmin.conf
sudo systemctl reload apache2.service

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
#sudo nano /etc/nginx/sites-available/default



# 设置文件夹权限
sudo chown -R www-data:www-data /var/www

sudo smbpasswd -a ljt

#brew install docker
# sudo wget https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.zip -O /var/www/html/phpMyAdmin.zip
# sudo unzip /var/www/html/phpMyAdmin.zip -d /var/www/html
# sudo mv /var/www/html/phpMyAdmin-5.2.1-all-languages /var/www/html/phpMyAdmin
# sudo chown -R www-data:www-data /var/www/html/phpMyAdmin
# sudo rm /var/www/html/phpMyAdmin.zip


#install nextcloud
sudo wget https://download.nextcloud.com/server/installer/setup-nextcloud.php -O /var/www/html/setup-nextcloud.php
sudo apt install php-zip php-dom php-xml php-mbstring php-gd php-curl php-mysql -y
sudo systemctl restart php8.3-fpm


#run php 


# 重启Samba服务并允许访问
sudo systemctl restart smbd
sudo ufw allow samba

