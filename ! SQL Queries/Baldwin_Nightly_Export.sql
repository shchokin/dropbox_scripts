select   GETDATE()  

SELECT * from VANGUARD.TENANT where tenant_id = 84

select * from VANGUARD.dept where dept_id = 1

select * from [VANGUARD].[TENANT_DEPT] where tenant_id = 84 AND dept_id = 1
--update 'td_to_date' to 'CurrentDate' without time
--update [VANGUARD].[TENANT_DEPT] set td_to_date = CAST(GETDATE() AS Date) where dept_id = 1 and tenant_id = 84



select * from VANGUARD.SCHEDULE_JOB  where TENANT_ID=84 and  SCHEDULE_JOB_CODE like'%NightlyDept1%'
--UPDATE VANGUARD.SCHEDULE_JOB SET IS_CANCELED=0 where TENANT_ID=84 and  SCHEDULE_JOB_CODE like '%NightlyDept1%'
--update VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE= DATEADD(SECOND,2,GETDATE()) where TENANT_ID=84 and SCHEDULE_JOB_CODE like'%NightlyDept1%'

DECLARE @YesterdayDate datetime = DATEADD(d, DATEDIFF(d, 0, GETDATE()) - 1, 0)
--SELECT @YesterdayDate AS YesterdayDate
--update 'ExportDate' to 'PreviousDate' with time 00:00:00.000
--update 'ReCaptureExportDate' to 'CurrentDate' with time 00:00:00.000

UPDATE VANGUARD.SCHEDULE_JOB
   SET PREVIOUS_EXECUTE_RESULT ='<NightlyExportResult>
   <ExportDate>' + CONVERT(varchar(23), @YesterdayDate, 121) + '</ExportDate>
   <PendingDocTypes />
   <CompletedDocTypes />
   <Status>Finished</Status>
   <ReCaptureExportDate>' + CONVERT(VARCHAR(20), CAST(CAST(GETDATE() AS DATE) AS DATETIME), 120) + '</ReCaptureExportDate>
   </NightlyExportResult>'
   WHERE SCHEDULE_JOB_ID=28717

------------------------------

select top 10 * from VANGUARD.SCHEDULE_JOB_HISTORY where schedule_job_id = 28708 order by schedule_job_history_id desc

------------------------------

select * from VANGUARD.SCHEDULE_JOB  where TENANT_ID=84 and  is_canceled = 0

select * from VANGUARD.SCHEDULE_JOB  where TENANT_ID=84 and  SCHEDULE_JOB_CODE like '%OrderItemContentExport%'
UPDATE VANGUARD.SCHEDULE_JOB SET IS_CANCELED=0 where TENANT_ID=84 and SCHEDULE_JOB_CODE like '%OrderItemContentExport%'
update VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE= DATEADD(SECOND,2,GETDATE()) where TENANT_ID=84 and SCHEDULE_JOB_CODE like '%OrderItemContentExport%'

select * from VANGUARD.SCHEDULE_JOB  where TENANT_ID=84 and  SCHEDULE_JOB_CODE like '%EsExportDep1'
UPDATE VANGUARD.SCHEDULE_JOB SET IS_CANCELED=0 where TENANT_ID=84 and SCHEDULE_JOB_CODE like '%EsExportDep1'
update VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE= DATEADD(SECOND,2,GETDATE()) where TENANT_ID=84 and SCHEDULE_JOB_CODE like '%EsExportDep1'

select * from VANGUARD.SCHEDULE_JOB  where TENANT_ID=84 and  SCHEDULE_JOB_CODE like '%EsExportDep3'
UPDATE VANGUARD.SCHEDULE_JOB SET IS_CANCELED=0 where TENANT_ID=84 and SCHEDULE_JOB_CODE like '%EsExportDep3'
update VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE= DATEADD(SECOND,2,GETDATE()) where TENANT_ID=84 and SCHEDULE_JOB_CODE like '%EsExportDep3'

select * from VANGUARD.SCHEDULE_JOB  where TENANT_ID=84 and  SCHEDULE_JOB_CODE like '%ExportOneTime'
UPDATE VANGUARD.SCHEDULE_JOB SET IS_CANCELED=0 where TENANT_ID=84 and SCHEDULE_JOB_CODE like '%ExportOneTime'
update VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE= DATEADD(SECOND,2,GETDATE()) where TENANT_ID=84 and SCHEDULE_JOB_CODE like '%ExportOneTime%'

select * from VANGUARD.tenant

select * from VANGUARD.SCHEDULE_JOB  where TENANT_ID=26 and  SCHEDULE_JOB_CODE like '%ExportOneTime'
UPDATE VANGUARD.SCHEDULE_JOB SET IS_CANCELED=0 where TENANT_ID=26 and SCHEDULE_JOB_CODE like '%ExportOneTime'
update VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE= DATEADD(SECOND,2,GETDATE()) where TENANT_ID=26 and SCHEDULE_JOB_CODE like '%ExportOneTime%'


select top 10 * from VANGUARD.SCHEDULE_JOB_HISTORY where schedule_job_id = 26952 order by schedule_job_history_id desc


----------------------------------------------------------

  select
  dm.DEPT_ID,
   d.dept_desc,
  oi.doc_group_id,
  dg.doc_group_desc,
  dt.doc_type_id,
  dt.doc_type_desc,
  dt.doc_type_code,
  dm.DM_YEAR, 
  dm.DM_BK,
  dm.DM_PAGE,
  dm.CF_VCINSTNUM,
  dc.DMC_PAGECOUNT AS 'DC PageCount',
  dc.DMC_PATH 'DC Image Path'
from VG69999.doc_master dm
join VANGUARD.DEPT d  on dm.dept_id=d.dept_id
join VG69999.order_item oi on dm.dm_id = oi.dm_id
join VG69999.doc_group dg on oi.doc_group_id = dg.doc_group_id
join VG69999.doc_type dt on dm.doc_type_id = dt.doc_type_id
JOIN VG69999.DM_CONTENT dc ON dc.DM_ID = dm.DM_ID 
where dm.dm_id in
(
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num='20230801000028'
) )

-----------------------------------------

select * from VG69999.WORKFLOW_CONTENT
where ORDER_ITEM_ID in
(
  select ORDER_ITEM_ID from VG69999.ORDER_ITEM
  where ORDER_ID in
  (
    select order_id from VG69999.[ORDER]
     where order_num='20230727000063'
  )
)
ORDER BY VERSION DESC

-----------------------------------------

-- 20230727000061 -original
-- 20230727000063 -re-captured

-- original content    -> wfcontent-69999
-- re-captured content -> wfcontent-69999-scanfolder

select * from VG69999.[ORDER] WHERE order_num='20230727000063'
select * from VG69999.[ORDER_ITEM] WHERE order_id = 377158
select * from VG69999.[ORDER_ITEM_TYPE] WHERE ORDER_ITEM_TYPE_ID = 98
select * from VG69999.WORKFLOW
SELECT * FROM VG69999.TENANT_SERVICE_TYPE
SELECT * FROM VANGUARD.SERVICE_TYPE
SELECT * FROM VANGUARD.ORIGIN


SELECT TOP 10 * FROM VANGUARD.SCHEDULE_JOB_HISTORY  WHERE SCHEDULE_JOB_ID=28300 ORDER BY SCHEDULE_JOB_HISTORY_ID DESC

--------------------------

SELECT DISTINCT
           [dm].[DM_ID]
         , [dm].[DM_YEAR]
         , [dm].[CF_VCINSTNUM]
         , [DT].[DOC_TYPE_ID]
         , [DT].[DOC_TYPE_CODE]
         , [DT].[DOC_TYPE_DESC]
    FROM [VG69999].[DOC_MASTER] [dm]
    INNER JOIN [VG69999].[DOC_TYPE] [DT] ON [DT].[DOC_TYPE_ID] = [dm].[DOC_TYPE_ID]
    INNER JOIN [VG69999].[ORDER_ITEM] [oi] ON [oi].[DM_ID] = [dm].[DM_ID]
                                              AND [oi].[WORKFLOW_STEP_ID] = 5
    OUTER APPLY (   SELECT MAX([DATE_TIME]) AS [DATE_TIME]
                    FROM [VG69999].[ORDER_ITEM_HISTORY]
                    WHERE [ORDER_ITEM _ID] = [oi].[ORDER_ITEM_ID]
                          AND [STEP_ID] = 5
                          AND [ACTION_INFO] = 'SentToNextStep'
                    GROUP BY [ORDER_ITEM _ID] ) [OIH]
    WHERE [dm].[DEPT_ID] = 12
          AND [OIH].[DATE_TIME] >= '2023-08-01T00:00:00'
          AND [OIH].[DATE_TIME] < '2023-08-02T00:00:00'
          AND EXISTS (   SELECT 1
                         FROM [VG69999].[WORKFLOW] [w]
                         INNER JOIN VG69999.TENANT_SERVICE_TYPE tst ON tst.TENANT_SERVICE_TYPE_ID = w.TENANT_SERVICE_TYPE_ID
                         INNER JOIN VANGUARD.SERVICE_TYPE st ON st.SERVICE_TYPE_ID = tst.SERVICE_TYPE_ID
                         WHERE st.SERVICE_TYPE_DESC = 'Re-Capture'
                               AND [oi].[ORDER_ITEM_TYPE_ID] = [w].[ORDER_ITEM_TYPE_ID] )

-----------

  SELECT DISTINCT
  dm.DEPT_ID,
   d.dept_desc,
  oi.doc_group_id,
  dg.doc_group_desc,
  dt.doc_type_id,
  dt.doc_type_desc,
  dt.doc_type_code,
  dm.DM_YEAR, 
  dm.DM_BK,
  dm.DM_PAGE,
  dm.CF_VCINSTNUM,
  dc.DMC_PAGECOUNT AS 'DC PageCount',
  dc.DMC_PATH 'DC Image Path'
from VG69999.doc_master dm
join VANGUARD.DEPT d  on dm.dept_id=d.dept_id
join VG69999.order_item oi on dm.dm_id = oi.dm_id
JOIN VG69999.[order] o ON o.ORDER_ID = oi.ORDER_ID
JOIN VANGUARD.[ORIGIN] ORI ON  ORI.ORIGIN_ID = o.ORIGIN_ID
JOIN VG69999.[ORDER_ITEM_TYPE] oit ON oit.ORDER_ITEM_TYPE_ID = oi.ORDER_ITEM_TYPE_ID
JOIN VG69999.[WORKFLOW] w ON w.ORDER_ITEM_TYPE_ID = oit.ORDER_ITEM_TYPE_ID
JOIN VG69999.[TENANT_SERVICE_TYPE] tst ON tst.TENANT_SERVICE_TYPE_ID = w.TENANT_SERVICE_TYPE_ID
JOIN VANGUARD.[SERVICE_TYPE] st ON st.SERVICE_TYPE_ID = tst.SERVICE_TYPE_ID
join VG69999.doc_group dg on oi.doc_group_id = dg.doc_group_id
join VG69999.doc_type dt on dm.doc_type_id = dt.doc_type_id
JOIN VG69999.DM_CONTENT dc ON dc.DM_ID = dm.DM_ID 
JOIN VG69999.[ORDER_ITEM_HISTORY] oih ON oih.[ORDER_ITEM _ID] = oi.ORDER_ITEM_ID
WHERE dm.DEPT_ID = 12 AND 
      o.WORKFLOW_STEP_ID = 5 AND 
	  ORI.ORIGIN_DESC = 'Search' AND 
	  st.SERVICE_TYPE_DESC= 'Re-Capture' 
	  AND oih.DATE_TIME > '2023-07-31T00:00:00'
--ORDER BY dm.DM_YEAR DESC



select * from VG69999.DM_CONTENT
where DM_ID in (
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num ='20230802000004'
) )

select * from VG69999.DM_CONTENT
where DM_ID in (
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num ='20230802000015'
) )




SELECT * FROM vg69999.[order] WHERE order_num = '20230801000028'
SELECT * FROM vg69999.[order_item] WHERE order_id =377223 



select * from VG01003.DOC_MASTER
where DM_ID in 
(
	select DM_ID from VG01003.ORDER_ITEM
	where order_id in 
	(
		select order_id from VG01003.[ORDER]
		where order_num='20240719000011'
	) 
)