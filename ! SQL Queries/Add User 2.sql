DECLARE @Info table
       (
              [ADUSER_DOMAIN] nvarchar(255),
              [DEVICE_NAME] nvarchar(255),
              [ADUSER_FIRSTNAME] nvarchar(255),
              [ADUSER_LASTNAME] nvarchar(255),
              [ADUSER_EMAILID] nvarchar(255),
              [WORK_STATION_NAME] nvarchar(128),
              [WORK_STATION_ADDRESS] nvarchar(128)
       )
--Volo Armenia
 --INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
 --VALUES (N'VOLO-DC\user1', N'VOLO-DC\user1', N'User1',N'User1', N'user1.user1@volo.global', N'13.64.254.138', N'13.64.254.138')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\zaven.adamyan', N'VOLO-DC\zaven.adamyan', N'Zaven',N'Adamyan', N'zaven_adamyan@hotmail.com', N'Zaven-pc.volo.local', N'10.0.0.58')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\yuri.brutyan', N'VOLO-DC\yuri.brutyan',  N'Yuri', N'Brutyan', N'ybrutyan@gmail.com', N'10.0.0.28', N'10.0.0.28')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\suren.guyumjyan', N'VOLO-DC\suren.guyumjyan', N'Suren', N'Guyumjyan', N'guyumsuren@live.com', N'Suren-pc.volo.local', N'10.0.0.15')
-- INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
-- VALUES (N'VOLO-DC\Nelli.Krtyan', N'VOLO-DC\Nelli.Krtyan', N'Nelli', N'Krtyan', N'Nelli.krtyan@volo.global', N'office118-pc.volo.local', N'10.0.0.36')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\narek.daghlaryan', N'VOLO-DC\narek.daghlaryan', N'Narek', N'Daghlaryan', N'narek.daghlaryan@outlook.com', N'narek.volo.local', N'10.0.0.14')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\artur.torosyan', N'VOLO-DC\artur.torosyan', N'Arthur', N'Torosyan', N'artur.torosyan@volo.global', N'Arthur.volo.local', N'10.0.0.13')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\armen.hovhannisyan', N'VOLO-DC\armen.hovhannisyan', N'Armen', N'Hovhannisyan', N'Armen.Hovhannisyan@volo.global', N'10.0.0.55', N'10.0.0.55')
-- INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
-- VALUES (N'VOLO-DC\anahit.atoyan', N'VOLO-DC\anahit.atoyan', N'Anahit', N'Atoyan', N'Anahit.atoyan@volo.global', N'10.0.0.27', N'10.0.0.27')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\Hayk.Aslanyan', N'VOLO-DC\Hayk.Aslanyan', N'Hayk', N'Aslanyan', N'hayk.aslanyan@volo.global', N'Hayk.volo.local', N'10.0.0.29')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\Arthur.Hovhannisyan', N'VOLO-DC\Arthur.Hovhannisyan', N'Arthur',N'Hovhannisyan', N'arthur.hovhannisyan@volo.global', N'Office_7-PC.volo.local', N'10.0.0.65')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\tigran.karapetyan', N'VOLO-DC\tigran.karapetyan', N'Tigran',N'Karapetyan', N'tigran.karapetyan@volo.global', N'10.0.0.84', N'10.0.0.84')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\sargis.parunakyan', N'VOLO-DC\sargis.parunakyan', N'Sargis',N'Parunakyan', N'Sargis.Parunakyan@volo.global', N'10.0.0.107', N'10.0.0.107')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\narek.torosyan', N'VOLO-DC\narek.torosyan', N'Narek',N'Torosyan', N'narek.torosyan@volo.global', N'10.0.0.79', N'10.0.0.79')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'VOLO-DC\satenik.hovsepyan', N'VOLO-DC\satenik.hovsepyan', N'Satenik',N'Hovsepyan', N'satenik.hovsepyan@volo.global', N'Satenik.volo.local', N'10.0.0.43')
 --INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
 --VALUES (N'VOLO-DC\naira.yezekyan', N'VOLO-DC\naira.yezekyan', N'Naira',N'Yezekyan', N'naira.yezekyan@volo.global', N'office23-pc.volo.local', N'10.0.0.88')
-- INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
-- VALUES (N'VOLO-DC\arpine.aleksanyan', N'VOLO-DC\arpine.aleksanyan', N'Arpine',N'Aleksanyan', N'arpine.aleksanyan@volo.global', N'office28-pc.volo.local', N'10.0.0.115')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'Volo-DC\Vahram.Aleksandryan', N'Volo-DC\Vahram.Aleksandryan', N'Vahram',N'Aleksandryan', N'vahram.azatyan@volo.global', N'10.0.5.248', N'10.0.5.248')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'Volo-DC\aram.hovsepyan', N'Volo-DC\aram.hovsepyan', N'Aram',N'Hovsepyan', N'aram.hovsepyan@volo.global', N'Office27-PC.volo.local', N'10.0.0.110')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'Volo-DC\gegham.mkrtchyan', N'Volo-DC\gegham.mkrtchyan', N'Gegham',N'Mkrtchyan', N'gegham.mkrtchyan@volo.global', N'10.0.0.8', N'10.0.0.8')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'Volo-DC\stella.hovsepyan', N'Volo-DC\stella.hovsepyan', N'Stella',N'Hovsepyan', N'stella.hovsepyan@volo.global', N'Office30-PC.volo.local', N'10.0.0.105')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'Volo-DC\hovhannes.hovsepyan', N'Volo-DC\hovhannes.hovsepyan', N'Hovhannes',N'Hovsepyan', N'hovhannes.hovsepyan@volo.global', N'10.0.0.118', N'10.0.0.118')
 --INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
 --VALUES (N'Volo-DC\maria.manukyan', N'Volo-DC\maria.manukyan', N'Maria',N'Manukyan', N'maria.manukyan@volo.global', N'office115-pc.volo.local', N'10.0.0.24')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'Volo-DC\artur.meghrikyan', N'Volo-DC\artur.meghrikyan', N'Artur',N'Meghrikyan', N'artur.meghrikyan@volo.global', N'office81-pc.volo.local', N'10.0.0.191')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'Volo-DC\gevorg.asryan', N'Volo-DC\gevorg.asryan', N'GevorgA',N'Asryan', N'gevorg.asryan@volo.global', N'10.0.0.60', N'10.0.0.60')
--INSERT @Info ([ADUSER_DOMAIN],[DEVICE_NAME],[ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_EMAILID], [WORK_STATION_NAME], [WORK_STATION_ADDRESS])
--VALUES (N'Volo-DC\arsen.asatryan', N'Volo-DC\arsen.asatryan', N'Arsen',N'Asatryan', N'arsen.asatryan@volo.global', N'10.0.0.60', N'10.0.0.60')
---- VOLO UK
--insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
--values (N'volo-dc\artyom.shchokin', N'volo-dc\artyom.shchokin', N'artyom', N'shchokin', N'artyom.shchokin@volo.global', N'10.0.2.247', N'10.0.2.247')
insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
values (N'volo-dc\anatolii.kononovych', N'volo-dc\anatolii.kononovych', N'anatolii', N'kononovych', N'anatolii.kononovych@volo.global', N'10.0.7.247', N'10.0.7.247')
--insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
--values (N'volo-dc\aleksey.shulakov', N'volo-dc\aleksey.shulakov', N'aleksey',N'shulakov', N'aleksey.shulakov@volo.global', N'uazp08ws.volo.local', N'10.0.2.220')
--insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
--values (N'volo-dc\andrey.kolesnik', N'volo-dc\andrey.kolesnik', N'andrey',N'kolesnik', N'andrey.kolesnik@volo.global', N'10.0.4.128', N'10.0.4.128')
--insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
--values (N'volo-dc\roman.golovko', N'volo-dc\roman.golovko', N'roman',N'golovko', N'roman.golovko@volo.global', N'uadp21ws.volo.local', N'10.0.4.114')
--insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
--values (N'volo-dc\sergejus.tumovas', N'volo-dc\sergejus.tumovas', N'sergejus', N'tumovas', N'sergejus.tumovas@volo.global', N'10.0.2.253', N'10.0.2.253')
--insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
--values (N'volo-dc\nikita.hordiienko', N'volo-dc\nikita.hordiienko', N'nikita',N'hordiienko', N'nikita.hordiienko@volo.global', N'10.0.4.108', N'10.0.4.108')
--insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
--values (N'volo-dc\dmytro.korniienko', N'volo-dc\dmytro.korniienko', N'dmytro', N'korniienko', N'dmytro.korniienko@volo.global', N'10.0.2.118', N'10.0.2.118')
--insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
--values (N'volo-dc\eugen.gordeychuk', N'volo-dc\eugen.gordeychuk', N'eugen',N'gordeychuk', N'eugen.gordeychuk@volo.global', N'10.0.4.151', N'10.0.4.151')
--insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
--values (N'volo-dc\kirill.mischenko', N'volo-dc\kirill.mischenko', N'kirill',N'mischenko', N'kirill.mischenko@volo.global', N'10.0.4.103', N'10.0.4.103')
--insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
--values (N'volo-dc\vadim.dubovitsky', N'volo-dc\vadim.dubovitsky', N'vadim',n'dubovitsky', N'vadim.dubovitsky@volo.global', N'10.0.2.196', N'10.0.2.196')
--insert @info ([aduser_domain],[device_name],[aduser_firstname], [aduser_lastname], [aduser_emailid], [work_station_name], [work_station_address])
--values (N'volo-dc\eugen.gordeychuk', N'volo-dc\eugen.gordeychuk', N'Eugene',N'Gordeychuk', N'eugene.gordeychuk@volo.global', N'10.0.4.151', N'10.0.4.151')
print 'Delete existing users'
DELETE FROM VG48251.AD_USER_LOGIN_STATISTIC WHERE ADUSER_ID IN (SELECT ADUSER_ID FROM VG48251.AD_USER WHERE ADUSER_DOMAIN IN (SELECT [ADUSER_DOMAIN] FROM @Info))
DELETE FROM VG48251.CRS_LOCKED_ELEMENT WHERE ADUSER_ID IN (SELECT ADUSER_ID FROM VG48251.AD_USER WHERE ADUSER_DOMAIN IN (SELECT [ADUSER_DOMAIN] FROM @Info))
DELETE FROM VG48251.AD_USER_AD_USERGROUP WHERE ADUSER_ID IN (SELECT ADUSER_ID FROM VG48251.AD_USER WHERE ADUSER_DOMAIN IN (SELECT [ADUSER_DOMAIN] FROM @Info))
DELETE FROM VG48251.SCANNER_BATCH WHERE SCANNER_TASK_ID IN (SELECT SCANNER_TASK_ID FROM VG48251.SCANNER_TASK WHERE WORKSTATION_ID IN (SELECT WORK_STATION_ID FROM VG48251.WORK_STATION WHERE WORK_STATION_ADDRESS IN (SELECT WORK_STATION_ADDRESS FROM @Info)))
DELETE  FROM VG48251.AD_USER_DEVICE WHERE ADUSER_ID IN (SELECT ADUSER_ID FROM VG48251.AD_USER WHERE ADUSER_DOMAIN IN (SELECT [ADUSER_DOMAIN] FROM @Info))
DELETE  FROM VG48251.SEARCH_HISTORY WHERE AD_USER_ID IN (SELECT ADUSER_ID FROM VG48251.AD_USER WHERE ADUSER_DOMAIN IN (SELECT [ADUSER_DOMAIN] FROM @Info))
DELETE FROM VG48251.SHOPPINGCART_ITEMS WHERE SHOPPINGCART_ID IN (SELECT SHOPPINGCART_ID FROM VG48251.SHOPPINGCART WHERE CLERK_ID IN (SELECT ADUSER_ID FROM VG48251.AD_USER WHERE ADUSER_DOMAIN IN (SELECT [ADUSER_DOMAIN] FROM @Info)))
DELETE FROM VG48251.SHOPPINGCART WHERE CLERK_ID IN (SELECT ADUSER_ID FROM VG48251.AD_USER WHERE ADUSER_DOMAIN IN (SELECT [ADUSER_DOMAIN] FROM @Info))
DELETE  FROM VG48251.AD_USER WHERE ADUSER_ID IN (SELECT ADUSER_ID FROM VG48251.AD_USER WHERE ADUSER_DOMAIN IN (SELECT [ADUSER_DOMAIN] FROM @Info))
print 'Delete existing workstations'
DELETE FROM VG48251.LOCATION_WORK_STATION WHERE WORK_STATION_ID IN (SELECT WORK_STATION_ID FROM VG48251.WORK_STATION WHERE WORK_STATION_ADDRESS IN (SELECT WORK_STATION_ADDRESS FROM @Info))
DELETE FROM VG48251.WORK_STATION_DEVICE WHERE WORK_STATION_ID IN (SELECT WORK_STATION_ID FROM VG48251.WORK_STATION WHERE WORK_STATION_ADDRESS IN (SELECT WORK_STATION_ADDRESS FROM @Info))
DELETE FROM VG48251.AD_USER_LOGIN_STATISTIC WHERE WORK_STATION_ID IN (SELECT WORK_STATION_ID FROM VG48251.WORK_STATION WHERE WORK_STATION_ADDRESS IN (SELECT WORK_STATION_ADDRESS FROM @Info))
DELETE FROM VG48251.CRS_LOCKED_ELEMENT WHERE WORKSTATION_ID IN (SELECT WORK_STATION_ID FROM VG48251.WORK_STATION WHERE WORK_STATION_ADDRESS IN (SELECT WORK_STATION_ADDRESS FROM @Info))
DELETE FROM VG48251.UPLOAD_IMAGE_ACTIONS_LOG WHERE WORKSTATION_ID IN (SELECT WORK_STATION_ID FROM VG48251.WORK_STATION WHERE WORK_STATION_ADDRESS IN (SELECT WORK_STATION_ADDRESS FROM @Info))
DELETE FROM VG48251.SCANNED_FILE WHERE SCANNER_TASK_ID IN (SELECT SCANNER_TASK_ID FROM VG48251.SCANNER_TASK WHERE WORKSTATION_ID IN (SELECT WORK_STATION_ID FROM VG48251.WORK_STATION WHERE WORK_STATION_ADDRESS IN (SELECT WORK_STATION_ADDRESS FROM @Info)))
DELETE FROM VG48251.SCANNER_TASK WHERE WORKSTATION_ID IN (SELECT WORK_STATION_ID FROM VG48251.WORK_STATION WHERE WORK_STATION_ADDRESS IN (SELECT WORK_STATION_ADDRESS FROM @Info))
DELETE FROM VG48251.SCANNER_WORKSTATION WHERE WORKSTATION_ID IN (SELECT WORK_STATION_ID FROM VG48251.WORK_STATION WHERE WORK_STATION_ADDRESS IN (SELECT WORK_STATION_ADDRESS FROM @Info))
DELETE FROM VG48251.SCANNER_CONFIGURATION_WORKSTATION WHERE WORKSTATION_ID IN (SELECT WORK_STATION_ID FROM VG48251.WORK_STATION WHERE WORK_STATION_ADDRESS IN (SELECT WORK_STATION_ADDRESS FROM @Info))
DELETE FROM VG48251.WORK_STATION WHERE WORK_STATION_ID IN (SELECT WORK_STATION_ID FROM VG48251.WORK_STATION WHERE WORK_STATION_ADDRESS IN (SELECT WORK_STATION_ADDRESS FROM @Info))
print 'Delete existing devices'
DELETE FROM VG48251.DEVICE WHERE DEVICE_HOST_NAME IN (SELECT DEVICE_NAME FROM @Info)
print ''
print 'Start Inserting Users Infos'
print '/*************************** AD_USER AND AD_USERGROUP ****************************************/'
INSERT [VG48251].[AD_USER] ([ADUSER_DOMAIN], [ADUSER_USERID], [ADUSER_GROUP], [ADUSER_ENABLED], [ADUSER_FIRSTNAME], [ADUSER_LASTNAME], [ADUSER_MIDDLENAME], [ADUSER_EMAILID], [IS_SUPER_ADMIN], [IS_FIRST_LOGIN], [EXTERNAL_PASSWORD])
SELECT [ADUSER_DOMAIN], N'3bc02b62-309a-4b2a-a9ad-67d60783c871', N'Clerk', 1, [ADUSER_FIRSTNAME], [ADUSER_LASTNAME], NULL, [ADUSER_EMAILID], 0, 0, NULL FROM  @Info
WHERE [ADUSER_DOMAIN] NOT IN (SELECT [ADUSER_DOMAIN] FROM [VG48251].[AD_USER])
INSERT [VG48251].[AD_USER_AD_USERGROUP] ( [ADUSER_ID], [AD_USERGROUP_ID], [UG_DEFAULT])
SELECT au.ADUSER_ID, 2, 1 FROM [VG48251].[AD_USER] au
INNER JOIN @Info i ON au.[ADUSER_DOMAIN] = i.[ADUSER_DOMAIN]
WHERE au.[ADUSER_ENABLED] = 1 AND au.ADUSER_ID NOT IN (SELECT ISNULL(ADUSER_ID, 0) FROM [VG48251].[AD_USER_AD_USERGROUP])
print'/*************************** WORK_STATION AND LOCATION ****************************************/'
INSERT [VG48251].[WORK_STATION] ( [WORK_STATION_NAME], [WORK_STATION_ADDRESS], [WORK_STATION_DESC], [WS_ENABLED])
SELECT [WORK_STATION_NAME], [WORK_STATION_ADDRESS], N'workstation', 1 FROM  @Info WHERE [WORK_STATION_NAME] NOT IN (SELECT [WORK_STATION_NAME] FROM [VG48251].[WORK_STATION])
INSERT [VG48251].[LOCATION_WORK_STATION] ( LOCATION_ID, [WORK_STATION_ID], [LWS_ENABLED])
SELECT 2, w.[WORK_STATION_ID], 1 FROM [VG48251].[WORK_STATION] w
INNER JOIN @Info i ON w.[WORK_STATION_NAME] = i.[WORK_STATION_NAME]
WHERE w.[WS_ENABLED] = 1 AND w.WORK_STATION_ID NOT IN (SELECT ISNULL(WORK_STATION_ID, 0) FROM [VG48251].[LOCATION_WORK_STATION])
print'/****************************** DEVICE **************************************************************/'
DECLARE @Devices table
(
       [DEVICE_ID] INT,
       [DEVICE_HOST_NAME] nvarchar(250)
);
DECLARE @DeviceService INT = 1
INSERT INTO [VG48251].[DEVICE]
    ([DEVICE_HOST_NAME],[DEVICE_HOST_ADDR],[DEVICE_DESC],[DEVICE_TYPE_ID],[DEVICE_ACTIVE],[DEVICE_STATUS_ID],[CONFIG_ID],DEVICE_SERVICE_ID)
OUTPUT INSERTED.DEVICE_ID, INSERTED.DEVICE_HOST_NAME INTO @Devices(DEVICE_ID, DEVICE_HOST_NAME)
SELECT [DEVICE_NAME], N'test', 'Drawer', 1,1,1,NULL,@DeviceService FROM @Info
WHERE [DEVICE_NAME] NOT IN (SELECT DEVICE_HOST_NAME FROM [VG48251].[DEVICE] WHERE [DEVICE_TYPE_ID] = 1)
INSERT INTO [VG48251].[DEVICE]
    ([DEVICE_HOST_NAME],[DEVICE_HOST_ADDR],[DEVICE_DESC],[DEVICE_TYPE_ID],[DEVICE_ACTIVE],[DEVICE_STATUS_ID],[CONFIG_ID],DEVICE_SERVICE_ID)
OUTPUT INSERTED.DEVICE_ID, INSERTED.DEVICE_HOST_NAME INTO @Devices(DEVICE_ID, DEVICE_HOST_NAME)
SELECT [DEVICE_NAME], [WORK_STATION_ADDRESS], 'Microsoft XPS Document Writer', 2, 1, 1, NULL, @DeviceService FROM @Info
WHERE [DEVICE_NAME] NOT IN (SELECT DEVICE_HOST_NAME FROM [VG48251].[DEVICE] WHERE [DEVICE_TYPE_ID] = 2)
INSERT INTO [VG48251].[DEVICE]
    ([DEVICE_HOST_NAME],[DEVICE_HOST_ADDR],[DEVICE_DESC],[DEVICE_TYPE_ID],[DEVICE_ACTIVE],[DEVICE_STATUS_ID],[CONFIG_ID],DEVICE_SERVICE_ID)
OUTPUT INSERTED.DEVICE_ID, INSERTED.DEVICE_HOST_NAME INTO @Devices(DEVICE_ID, DEVICE_HOST_NAME)
SELECT [DEVICE_NAME], N'test', 'Label Printer', 3,1,1,NULL,@DeviceService FROM @Info
WHERE [DEVICE_NAME] NOT IN (SELECT DEVICE_HOST_NAME FROM [VG48251].[DEVICE] WHERE [DEVICE_TYPE_ID] = 3)
INSERT INTO [VG48251].[DEVICE]
    ([DEVICE_HOST_NAME],[DEVICE_HOST_ADDR],[DEVICE_DESC],[DEVICE_TYPE_ID],[DEVICE_ACTIVE],[DEVICE_STATUS_ID],[CONFIG_ID],DEVICE_SERVICE_ID)
OUTPUT INSERTED.DEVICE_ID, INSERTED.DEVICE_HOST_NAME INTO @Devices(DEVICE_ID, DEVICE_HOST_NAME)
SELECT [DEVICE_NAME], N'test', 'Receipt Printer', 4,1,1,NULL,@DeviceService FROM @Info
WHERE [DEVICE_NAME] NOT IN (SELECT DEVICE_HOST_NAME FROM [VG48251].[DEVICE] WHERE [DEVICE_TYPE_ID] = 4)
INSERT INTO [VG48251].[DEVICE]
    ([DEVICE_HOST_NAME],[DEVICE_HOST_ADDR],[DEVICE_DESC],[DEVICE_TYPE_ID],[DEVICE_ACTIVE],[DEVICE_STATUS_ID],[CONFIG_ID],DEVICE_SERVICE_ID)
OUTPUT INSERTED.DEVICE_ID, INSERTED.DEVICE_HOST_NAME INTO @Devices(DEVICE_ID, DEVICE_HOST_NAME)
SELECT [DEVICE_NAME], N'test', 'Signature Pad', 7,1,1,NULL,@DeviceService FROM @Info
WHERE [DEVICE_NAME] NOT IN (SELECT DEVICE_HOST_NAME FROM [VG48251].[DEVICE] WHERE [DEVICE_TYPE_ID] = 7)
INSERT INTO [VG48251].[DEVICE]
    ([DEVICE_HOST_NAME],[DEVICE_HOST_ADDR],[DEVICE_DESC],[DEVICE_TYPE_ID],[DEVICE_ACTIVE],[DEVICE_STATUS_ID],[CONFIG_ID],DEVICE_SERVICE_ID)
OUTPUT INSERTED.DEVICE_ID, INSERTED.DEVICE_HOST_NAME INTO @Devices(DEVICE_ID, DEVICE_HOST_NAME)
SELECT [DEVICE_NAME], N'test', 'Magnetic Card Reader', 8, 1,1,NULL,@DeviceService FROM @Info
WHERE [DEVICE_NAME] NOT IN (SELECT DEVICE_HOST_NAME FROM [VG48251].[DEVICE] WHERE [DEVICE_TYPE_ID] = 8)
INSERT INTO [VG48251].[DEVICE]
    ([DEVICE_HOST_NAME],[DEVICE_HOST_ADDR],[DEVICE_DESC],[DEVICE_TYPE_ID],[DEVICE_ACTIVE],[DEVICE_STATUS_ID],[CONFIG_ID],DEVICE_SERVICE_ID)
OUTPUT INSERTED.DEVICE_ID, INSERTED.DEVICE_HOST_NAME INTO @Devices(DEVICE_ID, DEVICE_HOST_NAME)
SELECT [DEVICE_NAME], N'test', 'Slip Printer', 9,1,1,NULL,@DeviceService FROM @Info
WHERE [DEVICE_NAME] NOT IN (SELECT DEVICE_HOST_NAME FROM [VG48251].[DEVICE] WHERE [DEVICE_TYPE_ID] = 1)
INSERT INTO [VG48251].[WORK_STATION_DEVICE] ([DEVICE_ID] ,[WORK_STATION_ID],[WSD_ENABLED],[IS_DEFAULT])
SELECT D.DEVICE_ID, w.[WORK_STATION_ID], 1, 1 FROM [VG48251].[WORK_STATION] w
INNER JOIN @Info i ON w.[WORK_STATION_ADDRESS] = i.[WORK_STATION_ADDRESS]
INNER JOIN @Devices AS D ON D.DEVICE_HOST_NAME = I.[DEVICE_NAME]
WHERE D.[DEVICE_ID] NOT IN (SELECT ISNULL(DEVICE_ID, 0) FROM [VG48251].[WORK_STATION_DEVICE] WHERE [WORK_STATION_ID] = W.WORK_STATION_ID)
INSERT INTO [VG48251].[DEVICE]
    ([DEVICE_HOST_NAME],[DEVICE_HOST_ADDR],[DEVICE_DESC],[DEVICE_TYPE_ID],[DEVICE_ACTIVE],[DEVICE_STATUS_ID],[CONFIG_ID],DEVICE_SERVICE_ID)
OUTPUT INSERTED.DEVICE_ID, INSERTED.DEVICE_HOST_NAME INTO @Devices(DEVICE_ID, DEVICE_HOST_NAME)
SELECT [DEVICE_NAME], N'Agent Drawer', 'Agent Drawer', 1,1,1,NULL,@DeviceService FROM @Info
WHERE [DEVICE_NAME] NOT IN (SELECT DEVICE_HOST_NAME FROM [VG48251].[DEVICE] WHERE [DEVICE_TYPE_ID] = 1 AND [DEVICE_DESC] = 'Agent Drawer')
INSERT INTO VG48251.AD_USER_DEVICE ( DEVICE_ID , ADUSER_ID , WSD_ENABLED , IS_DEFAULT )
SELECT  d.DEVICE_ID, a.ADUSER_ID , 1, 1 FROM [VG48251].[AD_USER] a
INNER JOIN @Info i ON a.ADUSER_DOMAIN = i.ADUSER_DOMAIN
INNER JOIN [VG48251].[DEVICE] AS D ON D.[DEVICE_DESC] = 'Agent Drawer' and a.ADUSER_DOMAIN = D.device_host_name
print'/****************************** CRS_SECURITY **************************************************************/'
INSERT INTO [VG48251].[CRS_SECURITY_AD_USERGROUP] ([AU_UG_ID],[CRS_SECURABLE_ID],[CRS_SECURITY_AD_USERGROUP_ALLOW_ALL],[CRS_SECURITY_AD_USERGROUP_SECURABLE_PK],[CRS_SECURITY_AD_USERGROUP_ADMIN_ONLY])
SELECT 1, 7, 0, D.DEVICE_ID, 0  FROM @Devices D
INNER JOIN @Info I ON D.DEVICE_HOST_NAME = I.[DEVICE_NAME]
WHERE d.[DEVICE_ID] NOT IN (SELECT ISNULL(CRS_SECURITY_AD_USERGROUP_SECURABLE_PK, 0) FROM [VG48251].[CRS_SECURITY_AD_USERGROUP] WHERE AU_UG_ID = 1 AND CRS_SECURABLE_ID = 7)
INSERT INTO [VG48251].[CRS_SECURITY_AD_USERGROUP] ([AU_UG_ID],[CRS_SECURABLE_ID],[CRS_SECURITY_AD_USERGROUP_ALLOW_ALL],[CRS_SECURITY_AD_USERGROUP_SECURABLE_PK],[CRS_SECURITY_AD_USERGROUP_ADMIN_ONLY])
SELECT 2, 7, 0, D.DEVICE_ID, 0  FROM @Devices D
WHERE  d.[DEVICE_ID] NOT IN (SELECT ISNULL(CRS_SECURITY_AD_USERGROUP_SECURABLE_PK, 0) FROM [VG48251].[CRS_SECURITY_AD_USERGROUP] WHERE AU_UG_ID = 2 AND CRS_SECURABLE_ID = 7)
INSERT INTO [VG48251].[CRS_SECURITY_AD_USERGROUP] ([AU_UG_ID],[CRS_SECURABLE_ID],[CRS_SECURITY_AD_USERGROUP_ALLOW_ALL],[CRS_SECURITY_AD_USERGROUP_SECURABLE_PK],[CRS_SECURITY_AD_USERGROUP_ADMIN_ONLY])
SELECT 3, 7, 0, D.DEVICE_ID, 0  FROM @Devices D
INNER JOIN @Info I ON D.DEVICE_HOST_NAME = I.[DEVICE_NAME]
WHERE d.[DEVICE_ID] NOT IN (SELECT ISNULL(CRS_SECURITY_AD_USERGROUP_SECURABLE_PK, 0) FROM [VG48251].[CRS_SECURITY_AD_USERGROUP] WHERE AU_UG_ID = 3 AND CRS_SECURABLE_ID = 7)
INSERT INTO [VG48251].[CRS_SECURITY_AD_USERGROUP] ([AU_UG_ID],[CRS_SECURABLE_ID],[CRS_SECURITY_AD_USERGROUP_ALLOW_ALL],[CRS_SECURITY_AD_USERGROUP_SECURABLE_PK],[CRS_SECURITY_AD_USERGROUP_ADMIN_ONLY])
SELECT 4, 7, 0, D.DEVICE_ID, 0  FROM @Devices D
INNER JOIN @Info I ON D.DEVICE_HOST_NAME = I.[DEVICE_NAME]
WHERE d.[DEVICE_ID] NOT IN (SELECT ISNULL(CRS_SECURITY_AD_USERGROUP_SECURABLE_PK, 0) FROM [VG48251].[CRS_SECURITY_AD_USERGROUP] WHERE AU_UG_ID = 4 AND CRS_SECURABLE_ID = 7)
INSERT INTO [VG48251].[CRS_SECURITY_LOCATION] ([LOCATION_ID],[CRS_SECURABLE_ID],[CRS_SECURITY_LOCATION_ALLOW_ALL],[CRS_SECURITY_LOCATION_SECURABLE_PK],[CRS_SECURITY_LOCATION_ADMIN_ONLY])
SELECT 2, 7, 0, D.DEVICE_ID, 0  FROM @Devices D
INNER JOIN @Info I ON D.DEVICE_HOST_NAME = I.[DEVICE_NAME]
WHERE d.[DEVICE_ID] NOT IN (SELECT ISNULL([CRS_SECURITY_LOCATION_SECURABLE_PK], 0) FROM [VG48251].[CRS_SECURITY_LOCATION] WHERE [LOCATION_ID] = 2 AND CRS_SECURABLE_ID = 7)
INSERT INTO [VG48251].[CRS_SECURITY_LOCATION] ([LOCATION_ID],[CRS_SECURABLE_ID],[CRS_SECURITY_LOCATION_ALLOW_ALL],[CRS_SECURITY_LOCATION_SECURABLE_PK],[CRS_SECURITY_LOCATION_ADMIN_ONLY])
SELECT 3, 7, 0, D.DEVICE_ID, 0  FROM @Devices D
INNER JOIN @Info I ON D.DEVICE_HOST_NAME = I.[DEVICE_NAME]
WHERE d.[DEVICE_ID] NOT IN (SELECT ISNULL([CRS_SECURITY_LOCATION_SECURABLE_PK], 0) FROM [VG48251].[CRS_SECURITY_LOCATION] WHERE [LOCATION_ID] = 3 AND CRS_SECURABLE_ID = 7)
INSERT INTO [VG48251].[CRS_SECURITY_WORKSTATION] ([WORK_STATION_ID],[CRS_SECURABLE_ID],[CRS_SECURITY_WORKSTATION_ALLOW_ALL],[CRS_SECURITY_WORKSTATION_SECURABLE_PK],[CRS_SECURITY_WORKSTATION_ADMIN_ONLY])
SELECT  w.WORK_STATION_ID, 7, 0, d.DEVICE_ID, 0 FROM @Devices D
INNER JOIN @Info I ON D.DEVICE_HOST_NAME = I.[DEVICE_NAME]
INNER JOIN [VG48251].[WORK_STATION] w ON w.[WORK_STATION_NAME] = i.[WORK_STATION_NAME]
WHERE d.[DEVICE_ID] NOT IN (SELECT ISNULL([CRS_SECURITY_WORKSTATION_SECURABLE_PK], 0) FROM [VG48251].[CRS_SECURITY_WORKSTATION] WHERE WORK_STATION_ID = W.WORK_STATION_ID AND CRS_SECURABLE_ID = 7)
