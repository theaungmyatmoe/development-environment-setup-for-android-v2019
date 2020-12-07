# LAMP and LEMP Stacks Setup Guide

> **LAMP** and **LEMP** Stacks Setup at **UBUNTU** (v-20.4) and **Android**(X)

**Author** - [Aung Myat Moe](https://github.com/amm834)

**Want to Contribute?** - Fork And Pull Request!

----

# Requirements
## Android
- Android version up to 7.0 (I am using Andriod X)

## Linux (UBUNTU 20.4)
- Linux 
- Ubuntu Avaliable for Andriod (Shell Script Avaliable)

----

# Table Of Contents

1. [PHP Setup](#php-a)
1. [MYSQL Setup](#mysql-a)
1. [CREATE MYSQL PRIVILIAGE](#mysql-priv)
1. [UBUNTU in Termux](#ubuntu-in-termux)
1. [Install Apache Server](#apache-server)
1.[PHP8 Setup](#php8-a)(Termux Avaliable)
1. [Install Nginx (Termux)](#nginx-termux)
1. [Vim Setup](#vim) (Optional)
1. [Install PHP8 In Ubuntu](#php-ubuntu)
1. [Apache2 80 Host Problem In Ubuntu](#ubuntu-apache-solved)
1. [LICENSE](#mit)

----

# Andriod Platform

 Install Termux From Google Play Store or F-Droid first.
 (Setup in Termux is PHP-7.4)
 
1. Installtion Packages In Termux

```bash
apt update && apt upgrade -y
```

2. Upgrade All Packages

```bash
pkg up

```
3. <a name="php-a">Install PHP </a>

```bash
pkg install php
pkg install php-apache
```

4. Poof PHP is avaliable.or not by running

```bash
php -v 
```
5. <a name="apache-server">Install Apache2</a>

```bash
pkg install apache2
```

6. Go To `/data/data/com.termux/files/usr`

```bash
cd $PREFIX
```

7. Go To Under Apache2 Dir

```bash
cd apache2
```

8. Edit `httpd.conf`

```bash
pkg install nano #to install code editor
nano httpd.conf
```
9. Added PHP7 Module at the end of file `httpd.conf`

```conf
LoadModule php7_module libexec/apache2/libphp7.so
<FilesMatch \.php$> 
   SetHandler application/x-httpd-php
</FilesMatch>
<IfModule dir_module>
    DirectoryIndex index.php
</IfModule>
```

9. <a name="php8-a">PHP 8 In Apache</a>

```conf
LoadModule php_module libexec/apache2/libphp.so
<FilesMatch \.php$> 
   SetHandler application/x-httpd-php
</FilesMatch>
<IfModule dir_module>
    DirectoryIndex index.php
</IfModule>

```

10. Find `worker` Module of PHP

<kbd>CTRL</kbd>+<kbd>w</kbd> and type `worker` and <kbd>Enter</kbd> and you will see lile below : 

```conf
LoadModule mpm_worker_module libexec/apache2/mod_mpm_worker.so
```
and comment it!Like below : 

```conf
#LoadModule mpm_worker_module libexec/apache2/mod_mpm_worker.so
```

11. Find `prefork` Module for PHP7 to load PHP7.[Arch Linux Wiki Page](https://wiki.archlinux.org/index.php/Apache_HTTP_server#PHP)
You will see like :

```conf
#LoadModule mpm_prefork_module libexec/apache2/mod_mpm_prefork.so
```

and Uncomment it

```conf
LoadModule mpm_prefork_module libexec/apache2/mod_mpm_prefork.so
```
and start apache server

```bash
httpd -v # Proof For Server 
killall httpd; httpd # restart server
apachectl start # to start apache server
apachectl stop #to stop server
apachectl restart #to restart when edited config files
```
Note: If you get servername error open `httpd.conf` file and search `ServerName` and edit loke below :

```bash
ServerName localhost:8080
```

11. Open Browser and search url `localhost:8080` you will see `It work!` that is default!
12. We will cchange Directory of DocumentRoot

13. Stop Server first  `apachectl stop`

14. If you are at `/home` you can type line 6,7,8 again.
15. Search `DocumentRoot` and change default to following

```bash
DocumentRoot "/sdcard/htdocs"
<Directory "/sdcard/htdocs">
```

16. Create Dir under Internal Storage

```bash
cd
cd /sdcard/
mkdir htdocs
```

17. Open htdocs from text editor!
18. Create php file and test it.
19. For Testing!

```bash
#under /sdcard/htdocs/
echo "<?php echo 'Hello World!' ?>" >>> index.php 
```

20.Start apache server `apachectl start` and open browser and check it work or not!

Note: You can change DocumentRoot directory what you like but don't add `/` end of dir root that will crash your server!!!

21. Enable apache rewrite module by searching `rewrite` at `httpd.conf` and uncomment it!

```conf
LoadModule rewrite_module libexec/apache2/mod_rewrite.so
```
# <a name="nginx-termux">  Nginx Server Setup In Termux </a>

1. Install Nginx Package

```bash
pkg install nginx  # Install nginx 
pkg install php-fpm #Install Fast-cgi for PHP with nginx
```

2. Setup PHP FPM
```bash
cd /data/data/com.termux/files/usr/etc/php-fpm.d
vim www.conf # Open File
```
----

# <a name="vim">Vim  Setup</a>

##Setup Vim (If you installed Skip This)

```bash
pkg install vim 
vim
```
 <kbd>ESC<kbd> and Type `:set number`.
 
 -----
 
 3. When you opened `www.conf` and go to line **36** and delete it and enter following
 
```conf
listen = 127.0.0.1:9000
```
and **Save It**. To save <kbd>ESC</kbd> and type `:wq`.
**Note** About line is to setup with nginx!

4. Go to nginx setup path.

```bash
cd 
cd  /data/data/com.termux/files/usr/etc/nginx
vim nginx.conf # Open Nginx Default Config File
```

6. And go to line **36** that should like below

```conf
listen8080;                   server_name  localhost;
```
And go line **44**

```conf
root   /data/data/com.termux/files/usr/share/nginx/html;  index  index.php index.html;
```
Added **index.php** like above.

And paste below command at the end of `location \ {……}`.

```conf

location ~ \.php$ {

  root          /data/data/com.termux/files/usr/share/nginx/html;
  
  fastcgi_pass   127.0.0.1:9000;
  
  fastcgi_index  index.php;
  fastcgi_param SCRIPT_FILENAME  /data/data/com.termux/files/usr/share/nginx/html$fast    cgi_script_name;
  
  include fastcgi_params;       
}

```
And save it.

7. Reload Nginx Server

```bash
nginx -s reload #reload Server if you started!
php-fpm # start PHP-fpm to run php scripts
nginx # start server
```

and search
`http://localhost:8080/` and you will see `Thank you bla bla!`

8. To edit php files go to 

```bash
cd 
cd /data/data/com.termux/files/usr/share/nginx/html
echo "<?php echo "Server Engine X "; ?>" > index.php
```
Go to **localhost** at browser and see result again.

(PHP8 is Avaliable Now ❤️)
-----

# <a name="mysql-a">Install Mysql Server (Mariadb In Termux)</a>


1. Install Mariadb

```bash
pkg install mariadb
mysql # Of You get errors
```
like

```bash
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/data/data/com.termux/files/usr/tmp/mysqld.sock' (2)
```

You can start mysql server manually by opening `mysql.sh`.

2. Go to

```bash
cd
cd $PREFIX
cd etc
cd init.d
ls #you will see `mysql` file that is executable binary file!
```
3. Start Server

run

```bash
./mysql status #check status running or not
./mysql start # start server
mysql #you will login into mariadb
```

like

```bash
#Output
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 4
Server version: 10.5.8-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]>

```
You are now loged in!
<kbd>CTRL</kbd>+<kbd>D</kbd> to exit! You can also type `exit` .
I prefer CLI 😁

When you stop like `./mysql stop` you will get errors like

```bash
ERROR! MariaDB server process #4215 is not running!
```

You can see all process of mysql run  :

```bash
find 'etc' | grep 'mysql'
```
Stop process by running :

```bash
stop mysql
```

If you want to start again?Run

```bash
mysqld_safe #to start
stop mysql #to stop
```

# <a name="mysql-priv">Create MYSQL PRIVILIAGE</a>

This setup is to access database from PHP 'username'.

# Ubuntu (v-20.4 LTS)
Installtion should done it yourself!

## <a name="ubuntu-in-termux">Ubuntu Installtion In Termux (skip on linux)</a>

Create new file `ubuntu.sh` and  `grant it` by `chmod +x ubtnu.sh
Copy following and run `./ubuntu.sh` and wait some minute. ⏱️
When complete  run `./ubuntu.sh` and autologin to ubuntu like :

```bash
root@localhost:~# #Example When Loged In
```
run 

```bash
pkg install wget openssl-tool proot -y && hash -r && wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Ubuntu/ubuntu.sh && bash ubuntu.sh
./start-ubuntu.sh
```

or
Download File and make executable and run.

[Download Shell Script File](start-ubuntu.sh)

Copy Below and save as a file and make it executable.And run.

```bash
#!/data/data/com.termux/files/usr/bin/bash
folder=ubuntu-fs
if [ -d "$folder" ]; then
	first=1
	echo "skipping downloading"
fi
tarball="ubuntu-rootfs.tar.xz"
if [ "$first" != 1 ];then
	if [ ! -f $tarball ]; then
		echo "Download Rootfs, this may take a while base on your internet speed."
		case `dpkg --print-architecture` in
		aarch64)
			archurl="arm64" ;;
		arm)
			archurl="armhf" ;;
		amd64)
			archurl="amd64" ;;
		x86_64)
			archurl="amd64" ;;	
		i*86)
			archurl="i386" ;;
		x86)
			archurl="i386" ;;
		*)
			echo "unknown architecture"; exit 1 ;;
		esac
		wget "https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Rootfs/Ubuntu/${archurl}/ubuntu-rootfs-${archurl}.tar.xz" -O $tarball
	fi
	cur=`pwd`
	mkdir -p "$folder"
	cd "$folder"
	echo "Decompressing Rootfs, please be patient."
	proot --link2symlink tar -xJf ${cur}/${tarball}||:
	cd "$cur"
fi
mkdir -p ubuntu-binds
bin=start-ubuntu.sh
echo "writing launch script"
cat > $bin <<- EOM
#!/bin/bash
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A ubuntu-binds)" ]; then
    for f in ubuntu-binds/* ;do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b ubuntu-fs/root:/dev/shm"
## uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
## uncomment the following line to mount /sdcard directly to / 
#command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

echo "fixing shebang of $bin"
termux-fix-shebang $bin
echo "making $bin executable"
chmod +x $bin
echo "removing image for some space"
rm $tarball
echo "You can now launch Ubuntu with the ./${bin} script"
```

**Note** If you crash on Android ``GOOGLE it yourself!

**Note** PHP8 is not avaliable for current Termux.

# <a name="php-ubuntu">PHP8.0 In Ubuntu 20</a>
(also avaliable at android Ubuntu)

1. List existing PHP packages

```bash
dpkg -l | grep php | tee packages.txt
```

2. Add `ondrej/php PPA`

```bash
apt-get install sudo
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
```
Steps above will add the PPA as a source of packages, that contains all PHP packages and their dependencies such as argon2 and libzip.

3. Install PHP 8.0 and extensions

All PHP 8.0 packages follow php8.0-NAME pattern, and php8.0-common package includes a sensible set default of extensions (such as `php8.0`).

```bash
sudo apt install php8.0
#sudo apt install php8.0-common php8.0-cli -y
```
 
Proof of PHP8 run 

```bash
php -v # Show PHP version.
php -m # Show PHP modules loaded.
```

4. Add Additional Extension

```bash
sudo apt install php8.0-{bz2,curl,intl,mysql,readline,xml}
```

5. Restart Apache Server

```bash
sudo service apache2 restart
```

6. Remove all Old Version of PHP

```bash
sudo apt purge '^php7.4.*'
```

-----

# <a name="ubuntu-apache-solved"> Apache2 80 Host Problem In Ubuntu (Sloved!)</a>

1. To apache2 run :

```bash
cd /etc/apache2
```

2. Edit `ports.conf`

from

```conf
# If you just change the port or add more ports here, you will likely>
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
to

```conf
# If you just change the port or add more ports here, you will likely>
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 8080

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```

3. Save and then run

```bash
cd /etc/apache2/sites-enabled
```
4. Open `000-default.conf`

from

```conf
VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to                  # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
       # ServerName localhost
        ServerAdmin webmaster@localhost                                                  DocumentRoot /var/www/
        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.                                                            # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```

TO

```conf
VirtualHost *:8080>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to                  # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        ServerName localhost
        ServerAdmin webmaster@localhost                                                         DocumentRoot /var/www/
        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.                                                            # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
And create php file at 
`cd /var/www`

and 
create `index.php` and test code write and start `apache server`

```bash
sudo service apache2 restart
```
and Open in browser and check at `localhost:8080`.

# Setup Apache Server In Ubuntu

Search `var/www/html` and and change TO

```conf
<Directory /var/www/>                            Options Indexes FollowSymLinks           AllowOverride None                       Require all granted              </Directory>
```

add Servername at the end 

```conf
ServerName localhost
```
and go to

`/etc/apache2/sites-enabled` Edit `000-default.conf` 

```conf
<VirtualHost *:8080>
        # The ServerName directive sets the request scheme>
        # the server uses to identify itself. This is used>
        # redirection URLs. In the context of virtual host>
        # specifies what hostname must appear in the reque>
        # match this virtual host. For the default virtual>
        # value is not decisive as it is used as a last re>
        # However, you must set it for any further virtual>
        ServerName localhost
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/
        # Available loglevels: trace8, ..., trace1, debug,>
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel fo>        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log                       CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available>
        # enabled or disabled at a global level, it is pos>
        # include a line for only one particular virtual h>
        # following line enables the CGI configuration for>
        # after it has been globally disabled with "a2disc>
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```
also change `ports.conf`
```conf
Listen 8080                                 
<IfModule ssl_module>
        Listen 443                          </IfModule>

<IfModule mod_gnutls.c>
        Listen 443                          </IfModule>
```

----

## Android and Linux (Ubuntu 20)

1. Start MySQL Server

```bash
#Android
mysqld_safe 
#Ubuntu
sudo service mysql start
```
and then run

```bash
mysql
# Output
# MariaDB [(none)]> SQL Here
```
2. Type SQL

```sql
CREATE USER 'root' IDENTIFIED BY '';
GRANT ALL ON db.* TO root@localhost IDENTIFIED BY '';
FLUSH PRIVILEGES;
```

Note:SQL statement is end with `;`

Now you can access by `root` username and password is ` ` empty on `port:3306` (default) of mysql.

----

# <a name="mit">LICENSE</a>

```
MIT License

Copyright (c) 2020 Aung Myat Moe

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

```
