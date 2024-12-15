select top 50  --*
               parcel_id,
			   address1,
			   zip,
			   state_code,
			   city,
			   legal_desc, 
			   is_city_parcel,
			   land_value,
			   bldg_value,
			   total_value
from VG51013.appraisal


select * from VG51013.appraisal where PARCEL_ID = '51101008'
--update VG51013.appraisal set is_city_parcel = 1 where PARCEL_ID = '01001001'

select
      --dm.DM_ID,
      --dm.CF_VCINSTNUM as Document_Number,
	  dmp.PARCEL_ID,
	  dmp.ADDRESS1,
	  dmp.ZIPCODE,
	  --dmp.STATE,
	  dmp.CITY,
	  dmp.LGL_DESC
	  --dmp.TAX_DISTRICT as Tax_District,
	  --dmp.LAND_USE_CODE as Land_Use_Code,
	  --dmp.LAND_VALUE as Land_Value,
	  --dmp.BLDG_VALUE as Building_Value,
	  --dmp.CF_TOTAL_VALUE as Total_Value,
	  --dp.PTYPE_ID,
	  --dp.PARTY_NAME1,
	  --dp.PARTY_NAME2
from VG51013.DM_PROPADDRESS dmp
JOIN VG51013.DOC_MASTER dm on dmp.DM_ID = dm.DM_ID
JOIN VG51013.DM_PARTIES dp on dp.DM_ID = dm.DM_ID
where  dmp.DM_ID in (
select DM_ID from VG51013.ORDER_ITEM
where order_id in (
select order_id from VG51013.[ORDER]
where order_num='20240814000003'
) ) 
order by seq asc






select  * from VG51013.order_item_propaddress





SELECT VG51013.GetTenantDate()

SELECT * FROM [VG51013].[QUEUES_CONFIGURATION]