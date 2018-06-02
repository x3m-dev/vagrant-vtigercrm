#!/bin/bash
#

sudo apt install -y dirmngr --install-recommends
sudo apt install -y apt-transport-https lsb-release ca-certificates

sudo tee /etc/apt/sources.list.d/mysql.list <<EOL
deb http://repo.mysql.com/apt/debian/ stretch mysql-apt-config
deb http://repo.mysql.com/apt/debian/ stretch mysql-5.7
deb http://repo.mysql.com/apt/debian/ stretch mysql-tools
deb-src http://repo.mysql.com/apt/debian/ stretch mysql-5.7
EOL
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5072E1F5

curl https://packages.sury.org/php/apt.gpg | sudo apt-key add -
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/php.list

sudo apt update

sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again password root'
sudo debconf-set-selections <<< 'mysql-community-server  mysql-community-server/re-root-pass password root'
sudo debconf-set-selections <<< 'mysql-community-server  mysql-community-server/root-pass password root'
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y mysql-server mysql-client
sudo apt-get install -y mysql-client
echo "sql_mode = ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" | sudo tee -a /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl enable mysql && sudo systemctl restart mysql

sudo apt install -y apache2 curl vim
sudo apt install -y php5.6 php5.6-mysql php5.6-xml php5.6-curl php5.6-gd php5.6-imap php5.6-mbstr
sudo sed -i 's/display_errors.*=.*Off/display_errors = On/g' /etc/php/5.6/apache2/php.ini
sudo sed -i 's/log_errors.*=.*On/log_errors = Off/g' /etc/php/5.6/apache2/php.ini
sudo systemctl restart apache2

cd /tmp
wget https://netcologne.dl.sourceforge.net/project/vtigercrm/vtiger%20CRM%207.1.0/Core%20Product/vtigercrm7.1.0.tar.gz &>/dev/null
tar xfz vtigercrm7.1.0.tar.gz
sudo mv vtigercrm /var/www/html
sudo chmod -R 777 /var/www/html/vtigercrm
