

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`book` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `book`;

/*Table structure for table `administrator` */

DROP TABLE IF EXISTS `administrator`;

CREATE TABLE `administrator` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `PASSWORD` varchar(50) NOT NULL COMMENT '密码',
  `salt` varchar(255) NOT NULL COMMENT '随机盐',
  `create_date` datetime NOT NULL COMMENT '创建的日期',
  `rid` int(11) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_administrator_id` (`rid`),
  CONSTRAINT `fk_administrator_id` FOREIGN KEY (`rid`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

/*Data for the table `administrator` */

insert  into `administrator`(`id`,`username`,`PASSWORD`,`salt`,`create_date`,`rid`) values (1,'admin','3ac6bc7557737e04e82a216481eae0cf','054c617c','2020-11-30 11:33:09',1),(2,'zhangsan','3ac6bc7557737e04e82a216481eae0cf','054c617c','2020-12-02 11:34:06',2),(3,'lisi','c003c996bcf221cb19c363ec9be68922','cc9bfdcb','2020-12-02 15:38:58',2),(5,'wangwu','1a0b20336eea683697d32a0ab2386a62','855c889f','2020-12-02 15:56:58',2),(7,'admin2','5a475fe70d3d68c25fce846ae7b361f6','9dfdf2e5','2020-12-02 16:16:11',2),(19,'admin12','05897d3fe730850b5850e72e3ac295f7','1efe7123','2020-12-03 17:22:10',2),(23,'1231','3aab8a6640dc4c00ca0a60c86f9894c8','5fc98210','2020-12-03 17:58:20',2),(27,'admin12234','be39d619bc932e11a00e6333eafab6e0','0770f808','2020-12-03 19:02:31',2);

/*Table structure for table `bookinfo` */

DROP TABLE IF EXISTS `bookinfo`;

CREATE TABLE `bookinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type_id` int(11) NOT NULL COMMENT '类别id',
  `book_name` varchar(50) NOT NULL COMMENT '书籍名',
  `author` varchar(30) NOT NULL COMMENT '作者',
  `count` int(11) NOT NULL COMMENT '库存数量',
  `new_time` datetime NOT NULL COMMENT '添加到图书馆的时间',
  `publishing` varchar(30) NOT NULL COMMENT '出版社',
  `borrow` int(11) DEFAULT NULL COMMENT '已借数量',
  `total` int(11) DEFAULT NULL COMMENT '总数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `bookinfo` */

insert  into `bookinfo`(`id`,`type_id`,`book_name`,`author`,`count`,`new_time`,`publishing`,`borrow`,`total`) values (1,1,'张大小姐','洪晃',6,'2019-02-15 14:08:20','浙江文艺出版社',0,6),(2,1,'曲中戏','是舟',19,'2020-12-12 14:12:57','江苏凤凰文艺出版社',1,20),(8,2,'西游记','吴承恩',0,'2020-12-07 14:05:19','中华人民出版社',2,2),(10,6,'红楼梦','曹雪芹',23,'2020-12-10 14:20:59','中华人民出版社',0,23),(11,1,'先谋生，在谋爱','李筱懿',5,'2020-12-10 15:10:18','天津人民出版社',0,5),(12,1,'自在独行','贾平凹',7,'2020-12-10 15:11:05','作家侨出版社',0,7),(14,1,'山本','贾平凹',8,'2020-12-10 15:12:29','作家侨出版社',0,8),(15,1,'废都','贾平凹',14,'2020-12-10 15:13:22','作家侨出版社',0,14),(16,1,'浮躁','贾平凹',20,'2020-12-10 15:13:47','作家侨出版社',0,20),(17,1,'秦腔','贾平凹',13,'2020-12-10 15:14:15','作家侨出版社',0,13),(18,1,'爱与痛的边缘','郭敬明',15,'2020-12-10 15:14:54','东方出版社',0,15),(19,1,'谁的青春不迷茫','刘同',14,'2020-12-10 15:16:12','中信出版社',0,14),(20,1,'像狗一样奔跑','里则林',43,'2020-12-10 15:16:41','广西科学技术出版社',0,43),(21,2,'最好的年龄才刚刚开始','十二',13,'2020-12-10 15:17:04','浙江文艺出版社',0,13);

/*Table structure for table `booktype` */

DROP TABLE IF EXISTS `booktype`;

CREATE TABLE `booktype` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type_id` int(11) NOT NULL COMMENT '类别id',
  `TYPE` varchar(30) DEFAULT NULL COMMENT '类别',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `booktype` */

insert  into `booktype`(`id`,`type_id`,`TYPE`) values (1,1,'都市'),(2,2,'职场'),(3,3,'武侠'),(4,4,'魔幻'),(6,5,'军事史'),(7,6,'明间艺术');

/*Table structure for table `borrowinfo` */

DROP TABLE IF EXISTS `borrowinfo`;

CREATE TABLE `borrowinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `student_id` int(11) DEFAULT NULL COMMENT '学生id',
  `book_id` int(11) DEFAULT NULL COMMENT '书籍id，表示学生借阅的图书',
  `borrow_book_date` datetime DEFAULT NULL COMMENT '借书日期',
  `return_book_date` datetime DEFAULT NULL COMMENT '还书日期',
  `due_date` datetime DEFAULT NULL COMMENT '待归还日期',
  `STATUS` char(4) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `fk_student_sid` (`student_id`),
  KEY `fk_student_book_bid` (`book_id`),
  CONSTRAINT `fk_student_book_bid` FOREIGN KEY (`book_id`) REFERENCES `bookinfo` (`id`),
  CONSTRAINT `fk_student_sid` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `borrowinfo` */

insert  into `borrowinfo`(`id`,`student_id`,`book_id`,`borrow_book_date`,`return_book_date`,`due_date`,`STATUS`) values (4,9,8,'2020-12-07 16:11:44','2020-12-08 10:22:38','2020-12-10 17:16:00','已还'),(5,9,2,'2020-12-07 17:20:14','2020-12-09 17:06:14','2020-12-09 17:19:00','已还'),(6,14,2,'2020-12-08 08:41:18','2020-12-08 10:21:27','2020-12-12 08:41:00','已还'),(7,9,8,'2020-12-09 17:05:30','2020-12-09 17:05:47','2020-12-09 17:05:00','已还'),(8,9,8,'2020-12-09 17:06:31','2020-12-09 21:32:24','2020-12-09 17:06:00','已还'),(9,9,8,'2020-12-09 21:23:51',NULL,'2020-12-09 21:23:00','未还'),(10,9,8,'2020-12-10 14:28:09',NULL,'2020-12-12 14:28:00','未还'),(11,9,2,'2020-12-10 11:28:00',NULL,'2020-12-12 11:27:00','未还');

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) NOT NULL COMMENT '主键自增',
  `NAME` varchar(20) DEFAULT NULL COMMENT '角色名称(admin为超级管理员，user为普通管理员)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`id`,`NAME`) values (1,'admin'),(2,'user');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) NOT NULL COMMENT '学生姓名',
  `number` varchar(20) NOT NULL COMMENT '学号',
  `grade` varchar(20) DEFAULT NULL COMMENT '年级',
  `classes` varchar(20) DEFAULT NULL COMMENT '班级',
  `gender` int(11) NOT NULL COMMENT '性别(1为男，0为女)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `student` */

insert  into `student`(`id`,`name`,`number`,`grade`,`classes`,`gender`) values (3,'李四','2018180102','八年级','1401',1),(9,'张三','2018140102','七年级','1401',1),(12,'王五','2018180304','七年级','1401',1),(13,'张三','2018180305','七年级','1404',1),(14,'大傻','2018180390','九年级','1901',2),(18,'孙二逼','2018180310','八年级','1806',1),(19,'张三','2018180389','七年级','1401',1),(21,'张三','2018140105','七年级','1401',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
