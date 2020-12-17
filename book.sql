CREATE DATABASE book;

USE book;


# 管理员信息
CREATE TABLE administrator(
id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键自增',
username VARCHAR(20) NOT NULL UNIQUE COMMENT  '用户名',
PASSWORD VARCHAR(50) NOT NULL COMMENT '密码',
salt VARCHAR(255) NOT NULL COMMENT '随机盐',
create_date DATETIME NOT NULL COMMENT '创建的日期',
rid INT COMMENT '角色id',
CONSTRAINT fk_administrator_id FOREIGN KEY(rid) REFERENCES role(id)
)ENGINE=INNODB  DEFAULT CHARSET=utf8;



# 管理员担当的角色
CREATE TABLE role(
id INT PRIMARY KEY COMMENT '主键自增',
NAME VARCHAR(20) COMMENT '角色名称(admin为超级管理员，user为普通管理员)'
)ENGINE=INNODB  DEFAULT CHARSET=utf8;

SELECT * FROM role`t_user`

# 学生信息
CREATE TABLE student(
id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
`name` VARCHAR(20) NOT NULL COMMENT '学生姓名',
number INT NOT NULL UNIQUE COMMENT '学号',
grade VARCHAR(20) COMMENT '年级',
classes VARCHAR(20) COMMENT '班级',
gender INT NOT NULL COMMENT '性别'
)ENGINE=INNODB  DEFAULT CHARSET=utf8;

INSERT INTO student(NAME,number,grade,classes,gender)
VALUES('张三',2018150301,'七年级','1503',1)


# 学生借书的信息
CREATE TABLE studentBook(
id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
student_id INT  COMMENT '学生id',
book_id INT COMMENT '书籍id，表示学生借阅的图书',
borrow_book_date DATETIME COMMENT '借书日期',
return_book_date DATETIME COMMENT '还书日期',
due_date DATETIME COMMENT '待归还日期',
STATUS INT COMMENT '借书状态 0为未还 1为已还',
CONSTRAINT fk_student_sid FOREIGN KEY(student_id) REFERENCES student(id),
CONSTRAINT fk_student_book_bid FOREIGN KEY(book_id) REFERENCES bookInfo(id)
)ENGINE=INNODB  DEFAULT CHARSET=utf8;

# 图书信息
CREATE TABLE bookInfo(
id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
type_id INT NOT NULL COMMENT '类别id',
book VARCHAR(50) NOT NULL UNIQUE COMMENT '书籍名',
author VARCHAR(30) NOT NULL COMMENT '作者',
publish_time DATETIME NOT NULL COMMENT '出版时间',
`count` INT NOT NULL COMMENT '总数，当数量等于0时，代表图书都以借完',
new_time DATETIME COMMENT '入库的时间'
)ENGINE=INNODB  DEFAULT CHARSET=utf8;

# 图书种类
CREATE TABLE bookType(
id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
type_id INT NOT NULL COMMENT '类别id',
TYPE VARCHAR(30) COMMENT '类别'
)ENGINE=INNODB  DEFAULT CHARSET=utf8;


SELECT a.*,r.name FROM administrator a INNER JOIN role r ON a.rid = r.id
WHERE username = 'zhangsan'

SELECT * FROM administrator

SELECT * FROM role

SELECT * FROM student

SELECT number  FROM student

DELETE FROM student WHERE id = 22

SELECT * FROM bookInfo

SELECT * FROM borrowInfo

SELECT bi.*,bt.type FROM bookinfo bi
INNER JOIN booktype bt ON bi.type_id=bt.type_id
WHERE bi.book_name LIKE '%%' AND bt.type LIKE '%%'


SELECT s.name,s.classes,s.number,bi.id,bi.borrow_book_date,bi.return_book_date,bi.due_date,
bi.status,b.book_name,b.author,b.id AS bid
FROM student s INNER JOIN borrowInfo bi ON s.id = bi.student_id
INNER JOIN bookinfo b ON b.id = bi.book_id 
WHERE s.name LIKE "%%" AND b.book_name LIKE "%%" AND bi.status LIKE "%%"


SELECT s.name,s.classes,s.number,NOW() - bi.due_date AS overdue,
b.book_name,b.author
FROM student s INNER JOIN borrowInfo bi ON s.id = bi.student_id
INNER JOIN bookinfo b ON b.id = bi.book_id 
WHERE bi.due_date<NOW() AND bi.status = "未还"


SELECT NOW() - due_date AS due_date FROM borrowInfo WHERE due_date < NOW() AND STATUS = "未还"
