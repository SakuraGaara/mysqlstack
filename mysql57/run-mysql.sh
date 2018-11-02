#!/bin/bash
### 设置绝对路径
MYSQL57_HOME="/home/mysqlstack/mysql57"
### 初始启动，并设置默认密码
sudo -i docker run -d \
  --name mysql57 \
  -p 3000:3306 \
  -e MYSQL_ROOT_PASSWORD=root \
  -v ${MYSQL57_HOME}/conf:/etc/mysql \
  -v ${MYSQL57_HOME}/data:/var/lib/mysql \
  -v ${MYSQL57_HOME}/logs:/var/log/mysql \
  mysql:5.7.23
