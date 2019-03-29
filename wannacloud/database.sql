create database wannacloud;
create user 'wannacry'@'localhost' identiFied by 'atistirma22';
grant all privileges on wannacloud.* to 'wannacry'@'localhost';
flush privileges;