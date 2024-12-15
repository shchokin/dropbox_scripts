--------------------------------
select 
	PARCEL_ID,
	OWNER_LAST1,
	OWNER_FIRST1,
	OWNER_LAST2,
	OWNER_FIRST2,
	OWNER_LAST3,
	OWNER_FIRST3,
	OWNER_LAST4,
	OWNER_FIRST4,
	OWNER_LAST5,
	OWNER_FIRST5
from VG69999.appraisal
where PARCEL_ID = 'OOO-12-345'
-----------------------------------

select
      dm.DM_ID,
      dm.CF_VCINSTNUM as Document_Number,
	  dmp.PARCEL_ID as Parcel_Id,
	  dmp.TAX_DISTRICT as Tax_District,
	  dmp.LAND_USE_CODE as Land_Use_Code,
	  dmp.LAND_VALUE as Land_Value,
	  dmp.BLDG_VALUE as Building_Value,
	  dmp.CF_TOTAL_VALUE as Total_Value,
	  dp.PTYPE_ID,
	  dp.PARTY_NAME1,
	  dp.PARTY_NAME2
from VG69999.DM_PROPADDRESS dmp
JOIN VG69999.DOC_MASTER dm on dmp.DM_ID = dm.DM_ID
JOIN VG69999.DM_PARTIES dp on dp.DM_ID = dm.DM_ID
where  dmp.DM_ID in (
select DM_ID from VG69999.ORDER_ITEM
where order_id in (
select order_id from VG69999.[ORDER]
where order_num='20221208000003'
) ) 
order by seq asc

-----------------------------------------------

select
      top 1
      dm.DM_ID,
      dm.CF_VCINSTNUM as Document_Number,
	  dm.DM_RECORDED as Recorded_,
	  dmp.PARCEL_ID as Parcel_Id,
	  --dmp.TAX_DISTRICT as Tax_District,
	  --dmp.LAND_USE_CODE as Land_Use_Code,
	  --dmp.LAND_VALUE as Land_Value,
	  --dmp.BLDG_VALUE as Building_Value,
	  --dmp.CF_TOTAL_VALUE as Total_Value,
	  dp.PTYPE_ID,
	  dp.PARTY_NAME1,
	  dp.PARTY_NAME2,
	  oi.IS_VOIDED
from VG69999.DM_PROPADDRESS dmp
JOIN VG69999.DOC_MASTER dm on dmp.DM_ID = dm.DM_ID
JOIN VG69999.DM_PARTIES dp on dp.DM_ID = dm.DM_ID
JOIN VG69999.ORDER_ITEM oi on oi.DM_ID = dm.DM_ID
where dmp.PARCEL_ID = 'OOO-12-345' and dp.PTYPE_ID = 2
order by dm.DM_RECORDED desc







