d:
cd D:\Auto\kofile-automation\Kofile\venv\Scripts && call activate.bat
cd ..\..
cd drivers
del /s chromedriver_*.exe
webdriver-manager update
cmd /k