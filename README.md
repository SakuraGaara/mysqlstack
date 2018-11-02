# mysqlstack

Docker install MySQL 5.7.23 Master and Slave.

################ INSTALL MYSQL #####################

mkdir -p ./mysql57/data ./mysql57/logs ./mysql57-slave/data ./mysql57-slave/logs

sh ./mysql57/run-mysql.sh && docker logs -f mysql57

sh ./mysql57-slave/run-mysql.sh && docker logs -f mysql57-slave

## default mysql password is root.

################ SET Master and Slave  #####################

## master
GRANT REPLICATION SLAVE ON *.* TO 'slave'@'%' IDETIFIED BY 'slave';

## slave
CHANGE MASTER TO
  MASTER_HOST='hostname',
  MASTER_USER='slave',
  MASTER_PASSWORD='slave',
  MASTER_PORT=3000,
  MASTER_AUTO_POSITION=1;

START SLAVE;


################ INSTALL PLUGIN  #####################

## master
install plugin rpl_semi_sync_master soname 'semisync_master.so';

## 后续添加到配置文件
set global rpl_semi_sync_master_enabled=1;
set global rpl_semi_sync_master_timeout=1000;

## slave
install plugin rpl_semi_sync_slave soname 'semisync_slave.so';

## 后续添加到配置文件
set global rpl_semi_sync_slave_enabled=1;


