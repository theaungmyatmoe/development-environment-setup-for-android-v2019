#!/usr/bin/env bash
# Author ~ Aung Myat Moe(@amm834)

if [[ "$#" -eq 1 ]]; then
case $1 in
 'start')
  apachectl start
  #mysqld_safe
  sh $PREFIX/etc/init.d/mysql start
  clear
  echo -e "Apache server is running at port \e[32mlocalhost:8080\e[0m.\nMariadb is running at port \e[32m3306\e[0m."
  ;;
  'stop')
  apachectl stop
  kill $(ps aux | grep '[m]ysql' | awk '{print $2}')
  echo -e "\e[32mApache and Mariadb stopped.\e[0m"
  ;;
  *)
  echo -e "You forgot \e[32mstart|stop option!\e[0m"
  ;;
esac
else
  echo -e "You forgot \e[32mstart|stop option!\e[0m"
fi

