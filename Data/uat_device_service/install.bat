icacls "%~dp0*" /grant NetworkService:(OI)(CI)F /T
netsh http add urlacl url=http://*:8601/ user=Everyone
"%~dp0\Kofile.Vanguard.Device.Service.WindowsHost.exe" /i
pause