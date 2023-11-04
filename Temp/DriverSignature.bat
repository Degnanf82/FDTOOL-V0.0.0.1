@echo off
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do (
	set VersionMajor=%%i
	set VersionMinor=%%j
)
echo Windows Version = %VersionMajor%.%VersionMinor%
if %VersionMajor% == 10 goto win8orlater 
if %VersionMajor% == 6 (
  if %VersionMinor% == 2 goto win7
  if %VersionMinor% == 1 goto win7
  goto win8orlater
)

endlocal

pause
exit

:win7
bcdedit /set loadoptions DISABLE_INTEGRITY_CHECKS
bcdedit.exe /set TESTSIGNING ON
ECHO We will now reboot the computer
pause
shutdown -r -t 0

exit

:win8orlater
ECHO ======================================================================
ECHO On next boot please do the following steps:
ECHO  - Select Troubleshoot.
ECHO  - Select Advanced options.
ECHO  - Select Startup Settings.
ECHO  - Click on Restart.
ECHO  - On the Startup Settings screen press 7 or F7 to disable driver signature enforcement. 
ECHO ======================================================================
ECHO We will now reboot the computer
pause
shutdown -r -o -f -t 0