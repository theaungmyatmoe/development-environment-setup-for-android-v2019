# PHP Setup In Linux
 This is set up guide for WEB DEVELOPEMENT!
 
# Platforms
- Android (Using Termux Application)
- Ubuntu 20 LTS

# Andriod Platform

 Install Termux From Google Play Store or F-Droid first.
 
1. Fresher Installtion

```bash
apt update && apt upgrade -y
```

2. Upgrade All Packages

```bash
pkg up

```
3. Install PHP

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
``

and Uncomment it

```conf
LoadModule mpm_prefork_module libexec/apache2/mod_mpm_prefork.so
```
