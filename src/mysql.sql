-- 1-4建表
/*
product_id:商品编号
product_name:商品名称
product_type:商品种类
sale_price:销售单价
purchase_price:进货单价
regist_date:登记日期
 */
create table Product(
        product_id char(4) not null primary key,
        product_name varchar(100) not null,
        product_type varchar(100) not null,
        sale_price int,
        purchase_price int,
        regist_date date
     );


-- 1-5更新表结构
alter table Product add column product_name_pinyin varchar(20);     --添加表结构
alter table Product drop column product_name_pinyin;                --删除表结构
--添加数据
start transaction;
insert into Product values('0001','T恤衫','衣服',1000,500,'2009-09-20');
insert into Product values('0002','打孔器','办公用品',500,320,'2009-09-11');
insert into Product values('0003','运动T恤','衣服',4000,2800,null);
insert into Product values('0004','菜刀','厨房用具',3000,2800,'2009-09-20');
insert into Product values('0005','高压锅','厨房用具',6800,5000,'2009-01-15');
insert into Product values('0006','叉子','厨房用具',500,null,'2009-09-20');
insert into Product values('0007','擦菜板','厨房用具',880,790,'2008-04-28');
insert into Product values('0008','圆珠笔','办公用品',100,null,'2009-11-11');
commit;

-- 2-1查询基础     -as、distinct、where
select product_id,product_name,purchase_price from Product;          --查询指定列
select * from Product;                                               --查询所有列
select product_id as id,product_name as name from Product;           --为列指定别名
select product_id as '编号',product_name as '商品名称' from Product;
select distinct product_type from Product;                           --从结果中删除重复行
select product_name from Product where product_type = '衣服';         --根据where子句指定查询条件

-- 2-2算数运算符和比较运算符       -not
select product_name , sale_price,purchase_price,sale_price - purchase_price as '利润' from Product;
select product_name ,sale_price from Product where sale_price > 500;
select product_name from Product where purchase_price is null;                  --查询值为null的字段
select product_name from Product where purchase_price is not null;              --查询值不为null的字段

-- 2-3逻辑运算符             -not、and、or
--not   用来否定某一条件
select product_name,product_type,sale_price from Product where not sale_price >= 1000;                     --查询值<1000
--and/or
select product_name,purchase_price from Product where product_type = '厨房用具' and sale_price >= 3000;     --两侧条件都需成立
select product_name,purchase_price from Product where product_type = '厨房用具' or sale_price >= 3000;      --一侧条件成立即可
select product_name,product_type,regist_date from Product where product_type = '办公用品'
and (regist_date ='2009-09-11' or regist_date = '2009-09-20');                   -- and运算符优先于or,所以需要通过括号强化处理

--查询销售单价打九折之后利润高于100元打办公用品和厨房用具,并在结果中打印折后利润
select product_name , product_type,(sale_price * 0.9) - purchase_price as "折后利润" from Product  where (product_type = '
办公用品' or  product_type = '厨房用具' )and ((sale_price * 0.9) - purchase_price > 100);


-- 3-1聚合查询
select count(*) from Product;                       --查询全部数据行数
select count(distinct product_type) from Product;   --聚合函数删除重复值
select count(purchase_price) from Product;          --查询该字段除null外的行数
select sum(sale_price) from Product;                --查询销售单价的合计值
select avg(sale_price) from Product;                --查询该字段的平均值，注意如果有null的话会排除掉null的列再计算。
select max(sale_price),min(sale_price) from Product;--查询最大值最小值


-- 3-2对表进行分组
select product_type,count(*) from Product group by product_type;            --查询各个商品种类的商品数量
select purchase_price ,count(*) from Product where product_type = '衣服' group by purchase_price;
     --结合where子句一起使用的时候会现根据where子句对记录进行过滤，然后再进行分组处理
     --此时sql的执行顺序为: from -> where -> group by -> select
























