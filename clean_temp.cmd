@echo off
title Windows Cleanup Tool
echo ===========================================
echo Advanced Windows Cleanup
echo ===========================================

:: --- 0. cleanmgr ---
echo Cleanmgr...
cleanmgr /sagerun:1

:: --- 1. Temp Folders ---
echo Deleting Temp files...
del /f /s /q "%windir%\Temp\*.*" >nul 2>&1
for /d %%p in ("%windir%\Temp\*") do rmdir "%%p" /s /q >nul 2>&1

del /f /s /q "%temp%\*.*" >nul 2>&1
for /d %%p in ("%temp%\*") do rmdir "%%p" /s /q >nul 2>&1

:: --- 3. Recycle Bin ---
echo Emptying Recycle Bin...
rd /s /q "%systemdrive%\$Recycle.Bin" >nul 2>&1

:: --- 4. Windows Update cache ---
echo Clearing Windows Update cache...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /f /s /q "%windir%\SoftwareDistribution\Download\*.*" >nul 2>&1
for /d %%p in ("%windir%\SoftwareDistribution\Download\*") do rmdir "%%p" /s /q >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

:: --- 5. Delivery Optimization cache ---
echo Clearing Delivery Optimization cache...
del /f /s /q "%windir%\SoftwareDistribution\DeliveryOptimization\*.*" >nul 2>&1
for /d %%p in ("%windir%\SoftwareDistribution\DeliveryOptimization\*") do rmdir "%%p" /s /q >nul 2>&1

:: --- 6. Logs ---
echo Deleting old log files...
del /f /s /q "%windir%\Logs\*.*" >nul 2>&1
for /d %%p in ("%windir%\Logs\*") do rmdir "%%p" /s /q >nul 2>&1

del /f /s /q "%windir%\System32\LogFiles\*.*" >nul 2>&1
for /d %%p in ("%windir%\System32\LogFiles\*") do rmdir "%%p" /s /q >nul 2>&1

:: --- 7. Crash Dumps & Error Reports ---
echo Deleting crash dumps and error reports...
del /f /s /q "%LOCALAPPDATA%\CrashDumps\*.*" >nul 2>&1
for /d %%p in ("%LOCALAPPDATA%\CrashDumps\*") do rmdir "%%p" /s /q >nul 2>&1

del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\WER\*.*" >nul 2>&1
for /d %%p in ("%LOCALAPPDATA%\Microsoft\Windows\WER\*") do rmdir "%%p" /s /q >nul 2>&1

echo ===========================================
echo Cleanup Completed! (Locked files skipped)
echo ===========================================
pause
