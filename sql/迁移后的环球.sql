--系统总订单量 18971
select count(*) from OcOrder

-- 不符合迁移规则的订单量 
    --不在预期时间之内的 53
 	select count(*) from OcOrder where orderCreateddate not BETWEEN  '2018-01-01 00:00:00.001' and '2020-10-31 23:59:59.999'  

    -- 有效日期内 不符合指定付款条件的 0
	select count(DISTINCT oc.orderId) from OcOrder oc
	left JOIN  OcReceipt receipt  on oc.OrderId = receipt.OrderId  
	left join PcAccount account on receipt.accountCode = account.accountCode
	WHERE account.accountName  in  ('安庆-农业-尾号7373','安阳-邮政-尾号1405','安阳-中信-尾号5411','保定-建设-尾号1949','保定-建设-尾号3500','北京-建设-尾号9353','常州-建设-尾号6103','成都-农业-尾号6268','福州-建设-尾号0027','福州-建设-尾号5348','福州-民生-尾号2732','工行汇款-黄森','工商银行-北京-尾号4517','工商银行-焦作-尾号4943','广州-建设-尾号8637','广州-交通-尾号6875','哈尔滨-建设-尾号2054','杭州-杭州-尾号8950','杭州-招商-尾号9653','合肥-交通-尾号5692','合肥-民生-尾号2096','菏泽-建设-尾号7999','衡阳-工商-尾号9013','济南-建设-尾号9838','济南-民生-尾号1122','济南-农行-尾号4603','济南-农业-尾号9637','济宁-中信-尾号9171','焦作-工行-尾号7987','焦作-建设-尾号0362','荆州-农商-尾号7063','开封-农信-尾号2624','六安-建设-尾号2190','洛阳-交通-尾号7925','南昌-中国-尾号6262','南京-中国-尾号8715','南京-中信-尾号6164','南阳-邮政-尾号9931','平顶山-工商-尾号0007','青岛-工行-尾号6830','青岛-工商-尾号1036','全国通用-易宝刷卡-培训学校','上海-建设-尾号9142','上海-民生-尾号4790','上海-农业-尾号1204','上海-中行-尾号1279','沈阳-建行-尾号0532','沈阳-交通-尾号2406','沈阳-盛京-尾号3390','石家庄-民生-尾号0037','石家庄-民生-尾号6129','石家庄-中信-尾号2265','石家庄-中信-尾号4151','苏州-工商-尾号0787','苏州-农行-尾号3024','苏州-农业-尾号0822','太原-民生-尾号8389','天津-中信-尾号1344','天津-中信-尾号3784','潍坊-招商-尾号8418','乌鲁木齐-中行-尾号5249','武汉-建行-尾号1275','武汉-农商-尾号0012','武汉-农业-尾号4678','武汉-兴业-尾号5712','西安-中信-尾号8691','西宁-工商-尾号3407','襄阳-中国-尾号5185','新乡-工商-尾号1324','新乡-建设-尾号6120','徐州-农业-尾号0703','许昌-建设-尾号6281','许昌-中原-尾号6730','阳泉-建设-尾号9026','宜昌-建设-尾号6183','榆林-中信-尾号7009','运城-工商-尾号5962','长春-建行-尾号0641','郑州-建设-尾号5173','郑州-建设-尾号6159','郑州-郑州-尾号5186','重庆-农业-尾号7248','周口-中原-尾号8641','全国通用-易宝刷卡-其它','上海-淘宝','郑州-汇付天下','郑州-工商-尾号3594','全国通用-现金','全国通用-中信卡','全国通用-农商-卓越盈佳','文盛-对公支付宝','环优盛文-客来乐-支付宝','环优-拉卡拉','环优盛文-客来乐-微信','环优-中信-尾号3814','京东-对公支付-北京','环优盛文-客来乐-支付宝','环优-拉卡拉','环优盛文-客来乐-微信','环优-中信-尾号3814','优一点-客来乐-支付宝','优一点-客来乐-微信','优一点-新大陆','优一点-民生-5150','全国通用-现金','全国通用-中信卡','全国通用-农商-卓越盈佳','全国通用-易宝刷卡-培训学校','文盛-对公支付宝','上海-淘宝','京东-对公支付-北京')
    
	--  只查询收据 也等 0 
	-- select count(DISTINCT receipt.receiptId) from OcReceipt receipt  
	-- left join PcAccount account on receipt.accountCode = account.accountCode
	-- WHERE account.accountName   in  ('安庆-农业-尾号7373','安阳-邮政-尾号1405','安阳-中信-尾号5411','保定-建设-尾号1949','保定-建设-尾号3500','北京-建设-尾号9353','常州-建设-尾号6103','成都-农业-尾号6268','福州-建设-尾号0027','福州-建设-尾号5348','福州-民生-尾号2732','工行汇款-黄森','工商银行-北京-尾号4517','工商银行-焦作-尾号4943','广州-建设-尾号8637','广州-交通-尾号6875','哈尔滨-建设-尾号2054','杭州-杭州-尾号8950','杭州-招商-尾号9653','合肥-交通-尾号5692','合肥-民生-尾号2096','菏泽-建设-尾号7999','衡阳-工商-尾号9013','济南-建设-尾号9838','济南-民生-尾号1122','济南-农行-尾号4603','济南-农业-尾号9637','济宁-中信-尾号9171','焦作-工行-尾号7987','焦作-建设-尾号0362','荆州-农商-尾号7063','开封-农信-尾号2624','六安-建设-尾号2190','洛阳-交通-尾号7925','南昌-中国-尾号6262','南京-中国-尾号8715','南京-中信-尾号6164','南阳-邮政-尾号9931','平顶山-工商-尾号0007','青岛-工行-尾号6830','青岛-工商-尾号1036','全国通用-易宝刷卡-培训学校','上海-建设-尾号9142','上海-民生-尾号4790','上海-农业-尾号1204','上海-中行-尾号1279','沈阳-建行-尾号0532','沈阳-交通-尾号2406','沈阳-盛京-尾号3390','石家庄-民生-尾号0037','石家庄-民生-尾号6129','石家庄-中信-尾号2265','石家庄-中信-尾号4151','苏州-工商-尾号0787','苏州-农行-尾号3024','苏州-农业-尾号0822','太原-民生-尾号8389','天津-中信-尾号1344','天津-中信-尾号3784','潍坊-招商-尾号8418','乌鲁木齐-中行-尾号5249','武汉-建行-尾号1275','武汉-农商-尾号0012','武汉-农业-尾号4678','武汉-兴业-尾号5712','西安-中信-尾号8691','西宁-工商-尾号3407','襄阳-中国-尾号5185','新乡-工商-尾号1324','新乡-建设-尾号6120','徐州-农业-尾号0703','许昌-建设-尾号6281','许昌-中原-尾号6730','阳泉-建设-尾号9026','宜昌-建设-尾号6183','榆林-中信-尾号7009','运城-工商-尾号5962','长春-建行-尾号0641','郑州-建设-尾号5173','郑州-建设-尾号6159','郑州-郑州-尾号5186','重庆-农业-尾号7248','周口-中原-尾号8641','全国通用-易宝刷卡-其它','上海-淘宝','郑州-汇付天下','郑州-工商-尾号3594','全国通用-现金','全国通用-中信卡','全国通用-农商-卓越盈佳','文盛-对公支付宝','环优盛文-客来乐-支付宝','环优-拉卡拉','环优盛文-客来乐-微信','环优-中信-尾号3814','京东-对公支付-北京','环优盛文-客来乐-支付宝','环优-拉卡拉','环优盛文-客来乐-微信','环优-中信-尾号3814','优一点-客来乐-支付宝','优一点-客来乐-微信','优一点-新大陆','优一点-民生-5150','全国通用-现金','全国通用-中信卡','全国通用-农商-卓越盈佳','全国通用-易宝刷卡-培训学校','文盛-对公支付宝','上海-淘宝','京东-对公支付-北京')
 
	-- 符合迁移规则的订单量,不符合迁移订单类型的  0
	
	-- GEN:正常;REP:重读;TRA:转让;CHA:转班;REF:退费DEF:顺延;GIV:赠课
	SELECT  count(DISTINCT orderId) from OcClassorder where coType not in ('GEN','REP','TRA','CHA','REF','GIV')

-- 各分校总量
	SELECT s.schoolName ,count(DISTINCT oc.orderId) num from OcOrder oc 
	LEFT JOIN OcClassorder c on oc.orderId = c.orderId  
	LEFT join BdSchool s on c.coOwnerschoolid = s.schoolId
	GROUP BY s.schoolName 
	ORDER BY num desc

	-- 和 18971
	SELECT sum(num) from (
	SELECT s.schoolName ,count(DISTINCT oc.orderId) num from OcOrder oc 
	LEFT JOIN OcClassorder c on oc.orderId = c.orderId  
	LEFT join BdSchool s on c.coOwnerschoolid = s.schoolId
	GROUP BY s.schoolName 
	) a
-- 北京医药	4577
-- 郑州	2141
-- 济南	1921
-- 石家庄	1762
-- 广州	939
-- 重庆	852
-- 上海	825
-- 南京	777
-- 杭州	582
-- 苏州	443
-- 徐州	440
-- 沈阳	430
-- 青岛	389
-- 成都	368
-- 南宁	327
-- 洛阳	227
-- 长春	227
-- 武汉	221
-- 攀枝花	192
-- 福州	174
-- 北京工程	166
-- 合肥	142
-- 长沙	112
-- 天津	104
-- 万州	104
-- 衡阳	96
-- 保定	95
-- 六安	69
-- 南昌	30
-- 总部	22
-- 西安	21
-- 太原	16
-- 南充	15
-- 荆门	13
-- 珠海	12
-- 南阳	11
-- 哈尔滨	10
-- 无锡	8
-- 新乡	7
-- 邯郸	7
-- 唐山	6
-- 开封	6
-- 常州	5
-- 锦州	5
-- 焦作	5
-- 黄冈	5
-- 驻马店	4
-- 厦门	4
-- 漳州	4
-- 大同	4
-- 图书事业部	3
-- Crm4测试分校	3
-- 安庆	3
-- 宁波	3
-- 兰州	3
-- 南通	2
-- 阳泉	2
-- 四平	2
-- 大庆	2
-- 惠州	2
-- 金华	2
-- 安阳	2
-- 菏泽	1
-- 漯河	1
-- 秦皇岛	1
-- 廊坊	1
-- 临沂	1
-- 吴忠	1
-- bj测试分校	1
-- 襄阳	1
-- 张家口	1
-- 荆州	1
-- 淮安	1
-- 长治	1
-- 衡水	1
-- 呼和浩特	1
-- 昆明	1
-- 泉州	1
-- 泰州	1
-- 温州	1
-- 银川	1
-- 泸州	1

-- 各分校 符合 迁移规则总量 18916

	SELECT s.schoolName ,count(DISTINCT oc.orderId) num from OcOrder oc 
	LEFT JOIN OcClassorder c on oc.orderId = c.orderId  
	LEFT join BdSchool s on c.coOwnerschoolid = s.schoolId
	where oc.orderCreateddate BETWEEN  '2018-01-01 00:00:00.001' and '2020-10-31 23:59:59.999'  
	and c.coType  in ('GEN','REP','TRA','CHA','REF','GIV')
	GROUP BY s.schoolName 
	ORDER BY num desc

	-- 求和 18916
	SELECT sum(num) from (
	SELECT s.schoolName ,count(DISTINCT oc.orderId) num from OcOrder oc 
	LEFT JOIN OcClassorder c on oc.orderId = c.orderId  
	LEFT join BdSchool s on c.coOwnerschoolid = s.schoolId
	where oc.orderCreateddate BETWEEN  '2018-01-01 00:00:00.001' and '2020-10-31 23:59:59.999'  
	and c.coType  in ('GEN','REP','TRA','CHA','REF','GIV')
	GROUP BY s.schoolName 
	) a
-- 北京医药	4539
-- 郑州	2140
-- 济南	1917
-- 石家庄	1762
-- 广州	936
-- 重庆	851
-- 上海	824
-- 南京	776
-- 杭州	581
-- 苏州	443
-- 徐州	440
-- 沈阳	429
-- 青岛	389
-- 成都	368
-- 南宁	326
-- 洛阳	227
-- 长春	225
-- 武汉	221
-- 攀枝花	192
-- 福州	174
-- 北京工程	166
-- 合肥	141
-- 长沙	112
-- 万州	104
-- 天津	104
-- 衡阳	96
-- 保定	95
-- 六安	69
-- 南昌	30
-- 总部	22
-- 西安	21
-- 太原	16
-- 南充	15
-- 荆门	13
-- 珠海	12
-- 南阳	11
-- 哈尔滨	10
-- 无锡	8
-- 新乡	7
-- 邯郸	7
-- 唐山	6
-- 开封	6
-- 黄冈	5
-- 焦作	5
-- 锦州	5
-- 常州	5
-- 大同	4
-- 厦门	4
-- 驻马店	4
-- 漳州	4
-- 图书事业部	3
-- 兰州	3
-- Crm4测试分校	3
-- 安庆	3
-- 宁波	3
-- 安阳	2
-- 四平	2
-- 阳泉	2
-- 大庆	2
-- 金华	2
-- 惠州	2
-- 南通	2
-- 长治	1
-- 菏泽	1
-- 昆明	1
-- 淮安	1
-- 温州	1
-- 泉州	1
-- 泰州	1
-- 衡水	1
-- 呼和浩特	1
-- 秦皇岛	1
-- 吴忠	1
-- 廊坊	1
-- 临沂	1
-- 漯河	1
-- 襄阳	1
-- 张家口	1
-- 泸州	1
-- bj测试分校	1
-- 荆州	1
-- 银川	1


-- 各分校 不符合 迁移规则

-- 各分校，有效时间内,不符合迁移订单类型的  
	SELECT s.schoolName ,count(DISTINCT oc.orderId) num from OcOrder oc 
	LEFT JOIN OcClassorder c on oc.orderId = c.orderId  
	LEFT join BdSchool s on c.coOwnerschoolid = s.schoolId
	where oc.orderCreateddate BETWEEN  '2018-01-01 00:00:00.001' and '2020-10-31 23:59:59.999'  
	and c.coType  not in ('GEN','REP','TRA','CHA','REF','GIV')
	GROUP BY s.schoolName 
	ORDER BY num desc
	-- 长春	2
	
-- 有效日期内不符付款条件的 0

	select s.schoolName,count(DISTINCT oc.orderId) from OcOrder oc
	left JOIN  OcReceipt receipt  on oc.OrderId = receipt.OrderId  
	left join PcAccount account on receipt.accountCode = account.accountCode
	LEFT JOIN OcClassorder c on oc.orderId = c.orderId  
	LEFT join BdSchool s on c.coOwnerschoolid = s.schoolId
	WHERE account.accountName  in  ('安庆-农业-尾号7373','安阳-邮政-尾号1405','安阳-中信-尾号5411','保定-建设-尾号1949','保定-建设-尾号3500','北京-建设-尾号9353','常州-建设-尾号6103','成都-农业-尾号6268','福州-建设-尾号0027','福州-建设-尾号5348','福州-民生-尾号2732','工行汇款-黄森','工商银行-北京-尾号4517','工商银行-焦作-尾号4943','广州-建设-尾号8637','广州-交通-尾号6875','哈尔滨-建设-尾号2054','杭州-杭州-尾号8950','杭州-招商-尾号9653','合肥-交通-尾号5692','合肥-民生-尾号2096','菏泽-建设-尾号7999','衡阳-工商-尾号9013','济南-建设-尾号9838','济南-民生-尾号1122','济南-农行-尾号4603','济南-农业-尾号9637','济宁-中信-尾号9171','焦作-工行-尾号7987','焦作-建设-尾号0362','荆州-农商-尾号7063','开封-农信-尾号2624','六安-建设-尾号2190','洛阳-交通-尾号7925','南昌-中国-尾号6262','南京-中国-尾号8715','南京-中信-尾号6164','南阳-邮政-尾号9931','平顶山-工商-尾号0007','青岛-工行-尾号6830','青岛-工商-尾号1036','全国通用-易宝刷卡-培训学校','上海-建设-尾号9142','上海-民生-尾号4790','上海-农业-尾号1204','上海-中行-尾号1279','沈阳-建行-尾号0532','沈阳-交通-尾号2406','沈阳-盛京-尾号3390','石家庄-民生-尾号0037','石家庄-民生-尾号6129','石家庄-中信-尾号2265','石家庄-中信-尾号4151','苏州-工商-尾号0787','苏州-农行-尾号3024','苏州-农业-尾号0822','太原-民生-尾号8389','天津-中信-尾号1344','天津-中信-尾号3784','潍坊-招商-尾号8418','乌鲁木齐-中行-尾号5249','武汉-建行-尾号1275','武汉-农商-尾号0012','武汉-农业-尾号4678','武汉-兴业-尾号5712','西安-中信-尾号8691','西宁-工商-尾号3407','襄阳-中国-尾号5185','新乡-工商-尾号1324','新乡-建设-尾号6120','徐州-农业-尾号0703','许昌-建设-尾号6281','许昌-中原-尾号6730','阳泉-建设-尾号9026','宜昌-建设-尾号6183','榆林-中信-尾号7009','运城-工商-尾号5962','长春-建行-尾号0641','郑州-建设-尾号5173','郑州-建设-尾号6159','郑州-郑州-尾号5186','重庆-农业-尾号7248','周口-中原-尾号8641','全国通用-易宝刷卡-其它','上海-淘宝','郑州-汇付天下','郑州-工商-尾号3594','全国通用-现金','全国通用-中信卡','全国通用-农商-卓越盈佳','文盛-对公支付宝','环优盛文-客来乐-支付宝','环优-拉卡拉','环优盛文-客来乐-微信','环优-中信-尾号3814','京东-对公支付-北京','环优盛文-客来乐-支付宝','环优-拉卡拉','环优盛文-客来乐-微信','环优-中信-尾号3814','优一点-客来乐-支付宝','优一点-客来乐-微信','优一点-新大陆','优一点-民生-5150','全国通用-现金','全国通用-中信卡','全国通用-农商-卓越盈佳','全国通用-易宝刷卡-培训学校','文盛-对公支付宝','上海-淘宝','京东-对公支付-北京')
    GROUP BY s.schoolName 

-- 各分校 无效日期所有的
	SELECT s.schoolName ,count(DISTINCT oc.orderId) num from OcOrder oc 
	LEFT JOIN OcClassorder c on oc.orderId = c.orderId  
	LEFT join BdSchool s on c.coOwnerschoolid = s.schoolId
	where oc.orderCreateddate not BETWEEN  '2018-01-01 00:00:00.001' and '2020-10-31 23:59:59.999'  
	GROUP BY s.schoolName 
	ORDER BY num desc
	-- 求和 53
	SELECT sum(num) from (
	SELECT s.schoolName ,count(DISTINCT oc.orderId) num from OcOrder oc 
	LEFT JOIN OcClassorder c on oc.orderId = c.orderId  
	LEFT join BdSchool s on c.coOwnerschoolid = s.schoolId
	where oc.orderCreateddate not BETWEEN  '2018-01-01 00:00:00.001' and '2020-10-31 23:59:59.999'  
	GROUP BY s.schoolName 
	) a
-- 北京医药	38
-- 济南	4
-- 广州	3
-- 杭州	1
-- 合肥	1
-- 南京	1
-- 南宁	1
-- 上海	1
-- 沈阳	1
-- 郑州	1
-- 重庆	1

-- GEN:正常;REP:重读;TRA:转让;CHA:转班;REF:退费DEF:顺延;GIV:赠课
-- 正常订单总量   15862
		SELECT  count(DISTINCT orderId) from OcClassorder where coType in ('GEN')
-- 正常订单覆盖的班级数量  转移后无班级
-- 正常订单收据数量  16433
	SELECT count(DISTINCT r.receiptId) from OcOrder o
	LEFT JOIN OcClassorder class on o.orderId = class.orderId
	LEFT JOIN OcReceipt r on class.orderId = r.orderId
	where class.coType in ('GEN')

-- 重读总量   1084
	SELECT  count(DISTINCT orderId) from OcClassorder where coType in ('REP')


-- 重读订单覆盖的班级数量  转移后无班级
-- 重读订单收据数量  2532

	SELECT count(DISTINCT r.receiptId) from OcOrder o
	LEFT JOIN OcClassorder class on o.orderId = class.orderId
	LEFT JOIN OcReceipt r on class.orderId = r.orderId
	where class.coType in ('REP')

-- 转班/转让总量   738
 
	SELECT  count(DISTINCT orderId) from OcClassorder where coType in ('TRA','CHA')
-- 转班/转让订单覆盖的班级数量  转移后无班级
-- 转班/转让订单收据数量  2080
	SELECT count(DISTINCT r.receiptId) from OcOrder o
	LEFT JOIN OcClassorder class on o.orderId = class.orderId
	LEFT JOIN OcReceipt r on class.orderId = r.orderId
	where class.coType in ('TRA','CHA')








各个类型覆盖的班级数量
-- GEN:正常;REP:重读;TRA:转让;CHA:转班;REF:退费DEF:顺延;GIV:赠课
select count(DISTINCT i.skuName)正常 from OcOrder oc 
LEFT JOIN OcOrderitem i on oc.orderId = i.orderId
LEFT JOIN OcClassorder class on i.orderId = class.orderId
where class.coType  = 'GEN' ;

select count(DISTINCT i.skuName)重读 from OcOrder oc 
LEFT JOIN OcOrderitem i on oc.orderId = i.orderId
LEFT JOIN OcClassorder class on i.orderId = class.orderId
where class.coType  = 'REP' ;

select count(DISTINCT i.skuName)'转让/转班' from OcOrder oc 
LEFT JOIN OcOrderitem i on oc.orderId = i.orderId
LEFT JOIN OcClassorder class on i.orderId = class.orderId
where class.coType  in ('TRA','CHA') ;

select count(DISTINCT i.skuName) 退费 from OcOrder oc 
LEFT JOIN OcOrderitem i on oc.orderId = i.orderId
LEFT JOIN OcClassorder class on i.orderId = class.orderId
where class.coType  = 'REF' ;

select count(DISTINCT i.skuName) 赠课 from OcOrder oc 
LEFT JOIN OcOrderitem i on oc.orderId = i.orderId
LEFT JOIN OcClassorder class on i.orderId = class.orderId
where class.coType  = 'GIV' ;