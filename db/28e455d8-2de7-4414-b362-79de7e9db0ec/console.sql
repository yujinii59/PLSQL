SELECT T1.PROJECT_CD
	 , T1.SALES_MGMT_VRSN_ID
     , T1.SALES_MGMT_CD
     , T5.SALES_MGMT_NM
     , T1.ITEM_CD
     , T3.ITEM_NM
     , T1.DEL_YN
     , T1.USE_YN
     , T1.USER_CD
	 , T6.USER_NM
     , T1.DESCR
     , T1.CREATE_USER_CD
     , T1.CREATE_DATE
     , T1.MODIFY_USER_CD
     , T1.MODIFY_DATE
  FROM M4S_I204050 T1
  JOIN M4S_I204010 T2
    ON T1.PROJECT_CD         = T2.PROJECT_CD
   AND T1.SALES_MGMT_VRSN_ID = T2.SALES_MGMT_VRSN_ID
  JOIN M4S_I002040 T3 -- 제품관리
    ON T1.PROJECT_CD = T3.PROJECT_CD
   AND T1.ITEM_CD    = T3.ITEM_CD
  JOIN M4S_I204030 T5 -- SALES HIERARCHY 
    ON T1.SALES_MGMT_CD = T5.SALES_MGMT_CD 
   AND T1.PROJECT_CD = T5.PROJECT_CD
   AND T1.SALES_MGMT_VRSN_ID = T5.SALES_MGMT_VRSN_ID
  LEFT OUTER JOIN M4S_I002020 T6
    ON T1.USER_CD = T6.USER_CD
 WHERE 1=1 
   AND T2.USE_YN = 'Y'
   AND T1.PROJECT_CD = 'ENT001'
   AND T1.SALES_MGMT_VRSN_ID = '202109_V0'
   --AND T5.PARENT_SALES_MGMT_CD IN (@:VS_CB_SP1_C_CD)
   --AND T1.ITEM_CD IN (@:VS_CB_ITEM_CD)
   -- AND (T1.ITEM_CD LIKE '%'||:VS_ITEM_CD||'%' OR T3.ITEM_NM LIKE '%'||:VS_ITEM_CD||'%')
   -- AND (T1.SALES_MGMT_CD LIKE '%'||:VS_SALES_MGMT_CD||'%' OR T5.SALES_MGMT_NM LIKE '%'||:VS_SALES_MGMT_CD||'%')
   --AND (T1.USER_CD LIKE '%'+@:VS_USER+'%' OR T6.USER_NM LIKE '%'+@:VS_USER+'%')
   --AND T1.USE_YN = @:VS_CB_USE_YN