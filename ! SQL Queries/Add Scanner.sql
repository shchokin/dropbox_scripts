use VANGUARD_TX_QA

select * from VG48321.device_service
select * from VG48321.device

-------------------

SELECT * FROM VG48321.AD_USER WHERE ADUSER_FIRSTNAME = 'artyom'
SELECT * FROM VG48321.WORK_STATION WHERE WORK_STATION_ADDRESS = '10.0.2.247'

select * from VG48321.location

select * from VG48321.ad_usergroup

-------------------

DECLARE @workstationId INT = 7
DECLARE @scannerId INT
INSERT INTO VG48321.SCANNER
        ( SCANNER_NAME ,
          SCANNER_STATUS ,
          CREATED_AT
        )
VALUES  ( 'XPCTWAIN TIFF/JPEG Scanner' , -- SCANNER_NAME - varchar(100)
          1, -- SCANNER_STATUS - int
          GETDATE()  -- CREATED_AT - datetime
        )
  SET @scannerId = SCOPE_IDENTITY()
  INSERT INTO VG48321.SCANNER_WORKSTATION
          ( WORKSTATION_ID ,
            SCANNER_ID
          )
  VALUES  ( @workstationId , -- WORKSTATION_ID - smallint
            @scannerId  -- SCANNER_ID - int
          )
 SELECT @scannerId

 select * from VG48321.SCANNER_WORKSTATION















