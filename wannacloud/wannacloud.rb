#!/usr/bin/env ruby
# a: Se realiza la instalación completa del script
all = ARGV[0].to_s

if all != "a"  
  puts "Use la claves secretas" 
  exit
end

ok = []
ok << system("apt-get update > /dev/null")
ok << system("apt-get upgrade -y > /dev/null")

puts "[INFO] update checking..."
ok.each_with_index do |state, index|
  if not state
    puts "[ERROR] update step #{index}!!!"
    exit 
  end
end
puts "[INFO] update ok"

ok = []
ok << system("apt-get install mysql-server -y > /dev/null")
ok << system("mysql < database.sql > /dev/null ")
ok << system("service mysql restart > /dev/null ")

puts "[INFO] mysql checking..."
ok.each_with_index do |state, index|
  if not state
    puts "[ERROR] mysql step #{index}!!!"
    exit 
  end
end
puts "[INFO] mysql ok"

ok = []
ok << system("apt-get install -y nginx > /dev/null")
ok << system("wget -q https://download.nextcloud.com/server/releases/latest.zip")
ok << system("unzip latest.zip > /dev/null ")
ok << system("mv nextcloud /usr/share/ > /dev/null ")
ok << system("rm latest.zip > /dev/null ")
ok << system("rm /var/www/html/index.nginx-debian.html")

puts "[INFO] Nginx checking..."
ok.each_with_index do |state, index|
  if not state
    puts "[ERROR] Nginx step #{index}!!!"
    exit 
  end
end
puts "[INFO] nginx ok"

ok = []
ok << system("apt-get install -y php7.0 php7.0-bz2 php7.0-cli php7.0-curl php7.0-gd php7.0-fpm php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php-pear php7.0-imap php-memcache php7.0-pspell php7.0-recode php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-mysql php7.0-opcache php7.0-xml php7.0-zip php-imagick php-redis libapache2-mod-php7.0 > /dev/null")

puts "[INFO] php checking..."
ok.each_with_index do |state, index|
  if not state
    puts "[ERROR] php step #{index}!!!"
    exit 
  end
end
puts "[INFO] php ok"

ok = []
ok << system("service apache2 stop > /dev/null")

ok << system("apt-get purge -y apache2* > /dev/null") 

ok << system("apt-get autoremove -y > /dev/null") 

ok << system("rm -Rf /etc/apache2 /usr/lib/apache2 /usr/include/apache2 > /dev/null")

puts "[INFO] rmapache checking..."
ok.each_with_index do |state, index|
  if not state
    puts "[ERROR] rmapache step #{index}!!!"
    exit 
  end
end
puts "[INFO] rmapache ok"

ok = []
ok << system("mkdir /usr/share/nextcloud/data")
ok << system("rm /etc/nginx/sites-available/default > /dev/null") 
ok << system("rm /etc/nginx/sites-enabled/default > /dev/null")
ok << system("sh permisos.sh")
puts "[INFO] nginx2 checking..."
ok.each_with_index do |state, index|
  if not state
    puts "[ERROR] nginx2 step #{index}!!!"
    exit 
  end
end
puts "[INFO] nginx2 ok"

ok = []
ok << system("mv nextcloud.conf /etc/nginx/sites-available/ > /dev/null")
ok << system("ln -s /etc/nginx/sites-available/nextcloud.conf /etc/nginx/sites-enabled/ > /dev/null") 
ok << system("systemctl reload nginx > /dev/null") 
puts "[INFO] servicio nginx checking..."
ok.each_with_index do |state, index|
  if not state
    puts "[ERROR] servicio nginx step #{index}!!!"
    exit 
  end
end
puts "[INFO] servicio nginx ok"
