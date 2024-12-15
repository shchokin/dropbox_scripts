--USE VANGUARD_TX_QA

DECLARE @order_number varchar(60)
set @order_number = '20230620000001'

SELECT 
       dt.DEVELOPMENT_TYPE AS "Property Name",
	   dml.development_name AS "Development Name", 
	   dml.LGL_DESC AS "Legal Description",
	   dml.LGL_LOWLOT AS "Lot",
	   dml.LGL_BLOCK AS "Block",
	   dml.LGL_UNIT_OR_PART AS "Unit",
	   dml.LGL_TRACT AS "Tract",
	   dml.LGL_SECTION AS "Section",
	   dml.LGL_TOWNSHIP AS "Township",
	   dml.LGL_ACRES AS "Acres",
	   dml.LGL_BUILDING AS "Building",
	   dml.LGL_HALF AS "Half",
	   dml.LGL_QUARTER AS "Quater",
	   dml.LGL_REMARKS AS "Remarks",
	   dml.LGL_RANGE AS "Range"
FROM VG69999.DM_LEGAL dml
JOIN VANGUARD.DEVELOPMENT_TYPE dt ON dml.DEVELOPMENT_TYPE_ID = dt.DEVELOPMENT_TYPE_ID 
where DM_ID in (
select DM_ID from VG69999.ORDER_ITEM 
where order_id in (
select order_id from VG69999.[ORDER]
where order_num=@order_number
) )

---------------------------------------------------------------------------------------

SELECT 
       dt.DEVELOPMENT_TYPE AS "Property Name",
	   dml.development_name AS "Development Name", 
	   dml.DM_LGL_VER AS "Version Document",
	   dml.LGL_DESC AS "Legal Description",
	   dml.LGL_LOWLOT AS "Lot",
	   dml.LGL_BLOCK AS "Block",
	   dml.LGL_UNIT_OR_PART AS "Unit",
	   dml.LGL_TRACT AS "Tract",
	   dml.LGL_SECTION AS "Section",
	   dml.LGL_TOWNSHIP AS "Township",
	   dml.LGL_ACRES AS "Acres",
	   dml.LGL_BUILDING AS "Building",
	   dml.LGL_HALF AS "Half",
	   dml.LGL_QUARTER AS "Quater",
	   dml.LGL_REMARKS AS "Remarks",
	   dml.LGL_RANGE AS "Range"
FROM VG69999.DM_LEGAL_VERSION dml
JOIN VANGUARD.DEVELOPMENT_TYPE dt ON dml.DEVELOPMENT_TYPE_ID = dt.DEVELOPMENT_TYPE_ID 
where dml.DM_ID in (
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num=@order_number
) ) AND dml.DEVELOPMENT_TYPE_ID = 5









