create schema SPJModel;
use SPJModel;
create table S
(
    SNO    char(4) primary key,
    SNAME  varchar(10) unique,
    STATUS int,
    CITY   char(8)
);
create table P
(
    PNO    char(4) primary key,
    PNAME  varchar(10),
    COLOR  char(6),
    WEIGHT int
);
create table J
(
    JNO   char(4) primary key,
    JNAME varchar(10),
    CITY  char(8)
);
create table SPJ
(
    SNO char(4),
    PNO char(4),
    JNO char(4),
    QTY int,
    primary key (SNO, PNO, JNO),
    foreign key (SNO) references S (SNO),
    foreign key (PNO) references P (PNO),
    foreign key (JNO) references J (JNO)
);

insert into S
values ('S1', '精益', 20, '天津');
insert into S
values ('S2', '盛锡', 10, '北京');
insert into S
values ('S3', '东方红', 30, '北京');
insert into S
values ('S4', '丰泰盛', 20, '天津');
insert into S
values ('S5', '为民', 30, '上海');
insert into P
values ('P1', '螺母', '红', 12);
insert into P
values ('P2', '螺栓', '绿', 12);
insert into P
values ('P3', '螺丝刀', '蓝', 12);
insert into P
values ('P4', '螺丝刀', '红', 12);
insert into P
values ('P5', '凸轮', '蓝', 12);
insert into P
values ('P6', '齿轮', '红', 12);
insert into J
values ('J1', '三建', '北京');
insert into J
values ('J2', '一汽', '长春');
insert into J
values ('J3', '弹簧厂', '天津');
insert into J
values ('J4', '造船厂', '天津');
insert into J
values ('J5', '机车厂', '唐山');
insert into J
values ('J6', '无线电厂', '常州');
insert into J
values ('J7', '半导体厂', '南京');
insert into SPJ
values ('S1', 'P1', 'J1', 200);
insert into SPJ
values ('S1', 'P1', 'J3', 100);
insert into SPJ
values ('S1', 'P1', 'J4', 700);
insert into SPJ
values ('S1', 'P2', 'J2', 100);
insert into SPJ
values ('S2', 'P3', 'J1', 400);
insert into SPJ
values ('S2', 'P3', 'J2', 200);
insert into SPJ
values ('S2', 'P3', 'J3', 500);
insert into SPJ
values ('S2', 'P3', 'J4', 400);
insert into SPJ
values ('S2', 'P5', 'J1', 400);
insert into SPJ
values ('S2', 'P5', 'J2', 100);
insert into SPJ
values ('S3', 'P1', 'J1', 200);
insert into SPJ
values ('S3', 'P3', 'J1', 200);
insert into SPJ
values ('S4', 'P5', 'J1', 100);
insert into SPJ
values ('S4', 'P6', 'J3', 300);
insert into SPJ
values ('S4', 'P6', 'J4', 200);
insert into SPJ
values ('S5', 'P2', 'J4', 100);
insert into SPJ
values ('S5', 'P3', 'J1', 200);
insert into SPJ
values ('S5', 'P6', 'J2', 200);
insert into SPJ
values ('S5', 'P6', 'J4', 500);

# 1.找出所有供应商的姓名和所在城市
select SNAME 姓名, CITY 城市
from s;

# 2.找出所有零件的名称、颜色、重量
select PNAME 名称, COLOR 颜色, WEIGHT 重量
from P;

# 3.找出使用供应商s1所供应零件的工程号码
select STATUS
from s
where SNO = 'S1';

# 4.找出工程项目j2使用的各种零件的名称及其数量
select P.PNAME, SPJ.QTY
from P,
     SPJ
where JNO = 'J2';

# 5.找出上海厂商供应的所有零件号码
select SPJ.PNO
from S,
     SPJ
where S.CITY = '上海'
  and SPJ.SNO = S.SNO;

# 6.找出使用上海产的零件的工程名称
select JNAME
from j
where JNO in (select SPJ.JNO
              from s,
                   spj
              where s.CITY = '上海'
                and spj.SNO = s.SNO);

# 7.找出没有使用天津产的零件的工程号码
select jno
from spj
where not exists(select distinct JNO
                 from S,
                      SPJ
                 where s.CITY = '天津'
                   and spj.SNO = s.SNO);
