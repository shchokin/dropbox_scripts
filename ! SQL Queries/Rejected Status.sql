--declare @order_num


select * from VG48999.DOC_MASTER
where DM_ID in 
(
	select DM_ID from VG48999.ORDER_ITEM
	where order_id in 
	(
		select order_id from VG48999.[ORDER]
		where order_num='20240909000024'
	) 
)
---------------------------------------------| CONTENT_FOLDER_ID = 11| --https://vgdevimages.blob.core.windows.net:443/wfcontent-48999-attachments-additionalimages  --e.g. ML Application
                                           --| CONTENT_FOLDER_ID = 9|  --https://vgdevimages.blob.core.windows.net:443/wfcontent-48999-scanfolder
select * from VG48999.WORKFLOW_CONTENT
where ORDER_ITEM_ID in
(
	select ORDER_ITEM_ID from VG48999.ORDER_ITEM
	where ORDER_ID in
	(
		select order_id from VG48999.[ORDER]
		where order_num='20240909000024'
    )
)
---------------------------------------------| DM_STORAGE_ID = 2 | --https://vgdevimages.blob.core.windows.net:443/dmcontent-48999
select * from VG48999.DM_CONTENT
where DM_ID in 
(
	select DM_ID from VG48999.ORDER_ITEM
	where order_id in 
	(
		select order_id from VG48999.[ORDER]
		where order_num='20240909000024'
	) 
) order by dm_id

---------------------------------------------Capture Order Status

select 
       ct.*,
	   cts.CAPTURING_TASK_STATUS_DESC 
from VG48999.CAPTURING_TASK ct
join VANGUARD.CAPTURING_TASK_STATUS cts on cts.CAPTURING_TASK_STATUS_ID = ct.CAPTURING_TASK_STATUS_ID
where ORDER_ID in
(
	select order_id from VG48999.[ORDER]
	where order_num='20240909000024'
)

---------------------------------------------Capture OI Status

select 
       ctot.*,
	   cts.CAPTURING_TASK_STATUS_DESC 
from VG48999.CAPTURING_TASK_ORDER_ITEM ctot
join VANGUARD.CAPTURING_TASK_STATUS cts on cts.CAPTURING_TASK_STATUS_ID = ctot.ORDER_ITEM_CAPTURING_STATUS_ID
where ORDER_ITEM_ID in
(
	select ORDER_ITEM_ID from VG48999.ORDER_ITEM
	where ORDER_ID in
	(
		select order_id from VG48999.[ORDER]
		where order_num='20240909000024'
    )
)

--select * from VANGUARD.CAPTURING_TASK_STATUS

-------------------------------------------

select * 
from VG48999.DM_EXTENDED de
left join VANGUARD.BEHAVIOUR_FLAG bf on bf.bf_id = de.document_status
where DM_ID in 
(
	select DM_ID from VG48999.ORDER_ITEM
	where order_id in 
	(
		select order_id from VG48999.[ORDER]
		where order_num='20241029000021'
	) 
)
order by dm_id asc
----------------------------------------------
select 
        * 
from VG48999.DOCUMENT_STATUS_HISTORY dsh
left join VANGUARD.BEHAVIOUR_FLAG bf on bf.bf_id = dsh.document_status_id
where DM_ID in 
(
	select DM_ID from VG48999.ORDER_ITEM
	where order_id in 
	(
		select order_id from VG48999.[ORDER]
		where order_num='20240909000024'
	) 
)
------------------------------------------


select * from VANGUARD.BEHAVIOUR_FLAG
select * from VANGUARD.BEHAVIOUR_ACTION
select * from VG48999.BEHAVIOUR_FLAG_BEHAVIOUR_ACTION

--insert into VG48999.BEHAVIOUR_FLAG_BEHAVIOUR_ACTION values (10,1)
--insert into VG48999.BEHAVIOUR_FLAG_BEHAVIOUR_ACTION values (10,2)
--insert into VG48999.BEHAVIOUR_FLAG_BEHAVIOUR_ACTION values (10,3)

select * from VG48999.order_item_type where order_item_type_id = 360


select order_id from VG48999.[ORDER] where order_num='20240702000038'

select * from VG48999.[ORDER_ITEM] where order_id = 60657

select * from VG48999.[ORDER_ITEM_TYPE] where order_item_type_id = 98

go
select
ORDER_ITEM_TYPE_ID,
CONCAT('Workflow_',ORDER_ITEM_TYPE_NAME,'.xml') as CONFIGURATION,
IS_ACTIVE,
ORDER_ITEM_TYPE_DISPLAY_NAME,
HAS_COVER_PAGE
from VG48999.ORDER_ITEM_TYPE
WHERE ORDER_ITEM_TYPE_ID=98


select * 
from VG48999.order_history
where order_id in 
	(
		select order_id from VG48999.[ORDER]
		where order_num='20240910000025'
	) 

select * from VG48999.order_rejection_reason


select top 50 * 
from VG48999.order_history order by order_history_id desc

-----Check reasons per order-------------------

select * from VG48999.ORDER_ITEM_BEHAVIOR_FLAG
where order_item_id in
(
   select order_item_id from VG48999.order_item
   where order_id in 
	(
		select order_id from VG48999.[ORDER]
		where order_num='20240911000002'
	) 
)

