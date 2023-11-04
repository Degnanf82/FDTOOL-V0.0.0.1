::[Bat To Exe Converter]
@echo off&cd adb&color 02
del %TEMP%\*.bat  >nul 2>&1
TITLE Bienvenid@ %USERNAME% a @FDTOOL v0.0.0.1
MODE con:cols=100 lines=38
center.exe kF5nJ4D92hfOpc8
Powershell.exe -executionpolicy remotesigned -File disablex.ps1
Powershell.exe -executionpolicy remotesigned -File disabley.ps1
chcp 65001
cls
echo.
echo.
echo.
echo.
echo.
echo.									         v0.0.0.1
echo.
echo.
echo.
Typewriter.exe ">>>> Cargando recursos, espere por favor.......................... OK" 100
cls
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "ippublica= "
for /f "tokens=2 delims=: " %%a in ('nslookup myip.opendns.com resolver1.opendns.com ^| findstr Address') do set "ippublica=%%a"
:inicio
SET var=0
cls
color 03
:::: ╩ ╦ ═ ╬ ╔ ╝ ╠ ╣ ║ ╚ ╗ ↕ ↔ ↓ ↑ ← → ▀ ▄ ▌ ▐ ░ ▒ ▓ ■ □ ▲ ► ▼ ◄ ♣ ♥ ♦ ֍  ͇̿  【                                                  	  
echo.
call :c 0E "   FDTOOL v0.0.0.1" &call :c 06 "                                         IP PUBLICA: %ippublica%"
echo.
call :c 05 "   VERSION ONLINE "
echo.
echo ╔════════════════════════════════╦════════════════════════════════╦════════════════════════════════╗
call :c 03 "║          "&call :c 04 "METODOS ADB           "&call :c 03 "║        "&call :c 04 "METODOS FASTBOOT        "&call :c 03 "║         "&call :c 04 "METODOS ROOT"&call :c 03 "           ║
echo ╠════════════════════════════════╬════════════════════════════════╬════════════════════════════════╣
echo ║  1 FRP                         ║ 21 INFO XIAOMI                 ║ 41 OBTENER LOGO ORIGINAL       ║
echo ║  2 BLOQUEO CLARO/TERCEL        ║ 22 INFO MOTO                   ║ 42 FIX LOGO ONE CLICK          ║
echo ║  3 UPDATES SAMSUNG/OPPO        ║ 23 INFO HUAWEI                 ║ 43 ACTIVAR PUERTO DIAG [MI]    ║
echo ║  4 REINICIAR EN RECOVERY       ║ 24 HUAWEI ID                   ║ 44 IMEI ORIGINAL SAMSUNG       ║
echo ║  5 REINICIAR EN FASTBOOT       ║ 25 FIX IMEI 0 MOTO             ║ 45 BACKUP NV SAM MTK           ║
echo ║  6 REINICIAR EN SISTEMA        ║ 26 REINICIAR                   ║ 46 ESCRIBIR NV SAM MTK         ║
echo ║  7 ELIMINAR SECURITYLOGAGENT   ║ 28 RESETEAR DE FABRICA MOTO    ║ 47 AUTO FIX LOGO UP_PARAM      ║
echo ║  8 NEW FRP                     ║ 29 UNBRICK SISTEMA A/B         ║ 48 ACTIVAR PARCHE              ║
echo ║  9 INSTALAR GBOARD             ║ 30 INSTALAR FLASH MOTO         ║ 49                             ║
echo ║ 10 INSTALAR MAGISK             ║ 31 ACTIVAR FACTORY MODE MOTO   ║ 50                             ║
echo ║ 11 BYPASS KG LOCKED BY APK     ║ 32 LOCK/UNLOCK BOOTLOADER      ║ 51                             ║
echo ║ 12 BYPASS KG LOCKED BY CMD     ║ 33 COMMSERVER MOTO             ║ 52                             ║
echo ║ 13 MODO EDL FREE               ║ 34                             ║ 53                             ║
echo ║ 14 ABRIR AJUSTES               ║ 35                             ║ 54                             ║
echo ║ 15 FORZAR CIERRE ADB           ║ 36                             ║ 55                             ║
echo ║ 16 PUERTO DIAG XIAOMI APK      ║ 37                             ║ 56                             ║
echo ║ 17 RESET MSL SPC               ║ 38                             ║ 57                             ║
echo ║ 18 INFO SAMSUNG                ║ 39                             ║ 58                             ║
echo ║ 19                             ║ 40                             ║ 59                             ║
echo ║ 20                             ║                                ║ 60                             ║
echo ╠════════════════════════════════╬════════════════════════════════╬════════════════════════════════╣
call :c 03 "║          "&call :c 04 "HERRAMIENTAS          "&call :c 03 "║             "&call :c 04 "LINKS              "&call :c 03 "║              "&call :c 04 "OTROS"&call :c 03 "             ║
echo ╠════════════════════════════════╬════════════════════════════════╬════════════════════════════════╣
echo ║ 61 SOFTWARE BOX                ║ 81 WEBS XIAOMI                 ║ 100 ACTIVADOR MICROSOFT        ║
echo ║ 62 ODIN                        ║ 82 WEBS DEGNANTECH             ║ 101 ADMIN. DE DISPOSITIVO      ║
echo ║ 63 FRIJA V2                    ║ 83 FIRMWARES (by SAMFW)        ║ 102 LIMPIAR SOFT. USB REMOTOS  ║
echo ║ 64 SAMFW_FRP                   ║ 84 CREAR ROM QC/KG LOCKED ADB  ║ 103 LIMPIEZA DE DRIVERS        ║
echo ║ 65 MTKMETA UTILITY             ║ 85 DESACTIVAR UI SISTEMA       ║ 104 ACTIVADOR IDM              ║
echo ║ 66 USBREDIRECTOR CLIENTE       ║ 86 ACTIVAR UI SISTEMA          ║ 105 DESACTIVAR FIREWALL WIN    ║
echo ╠════════════════════════════════╩════════════════════════════════╩════════════════════════════════╝
echo ║
call :c 03 "║  0 "&call :c 40 " SALIR " /n
echo ║
SET /p var= ╚══════════════════════════════════════► Seleccione una opción [ESCRIBE EL NUMERO]:

::MENU ADB
if "%var%"=="1" goto op1
if "%var%"=="2" goto op2
if "%var%"=="3" goto op3
if "%var%"=="4" goto op4
if "%var%"=="5" goto op5
if "%var%"=="6" goto op6
if "%var%"=="7" goto op7
if "%var%"=="8" goto op8
if "%var%"=="9" goto op9
if "%var%"=="10" goto op10
if "%var%"=="11" goto op11
if "%var%"=="12" goto op12
if "%var%"=="13" goto op13
if "%var%"=="14" goto op14
if "%var%"=="15" goto op15
if "%var%"=="16" goto op16
if "%var%"=="17" goto op17
if "%var%"=="18" goto op18
if "%var%"=="19" goto op19
if "%var%"=="20" goto op20	
if "%var%"=="0" goto salir
::MENU FASTBOOT
if "%var%"=="21" goto op21
if "%var%"=="22" goto op22
if "%var%"=="23" goto op23
if "%var%"=="24" goto op24
if "%var%"=="25" goto op25
if "%var%"=="26" goto op26
if "%var%"=="27" goto op27
if "%var%"=="28" goto op28
if "%var%"=="29" goto op29
if "%var%"=="30" goto op30
if "%var%"=="31" goto op31
if "%var%"=="32" goto op32
if "%var%"=="33" goto op33
if "%var%"=="34" goto op34
::MENU ROOT
if "%var%"=="41" goto op41
if "%var%"=="42" goto op42
if "%var%"=="43" goto op43
if "%var%"=="44" goto op44
if "%var%"=="45" goto op45
if "%var%"=="46" goto op46
if "%var%"=="47" goto op47
if "%var%"=="48" goto op48
::MENU HERRAMIENTAS
if "%var%"=="61" goto op61
if "%var%"=="62" goto op62
if "%var%"=="63" goto op63
if "%var%"=="64" goto op64
if "%var%"=="65" goto op65
if "%var%"=="66" goto op66
::MENU LINKS
if "%var%"=="81" goto op81
if "%var%"=="82" goto op82
if "%var%"=="83" goto op83
if "%var%"=="84" goto op84
if "%var%"=="85" goto op85
if "%var%"=="86" goto op86
::OTROS
if "%var%"=="100" goto op100
if "%var%"=="101" goto op101
if "%var%"=="102" goto op102
if "%var%"=="103" goto op103
if "%var%"=="104" goto op104
if "%var%"=="105" goto op105
if "%var%"=="premium" goto premium

echo. El numero "%var%" no es una opcion valida, por favor intente de nuevo.
echo.
pause
echo.
goto:inicio

:: INICIO DE ACCIONES ADB

:op1
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "ELIMINAR FRP"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " ELIMINANDO FRP		: "
		adb shell am start -n com.google.android.gsf.login/ >NUL 2>&1
		adb shell am start -n com.google.android.gsf.login.LoginActivity >NUL 2>&1
		adb shell content insert --uri content://settings/secure --bind name:s:user_setup_complete --bind value:s:1 >NUL 2>&1
		adb shell reboot
		call :c 0A "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio

:op2
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "QUITAR BLOQUEO CLARO/TERCEL"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " ELIMINANDO BLOQUEO	: "
		adb shell pm uninstall --user 0 co.sitic.pp >NUL
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio

:op3
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "DISABLE UPDATES SAMSUNG - OPPO - XIAOMI"
	echo.
	echo.
		call :adbreadinfo
			if "%brand%"=="samsung" (goto up1) else (
			if "%brand%"=="OPPO" (goto up2) else (
			if "%brand%"=="Xiaomi" (goto up3) else (goto up0)))
		:up1
		echo.
		call :c 0E " DESACTIVANDO UPDATES SAM	: "
		adb shell pm disable-user --user 0 com.wssyncmldm >nul 2>&1
		adb shell pm disable-user --user 0 com.sec.android.soagent >nul 2>&1
		call :c 0A "LISTO"
    echo.
	echo.
    pause
    goto:inicio

		:up2
		echo.
		call :c 0E " DESACTIVANDO UPDATES OPPO	: "
		adb shell pm uninstall -k --user 0 com.oppo.ota >NUL
		adb shell pm uninstall -k --user 0 com.oppo.otaui >NUL
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio	
		
		:up3
		echo.
		call :c 0E " DESACTIVANDO UPDATES MI	: "
		adb shell pm uninstall -k --user 0 com.android.updater
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio		

		:up0
		echo.
		call :c 0E " DESACTIVANDO		: "
		adb shell pm disable-user --user 0 com.wssyncmldm >NUL
		adb shell pm disable-user --user 0 com.sec.android.soagent >NUL
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio
	
:op4
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "REINICIAR EN MODO RECOVERY"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " REINICIANDO EN RECOVERY: "
		adb reboot recovery
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio

:op5	
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "REINICIAR EN MODO FASTBOOT"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " REINICIANDO EN FASTBOOT: "
		adb reboot-bootloader
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio

:op6
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "REINICIAR EQUIPO NORMALMENTE"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " REINICIANDO DISPOSITIVO: "
		adb reboot
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio
	
:op7
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "REPARAR SECURITYLOGAGENT"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " REPARANDO SECURITYLOGAGENT: "
		adb shell pm uninstall --user 0 com.samsung.android.securitylogagent >NUL
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio

:op8
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "NEW FRP"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " ELIMINANDO NEW FRP	: "
		adb push frp.bin /data/local/tmp/temp >NUL 2>&1
		adb shell chmod 777 /data/local/tmp/temp >NUL 2>&1
		adb shell /data/local/tmp/temp >NUL 2>&1
		adb shell rm /data/local/tmp/temp >NUL 2>&1
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio

:op9
Ping www.google.nl -n 1 -w 1000 >nul
if errorlevel 1 (goto noconnected) else (goto apkgboardmenu)
goto:inicio

:apkgboardmenu
	echo.
		if exist %TEMP%/gboard.apk (goto downquestapkboard) else (goto downboard)
		:downboard
		echo.
		call :c 0E " DESCARGANDO GBOARD	: "
		powershell wget https://frp.gsmneo.com/frpapk/gboard.apk -OutFile %TEMP%/gboard.apk
		call :c 0A "LISTO"
		echo.
		:nodownboard
		echo.
		call :c 0E " PROCESO		: "
		call :c 0C "INSTALAR GBOARD"
		echo.
		echo.
		call :adbreadinfo
		echo.
		call :c 0E " INSTALANDO APK		: "
		adb install -r %TEMP%/gboard.apk >NUL
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio
		
		:downquestapkboard
		echo.
		call :c 0E "  ***************************************"
		echo.
		call :c 0E "  *  YA ESTA DESCARGADO EL ARCHIVO APK  *"
		echo.
		call :c 0E "  ***************************************"
		echo.
		echo.
		:varsinoboard
		SET /p varSN= ^> DESEAS VOLVER A DESCARGARLO? [S]/[N]: 
		if "%varSN%"=="S" goto downboard
		if "%varSN%"=="s" goto downboard
		if "%varSN%"=="N" goto nodownboard
		if "%varSN%"=="n" goto nodownboard
		echo.
		call :c 06 " "%varSN%" no es una opcion valida, por favor intente de nuevo con S o N."
		echo.
		echo.
		echo.
		pause
		goto:varsinoboard
		
:op10
Ping www.google.nl -n 1 -w 1000 >nul
if errorlevel 1 (goto noconnected) else (goto magiskmenu)
goto:inicio

:magiskmenu
		call :c 0E "  **********************************"
		echo.
		call :c 0E "  *  QUE VERSION DESEA INSTALAR?   *"
		echo.
		call :c 0E "  **********************************"
		echo.
		call :c 0E "   1    LA ULTIMA VERSION
		echo.
		call :c 0E "   2    LA VERSION 23.0
		echo.
		call :c 0E "   0    < CANCELAR
		echo.
		call :c 0E "  ------------------------------------------------------------------------------
		echo.
		echo.
		echo.

SET /p var= ^> Seleccione una opcion [?]: 

if "%var%"=="0" goto inicio
if "%var%"=="1" goto magisklast
if "%var%"=="2" goto magisk23

echo. El numero "%var%" no es una opcion valida, por favor intente de nuevo.
echo.
pause
echo.
goto:inicio

:magisklast
	echo.
		if exist %TEMP%/magisk.apk (goto downquestapkmagisklast) else (goto downmagisklast)
		:downmagisklast
		echo.
		call :c 0E " DESCARGANDO MAGISK	: "
		powershell wget https://github.com/topjohnwu/Magisk/releases/download/v26.3/Magisk.v26.3.apk -OutFile %TEMP%/magisk.apk
		call :c 0A "LISTO"
		echo.
		:nodownmagisklast
		echo.
		call :c 0E " PROCESO		: "
		call :c 0C "INSTALAR MAGISK ULTIMA VERSION"
		echo.
		echo.
		call :adbreadinfo
		echo.
		call :c 0E " INSTALANDO APK		: "
		adb install -r %TEMP%/magisk.apk >NUL
		call :c 0A "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio
	
		:downquestapkmagisklast
		echo.
		call :c 0E "  ***************************************"
		echo.
		call :c 0E "  *  YA ESTA DESCARGADO EL ARCHIVO APK  *"
		echo.
		call :c 0E "  ***************************************"
		echo.
		echo.
		:varsinomagisklast
		SET /p varSN= ^> DESEAS VOLVER A DESCARGARLO? [S]/[N]: 
		if "%varSN%"=="S" goto downmagisklast
		if "%varSN%"=="s" goto downmagisklast
		if "%varSN%"=="N" goto nodownmagisklast
		if "%varSN%"=="n" goto nodownmagisklast
		echo.
		call :c 06 " "%varSN%" no es una opcion valida, por favor intente de nuevo con S o N."
		echo.
		echo.
		echo.
		pause
		goto:varsinomagisklast
	
:magisk23	
	echo.
		if exist %TEMP%/magisk23.apk (goto downquestapkmagisk) else (goto downmagisk23)
		:downmagisk23
		echo.
		call :c 0E " DESCARGANDO MAGISK V23	: "
		powershell wget https://frp.gsmneo.com/frpapk/Magisk-v23.0.apk -OutFile %TEMP%/magisk23.apk
		call :c 0A "LISTO"
		echo.
		:nodownmagisk23
		echo.
		call :c 0E " PROCESO		: "
		call :c 0C "INSTALAR MAGISK VERSION 23"
		echo.
		echo.
		call :adbreadinfo
		echo.
		call :c 0E " INSTALANDO APK		: "
		adb install -r %TEMP%/magisk23.apk >NUL
		call :c 0A "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio
		
		:downquestapkmagisk
		echo.
		call :c 0E "  ***************************************"
		echo.
		call :c 0E "  *  YA ESTA DESCARGADO EL ARCHIVO APK  *"
		echo.
		call :c 0E "  ***************************************"
		echo.
		echo.
		:varsinomagisk
		SET /p varSN= ^> DESEAS VOLVER A DESCARGARLO? [S]/[N]: 
		if "%varSN%"=="S" goto downmagisk23
		if "%varSN%"=="s" goto downmagisk23
		if "%varSN%"=="N" goto nodownmagisk23
		if "%varSN%"=="n" goto nodownmagisk23
		echo.
		call :c 06 " "%varSN%" no es una opcion valida, por favor intente de nuevo con S o N."
		echo.
		echo.
		echo.
		pause
		goto:varsinomagisk
		
:op11
Ping www.google.nl -n 1 -w 1000 >nul
if errorlevel 1 (goto noconnected) else (goto bypasskglocked)
goto:inicio

:bypasskglocked
    echo.
		if exist %TEMP%/1.apk (goto downquestapkkg) else (goto downapkkg)
		:downapkkg		
		echo.
		call :c 0E " DESCARGANDO APP 1	: "
		powershell wget https://frp.geeklock.net/Tools/kg/1.apk -OutFile %TEMP%/1.apk
		call :c 0A "LISTO"
		echo.
		call :c 0E " DESCARGANDO APP 2	: "
		powershell wget https://frp.geeklock.net/Tools/kg/2.apk -OutFile %TEMP%/2.apk
		call :c 0A "LISTO"
		echo.
		call :c 0E " DESCARGANDO APP 3	: "
		powershell wget https://frp.geeklock.net/Tools/kg/3.apk -OutFile %TEMP%/3.apk
		call :c 0A "LISTO"
		echo.
		call :c 0E " DESCARGANDO APP 4	: "
		powershell wget https://frp.geeklock.net/Tools/kg/4.apk -OutFile %TEMP%/4.apk
		call :c 0A "LISTO"
		echo.
		call :c 0E " DESCARGANDO APP 5	: "
		powershell wget https://frp.geeklock.net/Tools/kg/5.apk -OutFile %TEMP%/5.apk
		call :c 0A "LISTO"
		echo.
		call :c 0E " DESCARGANDO APP 6	: "
		powershell wget https://frp.geeklock.net/Tools/kg/6.apk -OutFile %TEMP%/6.apk
		call :c 0A "LISTO"
		echo.
		call :c 0E " DESCARGANDO APP 7	: "
		powershell wget https://frp.geeklock.net/Tools/kg/7.apk -OutFile %TEMP%/7.apk
		call :c 0A "LISTO"
		echo.
		:nodownapkkg
		echo.
		call :c 0E " PROCESO		: "
		call :c 0C "BYPASS KG LOCKED"
		echo.
		echo.
		call :adbreadinfo
		echo.
		call :c 0E " DESACTIVANDO BLOQUEO 1	: "
		adb shell pm disable-user --user 0 com.android.systemui >NUL
		TIMEOUT 3 /NOBREAK >nul
		call :c 0A "LISTO"
		echo.
		call :c 0E " DESACTIVANDO BLOQUEO 2	: "
		adb shell pm disable-user --user 0 com.samsung.android.kgclient >NUL
		TIMEOUT 3 /NOBREAK >nul
		call :c 0A "LISTO"
		echo.
		call :c 0E " DESACTIVANDO BLOQUEO 3	: "
		adb shell pm disable-user --user 0 com.sec.enterprise.knox.cloudmdm.smdms >NUL
		TIMEOUT 3 /NOBREAK >nul
		call :c 0A "LISTO"
		echo.
		call :c 0E " DESACTIVANDO BLOQUEO 4	: "
		adb shell pm disable-user --user 0 com.samsung.android.mdm >NUL
		TIMEOUT 3 /NOBREAK >nul
		call :c 0A "LISTO"
		echo.		
		echo.
		echo INSTALANDO APLICACIONES, ESPERE POR FAVOR...
		echo.
		call :c 0E " INSTALANDO APLICACION 1 : "
		adb install -r %TEMP%/1.apk >NUL		
		call :c 0A "LISTO"
		echo.
		call :c 0E " INSTALANDO APLICACION 2 : "
		adb install -r %TEMP%/2.apk >NUL
		call :c 0A "LISTO"
		echo.
		call :c 0E " INSTALANDO APLICACION 3 : "
		adb install -r %TEMP%/3.apk >NUL
		call :c 0A "LISTO"
		echo.
		call :c 0E " INSTALANDO APLICACION 4 : "
		adb install -r %TEMP%/4.apk >NUL
		call :c 0A "LISTO"
		echo.
		call :c 0E " INSTALANDO APLICACION 5 : "
		adb install -r %TEMP%/5.apk >NUL
		call :c 0A "LISTO"
		echo.
		call :c 0E " INSTALANDO APLICACION 6 : "
		adb install -r %TEMP%/6.apk >NUL
		call :c 0A "LISTO"
		echo.
		call :c 0E " INSTALANDO APLICACION 7 : "
		adb install -r %TEMP%/7.apk >NUL
		call :c 0A "LISTO"
		echo.
		echo.
		echo Eliminando NEW FRP
		echo.
		adb push frp.bin /data/local/tmp/temp > NUL
		adb shell chmod 777 /data/local/tmp/temp > NUL
		adb shell /data/local/tmp/temp
		echo.
		call :c 0C " REINICIANDO..."
		echo.
		call :c 0E " ESPERANDO ADB NUEVAMENTE : "
		echo.
		TIMEOUT 80 /NOBREAK >nul
		adb shell rm /data/local/tmp/temp > NUL
		call :c 0A " LISTO"
		start "" https://gsmneo.com/bypasskglockedutilidades
		echo.
		echo.
		echo.
    pause
goto:inicio
		
		:downquestapkkg
		echo.
		call :c 0E "  ******************************************"
		echo.
		call :c 0E "  *  YA ESTAN DESCARGADO LOS ARCHIVO APKS  *"
		echo.
		call :c 0E "  ******************************************"
		echo.
		echo.
		:varsinokg
		SET /p varSN= ^> DESEAS VOLVER A DESCARGARLO? [S]/[N]: 
		if "%varSN%"=="S" goto downapkkg
		if "%varSN%"=="s" goto downapkkg
		if "%varSN%"=="N" goto nodownapkkg
		if "%varSN%"=="n" goto nodownapkkg
		echo.
		call :c 06 " "%varSN%" no es una opcion valida, por favor intente de nuevo con S o N."
		echo.
		echo.
		echo.
		pause
		goto:varsinokg
:op12
	    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "BYPASS KG LOCKED BY CMD"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " EJECUTANDO SCRIPT KG	: "
		adb shell pm disable-user --user 0 com.sec.enterprise.knox.cloudmdm.smdms >nul 2>&1
		call :c 0A "LISTO"
		call :up1
		echo.
		echo.
    pause
goto:inicio
	
:op13
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "MODO EDL FREE"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " EJECUTANDO SCRIPT EDL	: "
		adb reboot edl
		call :c 0A "LISTO"
		echo.
		echo.
		call :c 0E "  ***********************************************"
		echo.
		call :c 0E "  *  NOTA: PARA REINICIARLO NORMAL PRESIONE     *"
		echo.
		call :c 0E "  *        POWER + VOL - POR 7 SEGUNDOS O MAS   *"
		echo.
		call :c 0E "  ***********************************************"
		echo.
		echo.
		echo.
    pause
goto:inicio

:op14
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "ABRIR AJUSTES"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " EJECUTANDO SCRIPT	: "
		adb shell am start com.android.settings >nul 2>&1
		call :c 0A "LISTO"
		echo.
		echo.
		echo.
    pause

:op15
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "FORZAR CIERRE ADB"
	echo.
		echo.
		call :c 0E " CERRANDO ADB		: "
		TASKKILL /IM adb.exe /F >nul 2>&1
		call :c 0A "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio

:op16
Ping www.google.nl -n 1 -w 1000 >nul
if errorlevel 1 (goto noconnected) else (goto apkgboardmenudiag)
goto:inicio

:apkgboardmenudiag
	echo.
		if exist %TEMP%\midiag.apk  (goto downquestapkboarddiag) else (goto downboarddiag)
		:downboarddiag
		echo.
		call :c 0E " DESCARGANDO APK	: "
		powershell wget https://frp.geeklock.net/frpapk/midiag.apk -OutFile %TEMP%\midiag.apk 
		call :c 0A "LISTO"
		echo.
		:nodownboarddiag
		echo.
		call :c 0E " PROCESO		: "
		call :c 0C "DIAG XIAOMI APK"
		echo.
		echo.
		call :adbreadinfo
		echo.
		call :c 0E " COPIANDO APK		: "
		adb push %TEMP%\midiag.apk /sdcard/Download/ >nul 2>&1
		call :c 0A "LISTO"
		echo.
		echo.
		call :c 0E "  ****************************************************"
		echo.
		call :c 0E "  *  INSTALE EL ARCHIVO midiag.apk DE ADMINISTRADOR  *"
		echo.
		call :c 0E "  *    Solo avance luego de instalar el archivo      *"
		echo.
		call :c 0E "  ****************************************************"
		adb shell am start -n com.mi.android.globalFileexplorer/com.android.fileexplorer.FileExplorerTabActivity >nul 2>&1
		echo.
		echo.
		pause
		echo.
		echo.
		call :c 0E " ACTIVANDO DIAG		: "
		adb shell am start -n com.longcheertel.midtest/ >nul 2>&1
		adb shell am start -n com.longcheertel.midtest/com.longcheertel.midtest.Diag >nul 2>&1
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio
		
		:downquestapkboarddiag
		echo.
		call :c 0E "  ***************************************"
		echo.
		call :c 0E "  *  YA ESTA DESCARGADO EL ARCHIVO APK  *"
		echo.
		call :c 0E "  ***************************************"
		echo.
		echo.
		:varsinoboard
		SET /p varSN= ^> DESEAS VOLVER A DESCARGARLO? [S]/[N]: 
		if "%varSN%"=="S" goto downboarddiag
		if "%varSN%"=="s" goto downboarddiag
		if "%varSN%"=="N" goto nodownboarddiag
		if "%varSN%"=="n" goto nodownboarddiag
		echo.
		call :c 06 " "%varSN%" no es una opcion valida, por favor intente de nuevo con S o N."
		echo.
		echo.
		echo.
		pause
		goto:varsinoboard

:op17
 echo.
 echo.
 echo.
 echo **** ----------------------------------------------------- ****
 echo *** --------------------- RESET MSL SPC   ----------------- ***
 echo **** ------------------------------------------------------- ***
 echo.
 echo [*] Waiting For Your Devices ...
 adb wait-for-device 
 adb shell export ANDROID_LOG_TAGS="" ; exec logcat -d MSL_Checker:i *:S 
 :finsh
 echo.
 echo --- All Finished ---
 echo.
 pause
 adb wait-for-device
 goto:inicio

 :op18

echo.
echo.              ***************************
echo.              ****** Device Info ********
echo.              ***************************
echo.
echo. ACTIVA LA DEPURACION Y PERMITE LA CONEXION ADB
echo.

echo. Detectando dispositivo
echo.
adb wait-for-any > nul

echo. Equipo Detectado!

echo.

echo|set /p="MARCA:"
	 adb shell getprop ro.product.brand

echo|set /p="MODELO               : "
	 adb shell getprop ro.product.model

echo|set /p="OPERADOR             : "
	 adb shell getprop ro.build.target_operator

echo|set /p="MANUFACTURE          : "
	 adb shell getprop ro.product.manufacturer

echo|set /p="VERSION ANDROID      : "
	 adb shell getprop ro.build.version.release

echo|set /p="PARCHE DE SEGURIDAD  : "
	 adb shell getprop ro.build.version.security_patch


echo|set /p="eMMC SIZE            : "
  adb shell getprop ro.emmc_size
echo.

echo. Presiona enter para regresar al menu principal
echo.
pause
goto:inicio

:: FIN ACCIONES ADB


:: INICIO ACCIONES FASTBOOT

:op21
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "LECTURA XIAOMI FASTBOOT"
	echo.
	echo.
		call :fastbootreadxiaomi
		echo.
		echo.
	SET /p downlastfirmmi= ^> DESEA DESCARGAR EL FIRMWARE GLOBAL DE %codename%^? [S]I/[N]O: 
		if "%downlastfirmmi%"=="S" goto lasglobalmi
		if "%downlastfirmmi%"=="s" goto lasglobalmi
		if "%downlastfirmmi%"=="N" goto inicio
		if "%downlastfirmmi%"=="n" goto inicio


:lasglobalmi
		start "" https://mifirm.net/model/%codename%.ttt#global
		echo.
call :c 0E " DESCARGA LA ULTIMA ROM EN LA LISTA"
		echo.
		echo.
		pause
goto:inicio		

:op22
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "LECTURA MOTOROLA FASTBOOT"
	echo.
	echo.
		call :fastbootreadmoto
		echo.
		echo.
		echo.
    pause
goto:inicio
	
:op23
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "LECTURA HUAWEI FASTBOOT"
	echo.
	echo.
		call :fastbootreadhuawei
		echo.
		echo.
		echo.
    pause
goto:inicio
	
:op24
    echo.
    echo. *****************************IMPORTANTE**********************************
    echo. ANTES DE HACER ESTE PROCESO ASEGURATE QUE HICISTE RESPALDO DE TU OEMINFO
	echo. SIGUIENTE PASO: CARGAR FASTBOOT FACTORY (Chimera) o LOAD FASTBOOT (sigma)
	echo. *************************************************************************
	echo.
	echo.
		echo CONECTA EL EQUIPO EN MODO FASTBOOT FACTORY...
		echo.
		fastboot wait-for-devices
		fastboot devices
		pause
        echo ************
		echo ************
		echo ELIMINANDO OEMINFO...
		fastboot erase oeminfo
		fastboot erase frp
		fastboot erase persistent
		fastboot erase userdata
		fastboot reboot
		echo ************
		echo ************
		echo LISTO!
		echo ************
		echo ************
		echo SIGUIENTE PASO: AVANZAR Y PONER PIN
		echo SIGUIENTE PASO: CARGAR OEMINFO GUARDADO
		echo SIGUIENTE PASO: FACTORY RESET
		echo SIGUIENTE PASO: INICIAR Y PONER PIN PUESTO.
		echo **SUERTE**
		echo.
		echo.
		echo.
    pause
goto:inicio

:op25
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "REPARAR IMEI 0"
	echo.
	echo.
		call :fastbootreadmoto
		echo.
		echo.
		call :c 0E " REPARANDO MODEM	: "
		fastboot erase modemst1 >NUL 2>&1
		fastboot erase modemst2 >NUL 2>&1
		fastboot oem fb_mode_set >NUL 2>&1
		fastboot -w >NUL 2>&1
		fastboot oem fb_mode_clear >NUL 2>&1
		fastboot reboot  >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio

:op26
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "REINICIAR SISTEMA"
	echo.
	echo.
		call :fastbootreadmoto
		echo.
		echo.
		call :c 0E " REINICIANDO SISTEMA	: "
		fastboot reboot  >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio
	
:op27
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "REINICIAR EN RECOVERY"
	echo.
	echo.
		call :fastbootreadmoto
		echo.
		echo.
		call :c 0E " REINICIANDO EN RECOVERY: "
		fastboot reboot recovery  >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio
	
:op28
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "RESETEAR DE FABRICA"
	echo.
	echo.
		call :fastbootreadmoto
		echo.
		echo.
		call :c 0E " RESETEANDO DE FABRICA	: "
		fastboot oem fb_mode_set >NUL 2>&1
		fastboot -w >NUL 2>&1
		fastboot oem fb_mode_clear >NUL 2>&1
		fastboot reboot >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio

:op29
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "UNBRICK SISTEMA A/B"
	echo.
	echo.
		call :fastbootreadmoto
		echo.
		echo.
		if "%sistemab%"=="a" (goto:sistema) else (if "%sistemab%"=="b" (goto:sistemb) else (goto:nosistem))
		
		:nosistem
		echo.
		echo.
		call :c 0E "  ***********************************************"
		echo.
		call :c 0E "  *  NO SE HA DETECTADO EL SISTEMA SLOT         *"
		echo.
		call :c 0E "  *  INGRESE MANUALMENTE EL SISTEMA             *"
		echo.
		call :c 0E "  ***********************************************"
		echo.
		echo.
		SET /p slotsistem= ^> ESCRIBA [A] o [B]: 

		if "%slotsistem%"=="a" goto sistema
		if "%slotsistem%"=="A" goto sistema
		if "%slotsistem%"=="b" goto sistemb
		if "%slotsistem%"=="B" goto sistemb
		echo.
		echo El "%slotsistem%" no es una opcion valida, por favor intente de nuevo.
		echo.
		echo.
		echo.
	pause
goto:inicio

		:sistema
		echo.
		echo.
		call :c 0E " CAMBIANDO AL SISTEMA B	: "
		fastboot set_active b >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio

		:sistemb
		echo.
		echo.
		call :c 0E " CAMBIANDO AL SISTEMA A	: "
		fastboot set_active a >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio

:op30
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "FLASH FIRMWARE"
	echo.
	echo.
		call :fastbootreadmoto
		echo.
		echo.
		IF EXIST FIRMWARE (goto:flashmoto) else (MD FIRMWARE)
		:flashmoto
		call :c 0E "  ****************************************************"
		echo.
		call :c 0E "  *  SE HA CREADO UNA CARPETA LLAMADA "&call :c 0A FIRMWARE  ""&call :c 0E "       *
		echo.
		call :c 0E "  *  ESTA DEBE CONTENER LOS ARCHIVOS FLASH           *"
		echo.
		call :c 0E "  *  Y ESPECIALMENTE EL ARCHIVO "&call :c 06 FLASHFILE.XML  ""&call :c 0E "        *
		echo.
		call :c 0E "  ****************************************************"
		echo.
		echo.
		echo.
		pause
		echo @echo off > flashfile.bat
		REM fastboot getvar max-sparse-size >> flashfile.bat //OMITIDO
		echo fastboot oem fb_mode_set >> flashfile.bat
		findstr "\<filename\>" FIRMWARE\flashfile.xml > filename.txt
		findstr "\<erase\>" FIRMWARE\flashfile.xml > erase.txt
		findstr "\<mbn\>" FIRMWARE\flashfile.xml > mbn.txt
		findstr "\<BTFM\>" FIRMWARE\flashfile.xml > BTFM.txt
		for /F delims^=^"^ Tokens^=4^,6^,8^* %%G in (filename.txt) DO @echo fastboot %%H %%I FIRMWARE\%%G >> flashfile.bat
		for /F delims^=^"^ Tokens^=2^,4^,6^* %%G in (erase.txt) DO @echo fastboot %%G %%H >> flashfile.bat
		for /F delims^=^"^ Tokens^=4^,6^,8^* %%G in (mbn.txt) DO @echo fastboot %%H %%I FIRMWARE\%%G >> flashfile.bat
		for /F delims^=^"^ Tokens^=4^,6^,8^* %%G in (BTFM.txt) DO @echo fastboot %%H %%I FIRMWARE\%%G >> flashfile.bat
		echo fastboot oem fb_mode_clear >> flashfile.bat
		echo echo ------------------------------------------------------------------------- >> flashfile.bat
		echo echo El proceso de flash ha finalizado >> flashfile.bat
		echo echo ------------------------------------------------------------------------- >> flashfile.bat
		echo pause >> flashfile.bat
		echo fastboot reboot >> flashfile.bat
		echo ------------------------------------------------------------------------------
		del BTFM.txt
		del mbn.txt
		del erase.txt
		del filename.txt
		call flashfile.bat
		del flashfile.bat
		echo.
		echo.
		echo.
	pause
goto:inicio

:OP31
    echo.
	echo.
	call :c 0E " PROCESO		: "
    call :c 0C "ACTIVAR FACTORY MODE"
	echo.
	echo.
		call :fastbootreadmoto
		echo.
		echo.
		call :c 0E " ACTIVANDO FACTORY MODE	: "
		fastboot oem config bootmode factory  >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		call :c 0E " REINICIANDO SISTEMA	: "
		fastboot reboot  >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio

:OP32
	echo.
	echo.
	call :c 0E " PROCESO		: "
    call :c 0C "LOCK/UNLOCK BOOTLOADER"
	echo.
		echo.
		call :fastbootreadmoto
		echo.
		echo.
	if "%bootloaderlock%"=="no" (goto:bootloaderunlock) else (goto:bootloaderlock)
	
	:bootloaderunlock
	echo.
	call :c 0E " ESTADO BOOTLOADER	: "
    call :c 0C "%bootloaderlock%"
	echo.
	echo.
	echo ---------------------------------------------------------------------------------------------------
	echo.
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "UNLOCK BOOTLOADER"
	echo.
		echo.
		call :c 0E " DESBLOQUEANDO 		: "
		fastboot flashing unlock  >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		call :c 0E " REINICIANDO SISTEMA	: "
		fastboot reboot bootloader  >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio

	:bootloaderlock
	echo.
	call :c 0E " ESTADO BOOTLOADER	: "
    call :c 0C "%bootloaderlock%"
	echo.
	echo.
	echo ---------------------------------------------------------------------------------------------------
	echo.
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "LOCK BOOTLOADER"
	echo.
		echo.
		call :c 0E " BLOQUEANDO 		: "
		fastboot flashing lock  >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		call :c 0E " REINICIANDO SISTEMA	: "
		fastboot reboot bootloader >NUL 2>&1
		call :c 0C "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio

:op33
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "REPARAR COMMSERVER"
	echo.
	echo.
		call :fastbootreadmoto
		echo.
		echo.
		call :c 0E " REPARANDO COMMSERVER	: "
		fastboot oem fb_mode_set >nul
		fastboot -w >nul
		fastboot oem fb_mode_clear >nul
		fastboot reboot >nul
		call :c 0C "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio

:: FIN DE ACCIONES FASTBOOT

:: INICIO DE ACCIONES ROOT
	
:op41
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "OBTENER LOGO ORIGINAL"
	echo.
	echo.
	call :c 0E " PIDIENDO PERMISOS ROOT	: "	
	for /f "delims=" %%a in ('adb shell "su -c whoami"') do set "rootstatus=%%a"
			if "%rootstatus%"=="root" (goto:sacarlogo) else (goto:noroot)
goto:inicio			
		:sacarlogo
		call :c 0C "LISTO"
		echo.
		echo.
		call :adbreadinfo
		echo.
		call :c 0E " SACANDO LOGO ORIGINAL	: "
		IF EXIST BACKUP_UP_PARAM (goto sacarlogomkdir) else (MD BACKUP_UP_PARAM)
		:sacarlogomkdir
			for /f "tokens=1-3 delims=/- " %%a in ('date /t') do set "FECHA=%%a%%b%%c"
			for /f "tokens=1-3 delims=: " %%a in ('time /t') do set "HORA=%%a%%b%%c"
			set "namefolderbackup=%modelo%_%FECHA%_%HORA%"
			MKDIR BACKUP_UP_PARAM\%namefolderbackup% >nul
		@adb shell "su -c dd if=/dev/block/by-name/up_param of=//sdcard/up_param.bin" >NUL 2>&1
		@adb pull sdcard/up_param.bin BACKUP_UP_PARAM\%namefolderbackup%\up_param.bin >NUL 2>&1
		@adb shell rm sdcard/up_param.bin >nul 2>&1
		call :c 0A "LISTO"
		echo.	
		call :c 0E " BACKUP UP_PARAM	: "
		echo.
		call :c 0A " %~dp0BACKUP_UP_PARAM\%namefolderbackup%\up_param.bin"
		echo.
		echo.
		echo.
		pause
goto:inicio
	
:op42    
	echo.
	call :c 0E " PROCESO		: "
    call :c 0C "FIX LOGO ONE CLICK"
	echo.
	echo.
		call :c 0E "  ***********************************************"
		echo.
		call :c 0E "  *  NOTA: DEBE TENER up_param.tar EN LA        *"
		echo.
		call :c 0E "  *       CARPETA DONDE ESTA ESTE PROGRAMA      *"
		echo.
		call :c 0E "  ***********************************************"
		echo.
		echo.
		pause
	echo.
	echo.
	call :c 0E " PIDIENDO PERMISOS ROOT	: "	
	for /f "delims=" %%a in ('adb shell "su -c whoami"') do set "rootstatus=%%a"
			if "%rootstatus%"=="root" (goto:escribirlogo) else (goto:noroot)
goto:inicio			
		:escribirlogo
		call :c 0C "LISTO"
		echo.
		echo.
		call :adbreadinfo
		echo.
		call :c 0E " ESCRIBIENDO LOGO	: "
		@adb push up_param.tar /sdcard/ >NUL 2>&1
		@adb shell "su -c dd if=//sdcard/up_param.tar of=/dev/block/by-name/up_param" >NUL 2>&1
		@adb shell rm sdcard/up_param.tar >nul 2>&1
		call :c 0A "LISTO"
			echo.
			call :c 0E " REINICIANDO		: "
			adb reboot
			call :c 0A "LISTO"
		echo.		
		echo.
		echo.
	pause
goto:inicio
			
:op43
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "ACTIVAR PUERTO DIAG"
	echo.
	echo.
	call :c 0E " PIDIENDO PERMISOS ROOT	: "	
	for /f "delims=" %%a in ('adb shell "su -c whoami"') do set "rootstatus=%%a"
			if "%rootstatus%"=="root" (goto:puertodiag) else (goto:noroot)
goto:inicio			
		:puertodiag
		call :c 0C "LISTO"
		echo.
		echo.
		call :adbreadinfo
		echo.
		call :c 0E " ACTIVANDO PUERTO DIAG	: "
		@adb shell "su -c setprop sys.usb.config diag,adb" >NUL 2>&1
		call :c 0A "LISTO"
		echo.	
		echo.
		echo.
    pause
goto:inicio
	
:op44
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "RECUPERAR IMEI ORIGINAL"
	echo.
	echo.
	call :c 0E " PIDIENDO PERMISOS ROOT	: "	
	for /f "delims=" %%a in ('adb shell "su -c whoami"') do set "rootstatus=%%a"
			if "%rootstatus%"=="root" (goto:imeioriginal) else (goto:noroot)
goto:inicio			
		:imeioriginal
		call :c 0C "LISTO"
		echo.
		echo.
		call :adbreadinfo
		echo.
		call :c 0E " RECUPERANDO RF		: "
		adb shell "su -c rm -R /mnt/vendor/nvdata/md/NVRAM/NVD_IMEI/" >NUL 2>&1
		call :c 0A "LISTO"
		echo.	
		call :c 0E " REINICIANDO		: "
		adb reboot
		call :c 0A "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio
   
:op45
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "BACKUP NV CALIBRACION"
	echo.
	echo.
	call :c 0E " PIDIENDO PERMISOS ROOT	: "	
	for /f "delims=" %%a in ('adb shell "su -c whoami"') do set "rootstatus=%%a"
			if "%rootstatus%"=="root" (goto:backupnvdata) else (goto:noroot)
goto:inicio			
		:backupnvdata
		call :c 0C "LISTO"
		echo.
		echo.
		call :adbreadinfo
		echo.
		IF EXIST BACKUP_NV (goto backupnvmkdir) else (MD BACKUP_NV)
		:backupnvmkdir
			for /f "tokens=1-3 delims=/- " %%a in ('date /t') do set "FECHA=%%a%%b%%c"
			for /f "tokens=1-3 delims=: " %%a in ('time /t') do set "HORA=%%a%%b%%c"
			set "namefolderbackup=%modelo%_%FECHA%_%HORA%"
			MKDIR BACKUP_NV\%namefolderbackup% >nul
			
		call :c 0E " SACANDO ARCHIVO	: "
		@adb shell "su -c dd if=/dev/block/by-name/nvram of=//sdcard/nvram.bin"  >NUL 2>&1
		@adb pull sdcard/nvram.bin BACKUP_NV\%namefolderbackup%\nvram.bin >NUL 2>&1
		@adb shell rm sdcard/nvram.bin >NUL 2>&1
		call :c 0A "nvram.bin"
		echo.
		call :c 0E " SACANDO ARCHIVO	: "
		@adb shell "su -c dd if=/dev/block/by-name/nvdata of=//sdcard/nvdata.img" >NUL 2>&1
		@adb pull sdcard/nvdata.img BACKUP_NV\%namefolderbackup%\nvdata.img  >NUL 2>&1
		@adb shell rm sdcard/nvdata.img	>NUL 2>&1
		call :c 0A "nvdata.img"
		echo.
		call :c 0E " SACANDO ARCHIVO	: "
		@adb shell "su -c dd if=/dev/block/by-name/nvcfg of=//sdcard/nvcfg.img" >NUL 2>&1
		@adb pull sdcard/nvcfg.img BACKUP_NV\%namefolderbackup%\nvcfg.img  >NUL 2>&1
		@adb shell rm sdcard/nvcfg.img >NUL 2>&1
		call :c 0A "nvcfg.img"
		echo.
		call :c 0E " SACANDO ARCHIVO	: "		
		@adb shell "su -c dd if=/dev/block/by-name/protect1 of=//sdcard/protect1.img" >NUL 2>&1
		@adb pull sdcard/protect1.img BACKUP_NV%namefolderbackup%\protect1.img >NUL 2>&1
		@adb shell rm sdcard/protect1.img >NUL 2>&1
		call :c 0A "protect1.img"
		echo.
		call :c 0E " SACANDO ARCHIVO	: "
		@adb shell "su -c dd if=/dev/block/by-name/protect2 of=//sdcard/protect2.img" >NUL 2>&1
		@adb pull sdcard/protect2.img BACKUP_NV\%namefolderbackup%\protect2.img >NUL 2>&1
		@adb shell rm sdcard/protect2.img >NUL 2>&1
		call :c 0A "protect2.img"
		echo.
		call :c 0E " SACANDO ARCHIVO	: "		
		@adb shell "su -c dd if=/dev/block/by-name/proinfo of=//sdcard/proinfo.bin" >NUL 2>&1
		@adb pull sdcard/proinfo.bin BACKUP_NV\%namefolderbackup%\proinfo.bin >NUL 2>&1
		@adb shell rm sdcard/proinfo.bin >NUL 2>&1
		call :c 0A "proinfo.bin"
		echo.
		call :c 0E " SACANDO ARCHIVO	: "		
		@adb shell "su -c dd if=/dev/block/by-name/efs of=//sdcard/efs.img" >NUL 2>&1
		@adb pull sdcard/efs.img BACKUP_NV\%namefolderbackup%\efs.img >NUL 2>&1
		@adb shell rm sdcard/efs.img >NUL 2>&1
		call :c 0A "efs.img"
		echo.
		call :c 0E " SACANDO ARCHIVO	: "		
		@adb shell "su -c dd if=/dev/block/by-name/sec_efs of=//sdcard/sec_efs.img" >NUL 2>&1
		@adb pull sdcard/sec_efs.img BACKUP_NV\%namefolderbackup%\sec_efs.img >NUL 2>&1
		@adb shell rm sdcard/sec_efs.img >NUL 2>&1
		call :c 0A "sec_efs.img"
		echo.
		echo.	
		call :c 0E " BACKUP NV		: "
		echo.
		call :c 0A " %~dp0BACKUP_NV\%namefolderbackup%\"
		echo.
		echo.
		echo.
    pause
goto:inicio
	
:op46
	cls
	echo.
	echo.
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "ESCRIBIR NV CALIBRACION"
	echo.
	echo.
	call :c 0E " PIDIENDO PERMISOS ROOT	: "	
	for /f "delims=" %%a in ('adb shell "su -c whoami"') do set "rootstatus=%%a"
			if "%rootstatus%"=="root" (goto:restorenvdata) else (goto:noroot)
goto:inicio		

		:restorenvdata
		call :c 0C "LISTO"
		echo.
		echo.
		IF EXIST ESCRIBIR_NV (goto:restorenvdatafolder) else (MD ESCRIBIR_NV)
		:restorenvdatafolder
		call :c 0E "  ****************************************************"
		echo.
		call :c 0E "  *  SE HA CREADO UNA CARPETA LLAMADA "&call :c 0A ESCRIBIR_NV  ""&call :c 0E "    *
		echo.
		call :c 0E "  *  ESTA DEBE CONTENER LOS SIGUIENTES ARCHIVOS:     *"
		echo.
		call :c 0E "  *                                                  *"
		echo.
		call :c 0E "  *    "&call :c 06 " > nvram.bin "&call :c 0E "                                 *"
		echo.
		call :c 0E "  *    "&call :c 06 " > nvdata.img "&call :c 0E "                                *"
		echo.
		call :c 0E "  *    "&call :c 06 " > nvcfg.img "&call :c 0E "                                 *"
		echo.
		call :c 0E "  *    "&call :c 06 " > protect1.img "&call :c 0E "                              *"
		echo.
		call :c 0E "  *    "&call :c 06 " > protect2.img "&call :c 0E "                              *"
		echo.
		call :c 0E "  *    "&call :c 06 " > proinfo.bin "&call :c 0E "                               *"
		echo.
		call :c 0E "  *    "&call :c 06 " > efs.img "&call :c 0E "                                   *"
		echo.
		call :c 0E "  *    "&call :c 06 " > sec_efs.img "&call :c 0E "                               *"
		echo.
		call :c 0E "  *                                                  *"
		echo.
		call :c 0E "  *  NOTA: "&call :c 0C "ESOS ARCHIVOS DEBEN SER DE ESTE MISMO "&call :c 0E "    *
		echo.
		call :c 0E "  *        "&call :c 0C "EQUIPO, SI NO ES EL MISMO EQUIPO "&call :c 0E "         *
		echo.
		call :c 0E "  *        "&call :c 0C "PUEDE QUEDAR BRICK O PERDER NV. "&call :c 0E "          *
		echo.
		call :c 0E "  *                                                  *"
		echo.
		call :c 0E "  *        "&call :c 0C "ESTE PROCESO ES BAJO SU RESPONSABILIDAD "&call :c 0E "  *
		echo.
		call :c 0E "  *                                                  *"
		echo.
		call :c 0E "  ****************************************************"
		echo.
		echo.
		echo.
		SET /P startwritenv= ^> DESEA CONTINUAR^? [S]I / [N]O: 
		
		if "%startwritenv%"=="S" goto restorenvdatawrite
		if "%startwritenv%"=="s" goto restorenvdatawrite
		if "%startwritenv%"=="N" goto inicio
		if "%startwritenv%"=="n" goto inicio
	
		:restorenvdatawrite
		echo.
		echo.
		call :c 0E " ESCRIBIENDO 	: "
		call :c 06 "nvram.bin"		
		@adb push ESCRIBIR_NV/nvram.bin /sdcard/ >NUL 2>&1
		call :c 0A "	OK"
		echo.
		call :c 0E " ESCRIBIENDO 	: "
		call :c 06 "nvdata.img"
		@adb push ESCRIBIR_NV/nvdata.img /sdcard/ >NUL 2>&1	
		call :c 0A "	OK"
		echo.
		call :c 0E " ESCRIBIENDO 	: "
		call :c 06 "nvcfg.img"
		@adb push ESCRIBIR_NV/nvcfg.img /sdcard/ >NUL 2>&1	
		call :c 0A "	OK"
		echo.
		call :c 0E " ESCRIBIENDO 	: "
		call :c 06 "protect1.img"
		@adb push ESCRIBIR_NV/protect1.img /sdcard/ >NUL 2>&1	
		call :c 0A "	OK"
		echo.
		call :c 0E " ESCRIBIENDO 	: "
		call :c 06 "protect2.img"
		@adb push ESCRIBIR_NV/protect2.img /sdcard/ >NUL 2>&1	
		call :c 0A "	OK"
		echo.
		call :c 0E " ESCRIBIENDO 	: "
		call :c 06 "proinfo.bin"
		@adb push ESCRIBIR_NV/proinfo.bin /sdcard/ >NUL 2>&1	
		call :c 0A "	OK"
		echo.
		call :c 0E " ESCRIBIENDO 	: "
		call :c 06 "efs.img"
		@adb push ESCRIBIR_NV/efs.img /sdcard/ >NUL 2>&1	
		call :c 0A "	OK"
		echo.
		call :c 0E " ESCRIBIENDO 	: "
		call :c 06 "sec_efs.img"
		@adb push ESCRIBIR_NV/sec_efs.img /sdcard/ >NUL 2>&1	
		call :c 0A "	OK"
		echo.
		echo.
		call :c 0E " CONFIGURANDO 	: "
		@adb shell "su -c dd if=//sdcard/nvram.bin of=/dev/block/by-name/nvram" >NUL 2>&1
		@adb shell "su -c dd if=//sdcard/nvdata.img of=/dev/block/by-name/nvdata" >NUL 2>&1
		@adb shell "su -c dd if=//sdcard/nvcfg.img of=/dev/block/by-name/nvcfg" >NUL 2>&1
		@adb shell "su -c dd if=//sdcard/protect1.img of=/dev/block/by-name/protect1" >NUL 2>&1
		@adb shell "su -c dd if=//sdcard/protect2.img of=/dev/block/by-name/protect2" >NUL 2>&1
		@adb shell "su -c dd if=//sdcard/proinfo.bin of=/dev/block/by-name/proinfo" >NUL 2>&1
		@adb shell "su -c dd if=//sdcard/efs.img of=/dev/block/by-name/efs" >NUL 2>&1
		@adb shell "su -c dd if=//sdcard/sec_efs.img of=/dev/block/by-name/sec_efs" >NUL 2>&1
		call :c 0A "	LISTO"
		echo.
		echo.
		call :c 0E " LIMPIANDO 	: "
		@adb shell rm /sdcard/nvram.bin >NUL 2>&1
		@adb shell rm /sdcard/nvdata.img >NUL 2>&1
		@adb shell rm /sdcard/nvcfg.img >NUL 2>&1
		@adb shell rm /sdcard/protect1.img >NUL 2>&1
		@adb shell rm /sdcard/protect2.img >NUL 2>&1
		@adb shell rm /sdcard/proinfo.bin >NUL 2>&1
		@adb shell rm /sdcard/efs.img >NUL 2>&1
		@adb shell rm /sdcard/sec_efs.img >NUL 2>&1
		call :c 0A "	LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio 
	
:op47
Ping www.google.nl -n 1 -w 1000 >nul
if errorlevel 1 (goto noconnected) else (goto autofixlogo)
goto:inicio

:autofixlogo
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "AUTO FIX LOGO"
	echo.
	echo.
	call :c 0E " PIDIENDO PERMISOS ROOT	: "	
	for /f "delims=" %%a in ('adb shell "su -c whoami"') do set "rootstatus=%%a"
			if "%rootstatus%"=="root" (goto autofixlogoprocess) else (goto noroot)
goto:inicio
		:autofixlogoprocess
		call :c 0C "LISTO"
		echo.
		echo.
		call :adbreadinfo
		echo.
		call :c 0E " SACANDO LOGO ORIGINAL	: "
		@adb shell "su -c dd if=/dev/block/by-name/up_param of=//sdcard/up_param.bin" >NUL 2>&1
		@adb pull sdcard/up_param.bin up_param.bin >NUL 2>&1
		@adb shell rm sdcard/up_param.bin >nul 2>&1
		call :c 0A "LISTO"
		echo.
		call :c 0E " DECODIFICANDO		: "
		7za e -y up_param.bin >nul
		call :c 0A "LISTO"
		echo.
		call :c 0E " EDITANDO IMAGENES	: "
		powershell copy *logo* logocopy.jpg
		dir /b *orange* > newname
		del *orange*
		for /f "delims=" %%a in ('TYPE newname') do rename logocopy.jpg %%a
		del newname
			dir /b *_warning.jpg > namewarning
			del *_warning.jpg
		powershell wget https://frp.geeklock.net/Tools/script/newjpg.ps1 -OutFile %TEMP%\newjpg.ps1
		powershell -ExecutionPolicy RemoteSigned -File %TEMP%\newjpg.ps1
			del %TEMP%\newjpg.ps1	
		for /f "delims=" %%a in ('TYPE namewarning') do rename fixwarningblack.jpg %%a
		del namewarning
		powershell tar -cf up_param.tar *.jpg
		del *.jpg
		IF EXIST BACKUP_UP_PARAM (goto autofixlogowrite) else (MD BACKUP_UP_PARAM)
		:autofixlogowrite
			for /f "tokens=1-3 delims=/- " %%a in ('date /t') do set "FECHA=%%a%%b%%c"
			for /f "tokens=1-3 delims=: " %%a in ('time /t') do set "HORA=%%a%%b%%c"
			set "namefolderbackup=%modelo%_%FECHA%_%HORA%"
			MKDIR BACKUP_UP_PARAM\%namefolderbackup% 
			move up_param.bin BACKUP_UP_PARAM\%namefolderbackup%\up_param.bin >nul
		call :c 0A "LISTO"
		echo.
		call :c 0E " ESCRIBIENDO LOGO	: "
		@adb push up_param.tar /sdcard/ >NUL 2>&1
		@adb shell "su -c dd if=//sdcard/up_param.tar of=/dev/block/by-name/up_param" >NUL 2>&1
		@adb shell rm sdcard/up_param.tar >nul 2>&1
		del up_param.tar
		call :c 0A "LISTO"
			echo.
			call :c 0E " REINICIANDO		: "
			adb reboot
			call :c 0A "LISTO"
		echo.		
		call :c 0E " BACKUP UP_PARAM	: "
		echo.
		call :c 0A " %~dp0BACKUP_UP_PARAM\%namefolderbackup%\up_param.bin"
		echo.
		echo.
		echo.
    pause
goto:inicio

:op48
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "ACTIVAR PARCHE"
	echo.
	echo.
	call :c 0E " PIDIENDO PERMISOS ROOT	: "	
	for /f "delims=" %%a in ('adb shell "su -c whoami"') do set "rootstatus=%%a"
			if "%rootstatus%"=="root" (goto:fixradiofrecuencia) else (goto:noroot)
goto:inicio			
		:fixradiofrecuencia
		call :c 0C "LISTO"
		echo.
		echo.
		call :adbreadinfo
		echo.
		call :c 0E " ACTIVANDO PARCHE	: "
		adb shell "su -c chmod 550 /mnt/vendor/nvdata/md/NVRAM/NVD_IMEI/" >NUL 2>&1
		call :c 0A "LISTO"
		echo.	
		call :c 0E " REINICIANDO		: "
		adb reboot
		call :c 0A "LISTO"
		echo.
		echo.
		echo.
    pause
goto:inicio
:: FIN ACCIONES ROOT
:: INICIO HERRAMIENTAS

:op61
	echo.
		powershell irm https://frp.geeklock.net/Tools/cmd/serverbox.bat -OutFile %TEMP%\ServerBox.bat
		
	call %TEMP%\ServerBox.bat
	del %TEMP%\ServerBox.bat
    echo.
goto:inicio

:op62
	echo.
	set "descargaherramienta=odin"
	set "nodescargarherramienta=nodownodin"
	IF EXIST TOOLS\Odin3\Odin3_v3.14.4.exe (goto downloadedtool) else (goto odin)
		echo. 
		:odin
		echo.
		call :c 0E " DESCARGANDO	: "
		powershell wget https://technastic.com/wp-content/uploads/2020/02/Odin3_v3.14.4.zip -OutFile Odin3-v3.14.4.zip
		IF EXIST TOOLS\Odin3 (goto nomkdirodin) else (MKDIR TOOLS\Odin3)
		:nomkdirodin
		Powershell Expand-Archive -Path Odin3-v3.14.4.zip -DestinationPath TOOLS\Odin3 -Force
		del Odin3-v3.14.4.zip
		move TOOLS\Odin3\Odin3_v3.14.4\*.* TOOLS\Odin3\ >nul
		rd TOOLS\Odin3\Odin3_v3.14.4\
	:nodownodin
	call :c 0A "LISTO"
	echo.
	echo.
	call :c 0E " DESCARGADO EN	: " 
	call :c 0A "%~dp0TOOLS\Odin3"
	echo.
	echo.
	pause
goto:inicio

:op63
	echo.
	set "descargaherramienta=frija"
	set "nodescargarherramienta=nodownfrija"
	IF EXIST TOOLS\Frija\Frija_v2 (goto downloadedtool) else (goto frija)
		echo. 
		:Frija
		echo.
		call :c 0E " DESCARGANDO	: "
		powershell wget https://github.com/SlackingVeteran/frija/releases/download/v2.0.23262.4/Frija_v2.0.23262.4.zip -OutFile Frija_v2.0.23262.4.zip
		IF EXIST TOOLS\Frija_v2 (goto nomkdirFrija_v2) else (MKDIR TOOLS\Frija_v2)
		:nomkdirfrija
		Powershell Expand-Archive -Path Frija_v2.0.23262.4.zip -DestinationPath TOOLS\Frija_v2 -Force
		del Frija_v2.0.23262.4.zip
		move TOOLS\Frija_v2\Frija_v2\*.* TOOLS\Frija_v2\ >nul
		rd TOOLS\Frija_v2\Frija_v2\
	:nodownFrija_v2
	call :c 0A "LISTO"
	echo.
	echo.
	call :c 0E " DESCARGADO EN	: " 
	call :c 0A "%~dp0TOOLS\Frija_v2"
	echo.
	echo.
	pause
goto:inicio

:op64
	echo.
	set "descargaherramienta=SamFw_FRP_Tool"
	set "nodescargarherramienta=nodownSamFw_FRP_Tool"
	IF EXIST TOOLS\SamFw_FRP_Tool\SamFw_FRP_Tool.exe (goto downloadedtool) else (goto SamFw_FRP_Tool)
		echo. 
		:SamFw_FRP_Tool
		echo.
		call :c 0E " DESCARGANDO	: "
		powershell wget https://download2444.mediafire.com/e9hwnex6c6dgmtqCNVHkS-gSpCx94JvhDSnjVmNXodTcU6aQtCOX9gU37cbUu88_ysJbqNenB1LRYII4wDEQCPff7z_rGRK-oa15Re91yh5F61Oze2XKS9Y2_3IlYutLbP6ghlZZIad3CucTMcJGHOa5B5zT_XdDAH1TPDT8qg/vpsbr4y8t6jj6yf/SamFwToolSetup_v4.7.1.zip -OutFile SamFwToolSetup_v4.7.1.zip
		IF EXIST TOOLS\SamFw_FRP_Tool (goto nomkdirSamFw_FRP_Tool) else (MKDIR TOOLS\SamFw_FRP_Tool)
		:nomkdirSamFw_FRP_Tool
		Powershell Expand-Archive -Path SamFwToolSetup_v4.7.1.zip -DestinationPath TOOLS\SamFw_FRP_Tool -Force
		del SamFwToolSetup_v4.7.1.zip
	:nodownSamFw_FRP_Tool
	call :c 0A "LISTO"
	echo.
	echo.
	call :c 0E " DESCARGADO EN	: " 
	call :c 0A "%~dp0TOOLS\SamFw_FRP_Tool"
	echo.
	echo.
	pause
goto:inicio

:op65
	echo.
	set "descargaherramienta=AndroidUtility"
	set "nodescargarherramienta=nodownAndroidUtility"
	IF EXIST TOOLS\AndroidUtility\AndroidUtility.exe (goto downloadedtool) else (goto AndroidUtility)
		echo. 
		:AndroidUtility
		echo.
		call :c 0E " DESCARGANDO	: "
		powershell wget https://download1527.mediafire.com/swujjin26vqg81_xDUGQEwqfEDRTb-dyE3O0lfQo44WyBpu5qIBmynhXPrlx9TQr6ykuYEIStRsWaSByt3DxfJPXOpXcIgvyjlNCGh8fgEN8kLd7mnYLrvg9UJxp4T0LoYsDtrKWDjgwIs6k5BlZhsOJgsCNuBdUgFLmEjV91Q/0ieun4h0n1qo36k/AndroidUtility.zip -OutFile AndroidUtility.v118.zip
		IF EXIST TOOLS\AndroidUtility (goto nomkdirAndroidUtility) else (MKDIR TOOLS\AndroidUtility)
		:nomkdirAndroidUtility
		Powershell Expand-Archive -Path AndroidUtility.v118.zip -DestinationPath TOOLS\AndroidUtility -Force
		del AndroidUtility.v118.zip
	:nodownAndroidUtility
	call :c 0A "LISTO"
	echo.
	echo.
	call :c 0E " DESCARGADO EN	: " 
	call :c 0A "%~dp0TOOLS\AndroidUtility"
	echo.
	echo.
	pause
goto:inicio

:op66
	echo.
	set "descargaherramienta=USBREDIRECTOR"
	set "nodescargarherramienta=nodownUSBREDIRECTOR"
	IF EXIST TOOLS\USBRedirector\usbredirector-cliente.exe (goto downloadedtool) else (goto USBREDIRECTOR)
		echo. 
		:USBREDIRECTOR
		echo.
		call :c 0E " DESCARGANDO	: "
		powershell wget https://frp.geeklock.net/Tools/usbredirector-cliente.exe -OutFile %TEMP%\usbredirector-cliente.exe
		IF EXIST TOOLS\USBRedirector (goto nomkdirusbredirector) else (MKDIR TOOLS\USBRedirector)
		:nomkdirusbredirector
		move %TEMP%\usbredirector-cliente.exe TOOLS\USBRedirector\usbredirector-cliente.exe >nul

	:nodownUSBREDIRECTOR
	start "" TOOLS\USBRedirector\usbredirector-cliente.exe
	call :c 0A "LISTO"
	echo.
	echo.
	set /p readmoto= ^> DESEA HACER UNA LECTURA A SU MOTOROLA^? [S]I/[N]O: 
		if "%readmoto%"=="S" goto op22
		if "%readmoto%"=="s" goto op22
		if "%readmoto%"=="N" goto inicio
		if "%readmoto%"=="n" goto inicio
	pause
goto:inicio

:downloadedtool
		echo.
		call :c 0E "  ******************************************"
		echo.
		call :c 0E "  *  YA ESTA DECARGADA LA HERRAMIENTA      *"
		echo.
		call :c 0E "  ******************************************"
		echo.
		echo.
		SET /p varSN= ^> DESEAS VOLVER A DESCARGARLO? [S]/[N]: 
		if "%varSN%"=="S" goto %descargaherramienta%
		if "%varSN%"=="s" goto %descargaherramienta%
		if "%varSN%"=="N" goto %nodescargarherramienta%
		if "%varSN%"=="n" goto %nodescargarherramienta%
		echo.
		call :c 06 " "%varSN%" no es una opcion valida, por favor intente de nuevo con S o N."
		echo.
		echo.
		echo.
		pause
		goto:inicio

:: FIN HERRAMIENTAS
:: INICIO LINKS


:op81
    echo.
	start "" https://c.mi.com/global/miuidownload/index
	start "" https://xiaomifirmwareupdater.com/
	start "" https://i.mi.com/find/device/activationlock?_locale=en#/status
	start "" https://mifirm.net/imei
    echo.
    echo.
goto:inicio
	
:op82
	echo.
    start "" https://youtube.com/geeklock
	start "" https://www.facebook.com/geeklock1337
	start "" https://t.me/+KBD0Vjw3ne5mNmQx
	start "" https://t.me/s/geeklock
    echo.
goto:inicio

:op83
	echo.
	SET /p modelo= ^> ESCRIBA EL MODELO (EJ: A305G): 
	start "" https://samfw.com/firmware/SM-%modelo%
    echo.
goto:inicio
:: FIN LINKS
:: INICIO OTROS

:op100
	echo.
		powershell wget https://frp.geeklock.net/Tools/cmd/mactivador.bat -OutFile %TEMP%\msactivador.bat
	start "" %TEMP%\msactivador.bat & exit

:op101
	echo.
	start "" devmgmt.msc
	echo.
    echo. ABRIENDO ADMIN. DE DISPOSITIVOS
	pause
goto:inicio

:op102
		echo.
		call :c 0E " PROCESO		: "
		call :c 0C "LIMPIAR SOFTWARE USB SHARE (REMOTOS)"
		echo.
		echo.
		call :c 0E " LIMPIANDO REGISTROS	: "
			
		REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Eltima Software" /f >nul 2>&1
		REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Electronic Team" /f >nul 2>&1

		REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Eltima Software" /f >nul 2>&1
		REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Electronic Team" /f >nul 2>&1

		REG DELETE "HKEY_CURRENT_USER\Software\Eltima Software" /f >nul 2>&1
		REG DELETE "HKEY_CURRENT_USER\Software\Electronic Team" /f >nul 2>&1
		call :c 0A "LISTO"
	echo.
		call :c 0E " ELIMINANDO ARCHIVOS	: "
		del /f C:\Windows\System32\drivers\vuhub.sys >nul 2>&1
		del /f C:\Windows\System32\drivers\fusbhub.sys >nul 2>&1
		del /f C:\Windows\System32\drivers\eusbstub.sys >nul 2>&1
		del /f C:\Windows\System32\drivers\eusbstub.sys >nul 2>&1
		del /f C:\Windows\System32\drivers\evsbc9.sys >nul 2>&1
		del /f C:\Windows\System32\drivers\evserial9.sys >nul 2>&1
		call :c 0A "LISTO"
		echo.
		echo.
		pause
goto:inicio		

:op103
		echo.
		call :c 0E " PROCESO		: "
		call :c 0C "LIMPIAR DRIVERS SIN USAR"
		echo.
		echo.
		call :c 0E " DESCARGANDO SCRIPT	: "
				powershell wget https://frp.geeklock.net/Tools/script/driver_cleanup.txt -OutFile %TEMP%\driver_cleanup.ps1
		call :c 0A "LISTO"
		echo.
		call :c 0E " LIMPIANDO DRIVERS	: "
				powershell -ExecutionPolicy Unrestricted -File %TEMP%\driver_cleanup.ps1 >nul 2>&1
				del %TEMP%\driver_cleanup.ps1
		call :c 0A "LISTO"
		echo.
		echo.
		pause
goto:inicio		

:op104
	echo.
		powershell wget https://frp.geeklock.net/Tools/cmd/idm.bat -OutFile %TEMP%\idm.bat
	start "" %TEMP%\idm.bat & exit

:op105
	echo.
	call :c 0E " DESACTIVANDO FIREWALL DE WINDOWS	: "
				netsh advfirewall set allprofiles state off >nul 2>&1
		call :c 0A "LISTO"
	echo.
	echo.
	pause
goto:inicio

echo. El numero "%var%" no es una opcion valida, por favor intente de nuevo.
echo.
pause
echo.
goto:inicio

:op84
    echo.
    echo. CREANDO PATCH QUALCOMM/KG
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "CREANDO PATCH QUALCOMM/KG"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " DESACTIVANDO UI SISTEMA: "
		@adb shell pm disable-user --user 0 com.sec.enterprise.knox.cloudmdm.smdms
		@adb shell pm uninstall --user 0 com.sec.android.soagent
		@adb shell pm uninstall --user 0 com.wssyncmldm
		@adb shell pm uninstall --user 0 com.sec.enterprise.knox.cloudmdm.smdms
		@adb shell pm uninstall --user 0 com.knox.vpn.proxyhandler
		@adb shell pm uninstall --user 0 com.samsung.bnk48
		@adb shell pm uninstall --user 0 android.autoinstalls.config.samsung
		@adb shell pm disable-user --user 0 com.samsung.android.kgclient
		@adb shell pm uninstall --user 0 com.samsung.android.fmm
		@adb shell pm uninstall --user 0 co.sitic.pp
		@adb shell pm uninstall --user 0 cv.sitic.tg
		@adb uninstall --user 0 com.samsung.bnk48
		@adb shell pm disable-user --user 0 com.sec.android.soagent
		@adb uninstall --user 0 com.sec.android.soagent
		@adb shell pm disable-user --user 0 com.wssyncmldm
		@adb uninstall --user 0 com.wssyncmldm
		@adb shell pm disable-user --user 0 com.samsung.android.knox.containercore
		@adb uninstall --user 0 com.samsung.android.knox.containercore
		@adb shell pm disable-user --user 0 com.sec.enterprise.knox.attestation
		@adb uninstall --user 0 com.sec.enterprise.knox.attestation
		@adb shell pm disable-user --user 0 com.samsung.android.knox.containeragent
		@adb uninstall --user 0 com.samsung.android.knox.containeragent
		@adb shell pm disable-user --user 0 com.samsung.knox.keychain
		@adb uninstall --user 0 com.samsung.knox.keychain
		@adb shell pm disable-user --user 0 com.samsung.knox.securefolder 
		@adb uninstall --user 0 com.samsung.knox.securefolder
		@adb shell pm disable-user --user 0 com.samsung.android.knox.analytics.uploader
		@adb uninstall --user 0 com.samsung.android.knox.analytics.uploader
		@adb shell pm disable-user --user 0 com.knox.vpn.proxyhandler
		@adb uninstall --user 0 com.knox.vpn.proxyhandler
		@adb shell pm disable-user --user 0 com.sec.enterprise.knox.cloudmdm.smdms
		@adb uninstall --user 0 com.sec.enterprise.knox.cloudmdm.smdms
		@adb shell pm disable-user --user 0 com.sec.enterprise.mdm.services.simpin
		@adb uninstall --user 0 com.sec.enterprise.mdm.services.simpin
		@adb shell pm disable-user --user 0 com.samsung.android.mdm
		@adb uninstall --user 0 com.samsung.android.mdm
		@adb uninstall --user 0 com.samsung.android.kgclient
		@adb shell pm disable-user --user 0 com.sec.android.sdhms
		@adb uninstall --user 0 com.sec.android.sdhms
		@adb shell pm disable-user --user 0 com.samsung.android.dqagent
		@adb uninstall --user 0 com.samsung.android.dqagent
		@adb shell pm disable-user --user 0 com.sec.epdg
		@adb uninstall --user 0 com.sec.epdg
		@adb shell pm disable-user --user 0 com.sec.spp.push
		@adb uninstall --user 0 com.sec.spp.push
		@adb shell pm disable-user --user 0 com.sec.android.app.samsungapps
		@adb uninstall --user 0 com.sec.android.app.samsungapps
		@adb shell pm disable-user --user 0 com.sec.epdgtestapp
		@adb uninstall --user 0 com.sec.epdgtestapp
		@adb shell pm disable-user --user 0 com.sec.ims
		@adb uninstall --user 0 com.sec.ims
		@adb shell pm disable-user --user 0 com.sec.sve
		@adb uninstall --user 0 com.sec.sve
		@adb shell pm disable-user --user 0 com.samsung.android.securitylogagent
		@adb uninstall --user 0 com.samsung.android.securitylogagent
		@adb shell pm disable-user --user 0 com.sec.bcservice
		@adb uninstall --user 0 com.sec.bcservice
		@adb shell pm disable-user --user 0 com.sec.modem.settings
		@adb uninstall --user 0 com.sec.modem.settings
		@adb shell pm disable-user --user 0 com.sec.imsservice
		@adb uninstall --user 0 com.sec.imsservice
		@adb shell pm disable-user --user 0 com.android.se
		@adb uninstall --user 0 com.android.se
		@adb shell pm disable-user --user 0 com.sec.spp.push
		@adb uninstall --user 0 com.sec.spp.push
		@adb shell pm disable-user --user 0 com.samsung.android.beaconmanager
		@adb uninstall --user 0 com.samsung.android.beaconmanager
		@adb shell pm disable-user --user 0 com.samsung.sec.android.application.csc
		@adb uninstall --user 0 com.samsung.sec.android.application.csc
		@adb shell pm disable-user --user 0 com.samsung.android.bbc.bbcagent
		@adb uninstall --user 0 com.samsung.android.bbc.bbcagent
		@adb shell pm disable-user --user 0 com.skms.android.agent
		@adb uninstall --user 0 com.skms.android.agent
		@adb shell pm disable-user --user 0 com.sec.android.easyMover.Agent
		@adb uninstall --user 0 com.sec.android.easyMover.Agent
		@adb shell pm disable-user --user 0 com.samsung.ucs.agent.boot
		@adb uninstall --user 0 com.samsung.ucs.agent.boot
		@adb shell pm disable-user --user 0 com.samsung.android.securitylogagent
		@adb uninstall --user 0 com.samsung.android.securitylogagent
		@adb shell pm disable-user --user 0 com.samsung.klmsagent
		@adb uninstall --user 0 com.samsung.klmsagent
		@adb shell pm disable-user --user 0 com.samsung.android.da.daagent
		@adb uninstall --user 0 com.samsung.android.da.daagent
		@adb shell pm disable-user --user 0 com.samsung.android.bbc.bbcagent
		@adb uninstall --user 0 com.samsung.android.bbc.bbcagent
		@adb shell pm disable-user --user 0 com.samsung.android.svcagent
		@adb uninstall --user 0 com.samsung.android.svcagent
		@adb shell pm disable-user --user 0 com.samsung.android.app.omcagent
		@adb uninstall --user 0 com.samsung.android.app.omcagent
		@adb shell pm disable-user --user 0 com.samsung.android.fmm
		@adb uninstall --user 0 com.samsung.android.fmm
		call :c 0A "LISTO"
    echo.
	echo.
    pause
goto:inicio

:op85
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "DESACTIVAR UI SISTEMA"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " DESACTIVANDO UI SISTEMA: "
		adb shell pm disable-user --user 0 com.android.systemui >nul
		call :c 0A "LISTO"
    echo.
	echo.
    pause
goto:inicio
	
:op86
    echo.
	call :c 0E " PROCESO		: "
    call :c 0C "ACTIVAR UI SISTEMA"
	echo.
	echo.
		call :adbreadinfo
		echo.
		call :c 0E " ACTIVANDO UI SISTEMA: "
		adb shell pm enable --user 0 com.android.systemui >nul
		call :c 0A "LISTO"
    echo.
	echo.
	echo.
    pause
goto:inicio

:noconnected
		echo.
		call :c 0E "  ***************************************"
		echo.
		call :c 0E "  *  DEBE ESTAR CONECTADO A INTERNET    *"
		echo.
		call :c 0E "  ***************************************"
		echo.
		echo.
		echo.
	pause
goto:inicio

:noroot
		echo.
		call :c 0E "  ********************************************"
		echo.
		call :c 0E "  *    EL EQUIPO DEBE ESTAR ROOTEADO         *"
		echo.
		call :c 0E "  *    ROOTEE O ENTREGUE PERMISOS SHELL      *"
		echo.
		call :c 0E "  ********************************************"
		echo.
		echo.
		echo.
	pause
goto:inicio
	
:fastbootreadxiaomi
		fastboot devices -l | find "fastboot" >nul
		if errorlevel 1 (
			goto:fastbootreadnc
		) else (
			goto:fastbootreadmi1
		)
		:fastbootreadmi1
		call :c 0E " DECTECTANDO PROCESADOR	: "
		set "cpudetect= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar kernel 2^>^&1 ^| findstr kernel') do set "cpudetect=%%a" >nul
		if "%cpudetect%"=="lk" (
			goto:fastbootreadmimtk
		) else (
			goto:fastbootreadmiqcom
				)
		)
		:fastbootreadmiqcom
		call :c 0C "QUALCOMM"
		echo. 
		set "codename= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar product 2^>^&1 ^| findstr product') do set "codename=%%a"
		set "serialno= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar serialno 2^>^&1 ^| findstr serialno') do set "serialno=%%a"
		set "memorytype= "
		for /f "tokens=2-3 delims=: " %%a in ('fastboot getvar variant 2^>^&1 ^| findstr variant') do set "memorytype=%%a %%b"
		set "bootloaderlock= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar unlocked 2^>^&1 ^| findstr unlocked') do set "bootloaderlock=%%a"
		if "%bootloaderlock%"=="no" (set "bootloaderlock=LOCKED") else (set "bootloaderlock=UNLOCKED")
		set "hwrev= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar hw-revision 2^>^&1 ^| findstr hw-revision') do set "hwrev=%%a"
		set "boardver= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar board_version 2^>^&1 ^| findstr board_version') do set "boardver=%%a"
		set "slotsim= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar slot-count 2^>^&1 ^| findstr slot-count') do set "slotsim=%%a"
		set "sistemab= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar current-slot 2^>^&1 ^| findstr current-slot') do set "sistemab=%%a"
		set "arb= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar anti 2^>^&1 ^| findstr anti') do set "arb=%%a"
		set "frpmi= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar frp 2^>^&1 ^| findstr frp') do set "frpmi=%%a"
		echo.
		call :c 0E " CODENAME		: "&call :c 06 "%codename%"
		echo.
		call :c 0E " SERIAL NUMBER		: "&call :c 06 "%serialno%"
		echo.
		call :c 0E " IP PUBLICA		: "&call :c 06 "%ippublica%"
		echo.
		call :c 0E " TIPO DE MEMORIA	: "&call :c 06 "%memorytype%"
		echo.
		call :c 0E " BOOTLOADER		: "&call :c 06 "%bootloaderlock%"
		echo.
		call :c 0E " BOARD VERSION		: "&call :c 06 "%boardver%"
		echo.
		call :c 0E " REV HARDWARE		: "&call :c 06 "%hwrev%"
		echo.
		call :c 0E " SLOT SIM		: "&call :c 06 "%slotsim%"
		echo.
		call :c 0E " ANTIROLLBACK		: "&call :c 06 "%arb%"
		echo.
		call :c 0E " FRP			: "&call :c 06 "%frpmi%"
		echo.
		exit/b
		
		:fastbootreadmimtk
		call :c 0C "MEDIATEK"
		echo. 
		set "codename= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar product 2^>^&1 ^| findstr product') do set "codename=%%a"
		set "serialno= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar serialno 2^>^&1 ^| findstr serialno') do set "serialno=%%a"
		set "frpmi= "
		for /f "tokens=1-3 delims=: " %%a in ('fastboot getvar has-slot:frp 2^>^&1 ^| findstr has-slot:frp') do set "frpmi=%%c"
		set "bootloaderlock= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar unlocked 2^>^&1 ^| findstr unlocked') do set "bootloaderlock=%%a"
		if "%bootloaderlock%"=="no" (set "bootloaderlock=LOCKED") else (set "bootloaderlock=UNLOCKED")
		set "hwrev= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar hw-revision 2^>^&1 ^| findstr hw-revision') do set "hwrev=%%a"
		set "slotsim= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar slot-count 2^>^&1 ^| findstr slot-count') do set "slotsim=%%a"
		set "arb= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar anti 2^>^&1 ^| findstr anti') do set "arb=%%a"
		set "sistemab= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar current-slot 2^>^&1 ^| findstr current-slot') do set "sistemab=%%a"
		echo.
		call :c 0E " CODENAME		: "&call :c 06 "%codename%"
		echo.
		call :c 0E " SERIAL NUMBER		: "&call :c 06 "%serialno%"
		echo.
		call :c 0E " IP PUBLICA		: "&call :c 06 "%ippublica%"
		echo.
		call :c 0E " SLOT SISTEMA		: "&call :c 06 "%sistemab%"
		echo.
		call :c 0E " BOOTLOADER		: "&call :c 06 "%bootloaderlock%"
		echo.
		call :c 0E " REV HARDWARE		: "&call :c 06 "%hwrev%"
		echo.
		call :c 0E " SLOT SIM		: "&call :c 06 "%slotsim%"
		echo.
		call :c 0E " ANTIROLLBACK		: "&call :c 06 "%arb%"
		echo.
		call :c 0E " FRP			: "&call :c 06 "%frpmi%"
		echo.
		exit/b
		
:fastbootreadmoto
		fastboot devices -l | find "fastboot" >nul
		if errorlevel 1 (
			goto:fastbootreadnc
		) else (
			goto:fastbootreadmoto1
		)
		:fastbootreadmoto1
		call :c 0E " DECTECTANDO PROCESADOR	: "
		set "cpudetect= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar kernel 2^>^&1 ^| findstr kernel') do set "cpudetect=%%a" >nul
		if "%cpudetect%"=="lk" (
			goto:fastbootreadmotomtk
		) else (
		set "cid= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar cid 2^>^&1 ^| findstr cid') do set "cid=%%a" >nul
		if not "cid"==" " (
			goto:fastbootreadmotoqcom
		) else (
			goto:fastbootreadmotospd
				)
		)
		:fastbootreadmotoqcom
		call :c 0C "QUALCOMM"
		echo. 
		set "codename= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar product 2^>^&1 ^| findstr product') do set "codename=%%a"
		set "serialno= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar serialno 2^>^&1 ^| findstr serialno') do set "serialno=%%a"
		set "memorytype= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar storage-type 2^>^&1 ^| findstr storage-type') do set "memorytype=%%a"
		set "bootloaderlock= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar unlocked 2^>^&1 ^| findstr unlocked') do set "bootloaderlock=%%a"
		set "carrierid= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar ro.carrier 2^>^&1 ^| findstr ro.carrier') do set "carrierid=%%a"
		set "slotsim= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar slot-count 2^>^&1 ^| findstr slot-count') do set "slotsim=%%a"
		set "modelo= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar sku 2^>^&1 ^| findstr sku') do set "modelo=%%a"
		set "imeimoto= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar imei 2^>^&1 ^| findstr imei') do set "imeimoto=%%a"
		set "frpmoto= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar frp-state 2^>^&1 ^| findstr frp-state') do set "frpmoto=%%a"
		set "idbat= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar battid 2^>^&1 ^| findstr battid') do set "idbat=%%a"
		set "cidmoto= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar cid 2^>^&1 ^| findstr cid') do set "cidmoto=%%a"
		set "cpumoto= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar cpu 2^>^&1 ^| findstr cpu') do set "cpumoto=%%a"
		set "sistemab= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar current-slot 2^>^&1 ^| findstr current-slot') do set "sistemab=%%a"
		set "emmcmoto= "
		for /f "tokens=2-3 delims=: " %%a in ('fastboot getvar emmc 2^>^&1 ^| findstr emmc') do set "emmcmoto=%%a %%b"
		set "rammoto= "
		for /f "tokens=2-3 delims=: " %%a in ('fastboot getvar ram 2^>^&1 ^| findstr ram') do set "rammoto=%%a %%b"
		echo.
		call :c 0E " MODELO			: "&call :c 06 "%modelo%"
		echo.
		call :c 0E " SERIAL NUMBER		: "&call :c 06 "%serialno%"
		echo.
		call :c 0E " IMEI			: "&call :c 06 "%imeimoto%"
		echo.
		call :c 0E " IP PUBLICA		: "&call :c 06 "%ippublica%"
		echo.
		call :c 0E " TIPO DE MEMORIA	: "&call :c 06 "%memorytype%"
		echo.
		call :c 0E " ALMACENAMIENTO		: "&call :c 06 "%emmcmoto%"
		echo.
		call :c 0E " RAM			: "&call :c 06 "%rammoto%"
		echo.
		call :c 0E " CPU			: "&call :c 06 "%cpumoto%"
		echo.
		call :c 0E " CID			: "&call :c 06 "%cidmoto%"
		echo.
		call :c 0E " BOOTLOADER 		: "&call :c 06 "%bootloaderlock%"
		echo.
		call :c 0E " ID BATERIA		: "&call :c 06 "%idbat%"
		echo.
		call :c 0E " SLOT SIM		: "&call :c 06 "%slotsim%"
		echo.
		call :c 0E " CODENAME		: "&call :c 06 "%codename%"
		echo.
		call :c 0E " CARRIER ID		: "&call :c 06 "%carrierid%"
		echo.
		call :c 0E " FRP			: "&call :c 06 "%frpmoto%"
		echo.
		echo.
		echo.
		echo off | clip
		(
		echo MODELO: %modelo%
		echo SN: %serialno%
		echo IMEI: %imeimoto%
		echo IP PUB: %ippublica%
		)| clip
		call :c 0E " SE HA COPIADO MODELO, SN, IMEI, IP EN EL PORTAPAPELES"
		
		exit/b
		
		:fastbootreadmotomtk
		call :c 0C "MEDIATEK"
		echo. 
		set "codename= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar product 2^>^&1 ^| findstr product') do set "codename=%%a"
		set "serialno= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar serialno 2^>^&1 ^| findstr serialno') do set "serialno=%%a"
		set "memorytype= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar variant 2^>^&1 ^| findstr variant') do set "memorytype=%%a"
		set "bootloaderlock= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar unlocked 2^>^&1 ^| findstr unlocked') do set "bootloaderlock=%%a"
		if "%bootloaderlock%"=="no" (set "bootloaderlock=LOCKED") else (set "bootloaderlock=UNLOCKED")
		set "carrierid= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar ro.carrier.ontim 2^>^&1 ^| findstr ro.carrier.ontim') do set "carrierid=%%a"
		set "slotsim= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar slot-count 2^>^&1 ^| findstr slot-count') do set "slotsim=%%a"
		set "modelo= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar ro.boot.hardware.sku 2^>^&1 ^| findstr ro.boot.hardware.sku') do set "modelo=%%a"
		set "sistemab= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar current-slot 2^>^&1 ^| findstr current-slot') do set "sistemab=%%a"
		set "frpmoto= "
		for /f "tokens=1-3 delims=: " %%a in ('fastboot getvar has-slot:frp 2^>^&1 ^| findstr has-slot:frp') do set "frpmoto=%%c"
		echo.
		call :c 0E " MODELO			: "&call :c 06 "%modelo%"
		echo.
		call :c 0E " SERIAL NUMBER		: "&call :c 06 "%serialno%"
		echo.
		call :c 0E " IP PUBLICA		: "&call :c 06 "%ippublica%"
		echo.
		call :c 0E " BOOTLOADER 		: "&call :c 06 "%bootloaderlock%"
		echo.
		call :c 0E " SLOT SIM		: "&call :c 06 "%slotsim%"
		echo.
		call :c 0E " CODENAME		: "&call :c 06 "%codename%"
		echo.
		call :c 0E " CARRIER ID		: "&call :c 06 "%carrierid%"
		echo.
		call :c 0E " SLOT SISTEMA		: "&call :c 06 "%sistemab%"
		echo.
		call :c 0E " FRP			: "&call :c 06 "%frpmoto%"
		echo.
		echo.
		echo.
		echo off | clip
		(
		echo MODELO: %modelo%
		echo SN: %serialno%
		echo IP PUB: %ippublica%
		)| clip
		call :c 0E " SE HA COPIADO MODELO, SN, IP EN EL PORTAPAPELES"
		exit/b
		
		:fastbootreadmotospd
		call :c 0C "SPREADTRUM"
		echo. 
		set "codename= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar product 2^>^&1 ^| findstr product') do set "codename=%%a"
		set "carrierid= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar ro.carrier.ontim 2^>^&1 ^| findstr ro.carrier.ontim') do set "carrierid=%%a"
		set "modelo= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar sku 2^>^&1 ^| findstr sku') do set "modelo=%%a"
		set "imeimoto= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar imei 2^>^&1 ^| findstr imei') do set "imeimoto=%%a"
		set "slotsim= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar persist.radio.multisim.config 2^>^&1 ^| findstr persist.radio.multisim.config') do set "slotsim=%%a"
		echo.
		call :c 0E " MODELO			: "&call :c 06 "%modelo%"
		echo.
		call :c 0E " SERIAL NUMBER		: "&call :c 06 "%serialno%"
		echo.
		call :c 0E " IMEI			: "&call :c 06 "%imeimoto%"
		echo.
		call :c 0E " IP PUBLICA		: "&call :c 06 "%ippublica%"
		echo.
		call :c 0E " SLOT SIM		: "&call :c 06 "%slotsim%"
		echo.
		call :c 0E " CODENAME		: "&call :c 06 "%codename%"
		echo.
		echo.
		echo.
		echo off | clip
		(
		echo MODELO: %modelo%
		echo SN: %serialno%
		echo IMEI: %imeimoto%
		echo IP PUB: %ippublica%
		)| clip
		call :c 0E " SE HA COPIADO MODELO, SN, IMEI, IP EN EL PORTAPAPELES"
		exit/b
		
:fastbootreadnc
		call :c 0E "  *******************************************************************"
		echo.
		call :c 0E "  * DISPOSITIVO NO DETECTADO, FAVOR CONECTE EL EQUIPO EN FASTBOOT   *"
		echo.
		call :c 0E "  *******************************************************************"
		echo.
		echo.
		echo.
	pause
goto:inicio

		:fastbootreadhuawei
		echo. 
		set "build= "
		for /f "tokens=2-3 delims=: " %%a in ('fastboot oem get-build-number 2^>^&1 ^| findstr bootloader') do set "build=%%a %%b"
		set "serialno= "
		for /f "tokens=1 delims=	" %%a in ('fastboot devices 2^>^&1 ^| findstr fastboot') do set "serialno=%%a"
		set "keyversion= "
		for /f "tokens=2 delims=) " %%a in ('fastboot oem get_key_version 2^>^&1 ^| findstr bootloader') do set "keyversion=%%a"
		set "bootloaderlock= "
		for /f "tokens=2 delims=) " %%a in ('fastboot oem get-bootinfo 2^>^&1 ^| findstr bootloader') do set "bootloaderlock=%%a"
		set "modelo= "
		for /f "tokens=2 delims=) " %%a in ('fastboot oem get-product-model 2^>^&1 ^| findstr bootloader') do set "modelo=%%a"
		set "androidv= "
		for /f "tokens=2 delims=:" %%a in ('fastboot oem oeminforead-ANDROID_VERSION 2^>^&1 ^| findstr bootloader') do set "androidv=%%a"
		set "fblock= "
		for /f "tokens=2-4 delims=: " %%a in ('fastboot oem lock-state info 2^>^&1 ^| findstr FB') do set "fblock=%%c"
		set "userlock= "
		for /f "tokens=2-4 delims=: " %%a in ('fastboot oem lock-state info 2^>^&1 ^| findstr USER') do set "userlock=%%c"
		set "idbat= "
		for /f "tokens=2 delims=) " %%a in ('fastboot oem battery_present_check 2^>^&1 ^| findstr bootloader') do set "idbat=%%a"
		set "vendorcountry= "
		for /f "tokens=2 delims=: " %%a in ('fastboot getvar vendorcountry 2^>^&1 ^| findstr vendorcountry') do set "vendorcountry=%%a"
		set "baseversion= "
		for /f "tokens=2-3 delims=: " %%a in ('fastboot oem oeminforead-BASE_VERSION 2^>^&1 ^| findstr bootloader') do set "baseversion=%%a %%b"
		set "customversion= "
		for /f "tokens=2-3 delims=: " %%a in ('fastboot oem oeminforead-CUSTOM_VERSION 2^>^&1 ^| findstr bootloader') do set "customversion=%%a %%b"
		set "preloadversion= "
		for /f "tokens=2-3 delims=: " %%a in ('fastboot oem oeminforead-PRELOAD_VERSION 2^>^&1 ^| findstr bootloader') do set "preloadversion=%%a %%b"
		echo.
		call :c 0E " MODELO			: "&call :c 06 "%modelo%"
		echo.
		call :c 0E " SERIAL NUMBER		: "&call :c 06 "%serialno%"
		echo.
		call :c 0E " BUILD NUMBER		: "&call :c 06 "%build%"
		echo.
		call :c 0E " VENDOR/COUNTRY		: "&call :c 06 "%vendorcountry%"
		echo.
		call :c 0E " KEY VERSION		: "&call :c 06 "%keyversion%"
		echo.
		call :c 0E " BOOTLOADER 		: "&call :c 06 "%bootloaderlock%"
		echo.
		call :c 0E " ID BATERIA		: "&call :c 06 "%idbat%"
		echo.
		call :c 0E " ANDROID		: "&call :c 06 "%androidv%"
		echo.
		call :c 0E " FB LOCKSTATE		: "&call :c 06 "%fblock%"
		echo.
		call :c 0E " USER LOCKSTATE		: "&call :c 06 "%userlock%"		
		echo.
		call :c 0E " BASE VERSION		: "&call :c 06 "%baseversion%"
		echo.
		call :c 0E " CUSTOM VERSION		: "&call :c 06 "%customversion%"
		echo.
		call :c 0E " PRELOAD VERSION	: "&call :c 06 "%preloadversion%"
		echo.
		echo.
		
		exit/b


:adbreadinfo
		adb devices -l | find "device product:" >nul 2>&1
		if errorlevel 1 (
			goto:adbreadnc
		) else (
			goto:adbread
		)
		:adbread
		set "modelo= "
		for /f "delims=" %%a in ('adb shell getprop ro.product.model') do set "modelo=%%a"
		set "build= "
		for /f "delims=" %%a in ('adb shell getprop ro.build.version.incremental') do set "build=%%a"
		set "version= "
		for /f "delims=" %%a in ('adb shell getprop ro.build.version.release') do set "version=%%a"
		set "modem= "
		for /f "delims=" %%a in ('adb shell getprop gsm.version.baseband') do set "modem=%%a"
		set "knox= "
		for /f "delims=" %%a in ('adb shell getprop knox.kg.state') do set "knox=%%a"
		set "chip= "
		for /f "delims=" %%a in ('adb shell getprop ro.hardware.chipname') do set "chip=%%a"
		set "sn= "
		for /f "delims=" %%a in ('adb get-serialno') do set "sn=%%a"
		set "imei= "
		for /f "delims=" %%a in ('adb shell "service call iphonesubinfo 1 | cut -c 52-66 | tr -d '.[:space:]'"') do set "imei=%%a"
		set "security= "
		for /f "delims=" %%a in ('adb shell getprop ro.build.version.security_patch') do set "security=%%a"
		set "csc= "
		for /f "delims=" %%a in ('adb shell getprop ro.csc.omcnw_code') do set "csc=%%a"
		set "carrierid= "
		for /f "delims=" %%a in ('adb shell getprop ro.boot.carrierid') do set "carrierid=%%a"
		set "brand= "
		for /f "delims=" %%a in ('adb shell getprop ro.product.manufacturer') do set "brand=%%a"
		set "simstate= "
		for /f "delims=" %%a in ('adb shell getprop gsm.sim.state') do set "simstate=%%a"
		call :c 0E " MARCA			: "&call :c 06 "%brand%"
		echo.
		call :c 0E " MODELO			: "&call :c 06 "%modelo%"
		echo.
		call :c 0E " SERIAL NUMBER		: "&call :c 06 "%sn%"
		echo.
		call :c 0E " CHIP			: "&call :c 06 "%chip%"
		echo.
		call :c 0E " IMEI			: "&call :c 06 "%imei%"
		echo.
		call :c 0E " IP PUBLICA		: "&call :c 06 "%ippublica%"
		echo.
		call :c 0E " VERSION ANDROID	: "&call :c 06 "%version%"
		echo.
		call :c 0E " COMPILACION		: "&call :c 06 "%build%"
		echo.
		call :c 0E " VERSION MODEM		: "&call :c 06 "%modem%"
		echo.
		call :c 0E " CODIGO CSC ROM		: "&call :c 06 "%csc%"
		echo.
		call :c 0E " CARRIER_ID		: "&call :c 06 "%carrierid%"
		echo.
		call :c 0E " PARCHE SEGURIDAD	: "&call :c 06 "%security%"
		echo.
		call :c 0E " ESTADO SIM		: "&call :c 06 "%simstate%"
		echo.
		call :c 0E " KG STATUS		: "&call :c 06 "%knox%"
		echo.
		exit/b

:adbreadnc
call :c 0E "  *******************************************************************"
echo.
call :c 0E "  * DISPOSITIVO NO DETECTADO, FAVOR CONECTE O ENTREGUE PERMISOS ADB *"
echo.
call :c 0E "  *******************************************************************"
echo.
echo.
echo.
pause
goto:inicio

:c
setlocal enableDelayedExpansion


:colorPrint Color  Str  [/n]
setlocal
set "s=%~2"
call :colorPrintVar %1 s %3
exit /b

:colorPrintVar  Color  StrVar  [/n]
if not defined DEL call :initColorPrint
setlocal enableDelayedExpansion
pushd .
':
cd \
set "s=!%~2!"
:: The single blank line within the following IN() clause is critical - DO NOT REMOVE
for %%n in (^"^

^") do (
  set "s=!s:\=%%~n\%%~n!"
  set "s=!s:/=%%~n/%%~n!"
  set "s=!s::=%%~n:%%~n!"
)
for /f delims^=^ eol^= %%s in ("!s!") do (
  if "!" equ "" setlocal disableDelayedExpansion
  if %%s==\ (
    findstr /a:%~1 "." "\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%"
  ) else if %%s==/ (
    findstr /a:%~1 "." "/.\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%"
  ) else (
    >colorPrint.txt (echo %%s\..\')
    findstr /a:%~1 /f:colorPrint.txt "."
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
  )
)
if /i "%~3"=="/n" echo(
popd
exit /b


:initColorPrint
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "DEL=%%A %%A"
<nul >"%temp%\'" set /p "=."
subst ': "%temp%" >nul
exit /b


:cleanupColorPrint
2>nul del "%temp%\'"
2>nul del "%temp%\colorPrint.txt"
>nul subst ': /d
exit /b

:salir
    @cls&exit