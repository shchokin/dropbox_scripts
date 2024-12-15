declare @order_number varchar(60)
set @order_number = '20230427000008'

select * from VG69999.WORKFLOW_CONTENT
where ORDER_ITEM_ID in(
select ORDER_ITEM_ID from VG69999.ORDER_ITEM
  where ORDER_ID in(
    select order_id from VG69999.[ORDER]
     where order_num=@order_number
  ))order by id desc
   
select * from VG69999.DOC_MASTER
where DM_ID in (
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num=@order_number
) )

select * from VG69999.DM_CONTENT
where DM_ID in (
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num=@order_number
) )

/*
select * from VG69999.SCANNED_FILE where SCANNER_TASK_ID in
(select TOP 1 SCANNER_TASK_ID from VG69999.SCANNER_BATCH 
where ADUSER_ID = 170 order by SCANNER_BATCH_ID desc)
---------------------------------------------

select * from VG69999.DOC_MASTER_VERSION
where DM_ID in (
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num=@order_number
) )

select * from VG69999.DM_CONTENT_VERSION
where DM_ID in (
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num=@order_number
) )

*/


