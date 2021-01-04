# Setup WEB Dev Environment in Android

> This thread will use TERMUX application.

**Author** - [Aung Myat Moe](https://github.com/amm834)

# Requitrments

- Android Phone
- Good understand in basic Linux /Unix commmands

# Contents

- Download Termux
- Basic Installation
- Setup
-

# Download Termux

Download **Termux** app via Google Play or Other App Stores.

Via Google Play

https://play.google.com/store/apps/details?id=com.termux

**Note** Your Android version should have at least 7.0.

# Basic Installation

```bash
pkg upgrade && pkg update -y
```

# Install ZSH Shell with OhMyZSH Themes

```bash
pkg install zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
When zsh ask like

Time to change your default shell to zsh:
Do you want to change your default shell to zsh? [Y/n]

```bash
Y
```
You can edit theme and others in `.zshrc` config file.
**Note** If shell is still bash?
Exist and open termux again.

**Read More**
https://wiki.termux.com/wiki/ZSH

# Setup LAMP

Install `Composer`.
(Composer is PHP dependencies manager.)
When we install `Composer` we don't need to type individual commads.

## Composer Installation

```bash
pkg install composer -y
```
When composer is installed,

```bash
php -v

PHP 8.0.0 (cli) (built: Dec 16 2020 14:01:56) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.0.0-dev, Copyright (c) Zend Technologies

composer

# Avaliable options will show you …

pkg install php-apache -y
# To install php-module for apache web server

```

**Note** if `-y` is npt working?
<kbd>Press Enter</kbd>

## Apache Web Server Installation

```bash
pkg install apache2

httpd -v #check version

```

# Apache and PHP Setup

First check `php-apache module` is installed or not.

```bash
cd $PREFIX/libexec/apache2
# Search php
grep php *
# grep: libphp.so: binary file matches
```
**Note** `$PREFIX` === `/data/data/com.termux/files/usr`

If you don't get libphp.so?
Install `pkg install php-apache` again.
If `libphp.so` file is exist,
```bash
cd $PREFIX/etc/apache2
nano httpd.conf
```
<kbd>ctrl+w</kbd>  and type `worker` and **Enter** you will find **worker** module.

```bash
LoadModule mpm_worker_module libexec/apache2/mod_mpm_worker.so
```

**Close** it.
By adding `#` at the first of `LoadModule`.

```bash
#LoadModule mpm_worker_module libexec/apache2/mod_mpm_worker.so
```
And open `mpm_prefork_module` by uncommenting.

From ->
```bash
#LoadModule mpm_prefork_module libexec/apache2/mod_mpm_prefork.so
```
to ->

```bash
LoadModule mpm_prefork_module libexec/apache2/mod_mpm_prefork.so
```

Search `Directory`
and you will found -

```bash
DocumentRoot "/data/data/com.termux/files/usr/share/apache2/default-site/htdocs" < Directory "/data/data/com.termux/files/usr/share/apache2/default-site/htdocs" >
```

I will change it to my internal storage.

```bash
DocumentRoot "/sdcard/htdocs" < Directory "/sdcard/htdocs" >
```

Search `ServerName`.
You will see like -

```bash
#ServerName www.example.com:8080
```


Change it to

```bash
ServerName 127.0.0.1:8080
```

## Test Apache Server

```bash
apachectl start
```

and go to `http://localhost:8080/` via any Browser.

Now,we will setup php module.
First we will open `rewrite rule` module.

Search `rewrite` and change it
From -
```bash
#LoadModule rewrite_module libexec/apache2/mod_rewrite.so
```
To -
```bash
LoadModule rewrite_module libexec/apache2/mod_rewrite.so
```

## Load PHP8 Module

Add followimg lines.
```bash
LoadModule php_module libexec/apache2/libphp.so
<FilesMatch \.php$> 
   SetHandler application/x-httpd-php
</FilesMatch>
<IfModule dir_module>
    DirectoryIndex index.php
</IfModule>
```

# Restart Server

When you change rules in httpd.conf file,**Restart** serber ever.

```bash
apachectl stop
apachectl start
apachectl restart
# Go Browser and test again.
```
