# Ruby MySQL2 GEM的练习文档

今天在几篇博客上了解到MySQL支持异步获取数据，非常好奇在Ruby中如何通过异步获取的方式来提高程序的吞吐量。

## 启动一个MySQL实例

### 本地启动
```
brew install mysql
mysql_secure_installation
```
基本信息
```
host: localhost
port: 3306
username: root
password: 1qaz2wsx
```

### 使用Docker启动一个MySQL实例
```
docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d mysql:latest
```

连接 MySQL 的信息
```
host: 192.168.99.100
username: root
password: 123456
```

## 初始化 MySQL 数据
```SQL
/*

Source Server         : 192.168.99.100
Source Server Type    : MySQL
Source Server Version : 50712
Source Host           : 192.168.99.100
Source Database       : test_db

Target Server Type    : MySQL
Target Server Version : 50712
File Encoding         : utf-8

Date: 06/06/2016 22:44:34 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`name` varchar(50) DEFAULT NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', '张三'), ('2', '李四');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
```

## 参考文档

[mysql2详解](http://starzhou.com/blogs/mysql2)

[向facebook学习，通过协程实现mysql查询的异步化](http://www.bo56.com/%E9%80%9A%E8%BF%87%E5%8D%8F%E7%A8%8B%E5%AE%9E%E7%8E%B0mysql%E6%9F%A5%E8%AF%A2%E7%9A%84%E5%BC%82%E6%AD%A5%E5%8C%96/)
