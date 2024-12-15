select * from VANGUARD.service_type where service_type_desc = 'Nightly Export'
select * from VG48999.order_item_type where order_item_type_name like '%Nightly%'
select * from VG48999.acct_details_audit
select * from VG48999.workflow where workflow_desc like '%Nightly%'

----------------------------------------------------------------------------------------

--Stored Procedures

-- VG48999.GetCompanyAccountsNightlyExportBillingDetails                                      --Check all qualifying CAs

-- SELECT * FROM [VGXXXX].[GetAccountBalance](YourAccountId, DEFAULT) AS AccountBalance       --Check CA balance (also when it's negative)   

-----------------------------------------------------------------------------------------

select 
      a.acct_code,
	  a.acct_enabled,
	  oit.order_item_type_desc,
	  fcp.fee_code_parameter_value,
	  ae.is_allow_export,
	  u.email_id,
	  au.is_admin,
	  au.is_enabled,
	  au.is_disassociated,
	  balance.acct_balance,
	  a.acct_allow_credit,
	  a.acct_min_balance,
	  au.au_max_daily_amt,
	  CONVERT (FLOAT, ISNULL ( balance.acct_balance, 0)) + a.acct_min_balance as Total
from VG48999.ACCT_DETAILS ad
join VG48999.account a on a.acct_id = ad.acct_id
join VG48999.ORDER_ITEM_TYPE oit on oit.ORDER_ITEM_TYPE_ID = ad.ORDER_ITEM_TYPE_ID
join VG48999.ORDER_ITEM_TYPE_FEE_GROUP oitfg on oitfg.order_item_type_id = oit.order_item_type_id
join VG48999.FEE_GROUP_FEE_CODE fgfc on fgfc.fee_group_id = oitfg.fee_group_id
join VG48999.FEE_CODE_FEE_CODE_PARAMETER fcfcp on fcfcp.fee_code_id = fgfc.fee_code_id
join VG48999.FEE_CODE_PARAMETER fcp on fcp.fee_code_parameter_id = fcfcp.fee_code_parameter_id
join VG48999.account_export ae on ae.account_id = a.acct_id
join VG48999.account_user au on au.acct_id = a.acct_id
join VANGUARD.[user] u on u.id = au.user_id
OUTER APPLY
     (
	   select top 1 * from VG48999.ACCOUNT_ACTIVITY aa
	   where aa.acct_id = a.acct_id
	   order by aa.acct_activity_id desc
	 ) balance
where oit.order_item_type_name like '%Nightly%' AND                             --has 'Nightly Export Billing' OIT
       a.acct_enabled = 1                                                       --Activated CA 
	  AND TRY_CONVERT(float, fcp.fee_code_parameter_value) > 0                  --fee of the OIT is greater than $0.00    
	  AND is_allow_export = 1                                                   --login activated in FO
	  AND au.is_disassociated = 0 AND au.is_enabled = 1 AND au.is_admin = 1     -- associeted enabled admin user
order by acct_code asc


--------------------------------------------------------------------------------

SELECT top 50 
      o.order_num,
	  --oi.order_item_type_id,
	  oit.order_item_type_desc,
	  pm.payment_method_name,
	  op.amount,
	  op.account_id,
	  a.acct_code,
	  a.acct_name
FROM VG48999.[order] o
join VG48999.order_item oi on oi.order_id = o.order_id
join VG48999.order_item_type oit on oit.order_item_type_id = oi.order_item_type_id 
join VG48999.ORDER_ITEM_TYPE_PAYMENT_METHOD oitpm on oitpm.order_item_type_id = oit.order_item_type_id
join VG48999.payment_method pm on pm.payment_method_id = oitpm.payment_method_id
join VG48999.order_payment op on op.order_id = o.order_id
join VG48999.account a on a.acct_id = op.account_id
where pm.payment_method_name = 'Company Account'
order by o.order_num desc
--where oit.order_item_type_name like '%Nightly%'

-----------------------------------------------------------------------------------------------

select * from VANGUARD.tenant where tenant_code = 48999

select * from VANGUARD.SCHEDULE_JOB where  TENANT_ID = 63 and SCHEDULE_JOB_CODE = 'NightlyExportBilling'

UPDATE VANGUARD.SCHEDULE_JOB SET NEXT_EXECUTE_DATE = dateadd(SECOND, 2, GETDATE()), SCHEDULER_NAME = NULL, LOCK_DATE = null, STATUS= 2 WHERE SCHEDULE_JOB_ID = 28821

-------------------------------------------------------------------------------------------------

select * from VG48999.NIGHTLY_EXPORT_BILLING_AUDIT 
where execution_date >= '2024-02-29'
order by NIGHTLY_EXPORT_BILLING_AUDIT_ID desc



-----------------------------------------------------


