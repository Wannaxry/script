create database wannacloud;
create user 'wannacry'@'localhost' identiFied by 'atistirma22';
grant all privileges on wannacloud.* to 'wannacry'@'localhost';
update user set password=PASSWORD("atistirma22") where User='root';
update user set password=PASSWORD("atistirma22") where User='wannacry';
flush privileges;
