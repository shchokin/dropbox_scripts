SELECT aduser_id, aduser_domain, aduser_firstname, aduser_lastname, aduser_emailid FROM VG48999.ad_user  WHERE aduser_domain like '%artyom.shchokin'

SELECT 
CONVERT(XML, 
	   (
	      SELECT aduser_preferences 
	      FROM VG48999.ad_user 
	      WHERE aduser_domain like '%artyom.shchokin'
	      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)')
	    ) 
AS FormattedXML

-------------------------------------------------------------------------------

SELECT aduser_id, aduser_domain, aduser_firstname, aduser_lastname, aduser_emailid FROM VG48999.ad_user  WHERE aduser_domain like '%User1'

SELECT 
CONVERT(XML, 
	   (
	      SELECT aduser_preferences 
	      FROM VG48999.ad_user 
	      WHERE aduser_domain like '%User1'
	      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)')
	    ) 
AS FormattedXML

