# PHP Setup In Linux
 This is set up guide for WEB DEVELOPEMENT!
 
# Platforms
- Android (Using Termux Application)
- Ubuntu 20 LTS

# Table Of Contents
## Andriod
1. [PHP Setup](#php-a)
1. [MYSQL Setup](#mysql-a)
1. [CREATE MYSQL PRIVILIAGE](#mysql-priv)

# Andriod Platform

 Install Termux From Google Play Store or F-Droid first.
 (Seyup in Termux is PHP-7.4)
 
1. Fresher Installtion

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

4. Poof For PHP

```bash
php -v 
```
5. Install Apache2

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
9. Added PHP7 Module at the end `httpd.conf`

```conf
</IfModule>

LoadModule php7_module libexec/apache2/libphp7.so
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

11. Find `prefork` Module for PHP7 to load PHP7 by [Arch Linux Wiki Page](https://wiki.archlinux.org/index.php/Apache_HTTP_server#PHP)
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
3. Start Server like

```bash
./mysql status #check status running or not
./mysql start # start server
mysql #you will login into mariadb
```
like

```bash
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 4
Server version: 10.5.8-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]>
```
You are now loged in!
<kbd>CTRL</kbd>+<kbd>D</kbd> to exit! You can also type `exit` .
I prefer CLI :3

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
if not work

```bash
kill $(ps aux | grep '[m]ysql' | awk '{print $2}')
```
Note : If you want to stop other process change `[m]sql` to `[p]hp` if PHP! by [Easy Engine](https://easyengine.io/tutorials/linux/kill-all-processes/?amp)

and If you start again and by stopping `stop mysql` you need to run 'mysqld_safe` .
Open new session and type `mysql` for Mysql CLI.

# <a name="mysql-priv">Create MYSQL PRIVILIAGE</a>

This setup is to access database from PHP 'username'.

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