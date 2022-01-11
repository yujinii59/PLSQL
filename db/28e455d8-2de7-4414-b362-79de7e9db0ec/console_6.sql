SELECT * FROM M4S_O201002 WHERE DP_VRSN_ID = 'SP_2021W49.01' AND DP_PRICE > 0

SELECT * FROM M4S_O201001  WHERE DP_VRSN_ID = 'SP_2021W49.01' AND DP_PRICE > 0

select * from m4s_i204040
where SALES_MGMT_VRSN_ID = '202111_V0'
  AND SALES_MGMT_TYPE_CD = 'SP1'
--   AND LINK_SALES_MGMT_CD = '1117'
  and SUBSTRING(LINK_SALES_MGMT_CD,8,4) in ('1120','1073')
ORDER BY SUB_USER_CD

SELECT * FROM M4S_I002020

select * from m4s_i204030  where SALES_MGMT_VRSN_ID = '202111_V0' and SALES_MGMT_CD IN ('11111011033','1111','11111021065')

ssukb
'11111011033','1111','11111021065'
hyunsuk
'12191041131','1219','12191051175'
jingukang
'11131011095','1113','11131021067'
heetae213
'11151011116','1115','11151021173'
bskim
'11161011024','1116','11161021174'
kspark
'11121011018','1112','11121021066'
matrix
'11111011120','11111021073','1117'



SELECT PROJECT_CD
    , SALES_MGMT_VRSN_ID
    , LINK_SALES_MGMT_CD
    , USER_CD
FROM M4S_I204040
WHERE 1=1
AND SALES_MGMT_VRSN_ID = '202111_V0'
 AND SALES_MGMT_TYPE_CD = 'SP1'

-- UPDATE T1
SELECT T1.PROJECT_CD
    , T1.SALES_MGMT_VRSN_ID
    , T1.SALES_MGMT_CD
    , T1.ITEM_CD
    , T2.USER_CD
-- SET T1.USER_CD = T2.USER_CD
FROM M4S_I204050 T1
    , (SELECT PROJECT_CD
            , SALES_MGMT_VRSN_ID
            , LINK_SALES_MGMT_CD
            , USER_CD
        FROM M4S_I204040
        WHERE 1=1
        AND SALES_MGMT_VRSN_ID = '202111_V0'
         AND SALES_MGMT_TYPE_CD = 'SP1') T2
WHERE 1=1
    AND T1.PROJECT_CD = T2.PROJECT_CD
    AND T1.SALES_MGMT_VRSN_ID = T2.SALES_MGMT_VRSN_ID
    AND T1.SALES_MGMT_CD = T2.LINK_SALES_MGMT_CD
    AND T1.USER_CD != T2.USER_CD

UPDATE T1
-- SELECT T1.PROJECT_CD
--     , T1.DP_VRSN_ID
--     , T1.SALES_MGMT_CD
--     , T1.ITEM_CD
--     , T1.USER_CD
--     , T2.USER_CD
SET T1.USER_CD = T2.USER_CD
FROM M4S_O201001 T1
    , (
    SELECT PROJECT_CD
         , 'SP_2021W49.01' DP_VRSN_ID
         , SALES_MGMT_CD
         , ITEM_CD
         , USER_CD
    FROM M4S_I204050
    WHERE 1 = 1
      AND SALES_MGMT_VRSN_ID = '202111_V0'
      AND PROJECT_CD = 'ENT001'
    ) T2
WHERE T1.PROJECT_CD = T2.PROJECT_CD
    AND T1.DP_VRSN_ID = T2.DP_VRSN_ID
    AND T1.SALES_MGMT_CD = T2.SALES_MGMT_CD
    AND T1.ITEM_CD = T2.ITEM_CD
    AND T1.USER_CD != T2.USER_CD


SELECT * FROM M4S_O110620 where DIVISION_CD='SELL_OUT' AND CUST_GRP_CD IS NOT NULL

select DATA_VRSN_CD
     , DIVISION_CD
     , FKEY
     , TEST_VRSN_CD
     , SP1.CUST_GRP_CD
     , RSLT.CUST_GRP_NM
     , ITEM_ATTR01_NM
     , ITEM_ATTR02_NM
     , ITEM_ATTR03_NM
     , ITEM_ATTR04_NM
     , ITEM_CD
     , ITEM_NM
     , SALES
     , PRED
  FROM M4S_O110620 RSLT
  LEFT OUTER JOIN (
                   SELECT SALES_MGMT_VRSN_ID
                        , LINK_SALES_MGMT_CD AS CUST_GRP_CD
                        , LINK_SALES_MGMT_NM AS CUST_GRP_NM
                     FROM M4S_I204020
                    WHERE 1=1
                      AND SALES_MGMT_VRSN_ID = '202111_V0'
      ) SP1
  ON RSLT.CUST_GRP_NM = SP1.CUST_GRP_NM



select RST.WEEK
     , RST.YYMMDD
	 , RST.CUST_GRP_CD
	 , RST.CUST_GRP_NM
	 , RST.ITEM_ATTR01_CD
	 , RST.ITEM_ATTR01_NM
	 , RST.ITEM_ATTR02_CD
	 , RST.ITEM_ATTR02_NM
	 , RST.ITEM_ATTR03_CD
	 , RST.ITEM_ATTR03_NM
	 , RST.ITEM_ATTR04_CD
	 , RST.ITEM_ATTR04_NM
	 , RST.ITEM_CD
	 , RST.ITEM_NM
	 , ROUND(RST.RESULT_SALES,0)  AS RESULT_SALES
	 , ROUND(QTY.RST_SALES_QTY,0) AS RST_SALES_QTY
from (

	SELECT WEEK
	 , YYMMDD
	 , RESULT_SALES
	 , CUST_GRP_CD
	 , CUST_GRP_NM
	 , ITEM_ATTR01_CD
	 , ITEM_ATTR01_NM
	 , ITEM_ATTR02_CD
	 , ITEM_ATTR02_NM
	 , ITEM_ATTR03_CD
	 , ITEM_ATTR03_NM
	 , ITEM_ATTR04_CD
	 , ITEM_ATTR04_NM
	 , ITEM_CD
	 , ITEM_NM
	FROM M4S_I110400 -- 예측결과
	where  1=1
	   and PROJECT_CD = 'ENT001'
	   and DATA_VRSN_CD = :VS_CB_DATA_VRSN_CD --'20180102-20210103'
	   and CUST_GRP_CD  IN ( @:VS_CB_CUST_GRP_CD )
	   AND FKEY LIKE :VS_CB_LVL + '%'
 ) RST inner join (

  select ITEM_CD
	 , YYMMDD
     , WEEK
     , YYMM
     , YY
	 , RST_SALES_QTY
  from M4S_I002176_TEST --실적
  where SOLD_CUST_GRP_CD  IN ( @:VS_CB_CUST_GRP_CD )

 ) QTY on ( RST.WEEK = QTY.WEEK
			and RST.YYMMDD = QTY.YYMMDD
			and RST.ITEM_CD = QTY.ITEM_CD
		  )


SELECT SALES_MGMT_VRSN_ID FROM M4S_O201010 WHERE PROJECT_CD = :VS_PROJECT_CD AND PRGS_STA_CD = 'P01'


SELECT * FROM M4S_I204100