@echo off
cls
title Hide Folder

if NOT EXIST .\PasswordGenerator (
  set CurrentError="main.bat must be in original folder"
  goto FAIL
)

set standartPasswordLength="24"
set CurrentError="NONE"

echo Enter the folder name
set /p "foldername=>"
set FullFolderName=%foldername%_LOCK

if EXIST %FullFolderName% goto UNLOCK
if NOT EXIST %foldername% goto MDLOCKER

:CONFIRM
echo Are you sure you want to lock the folder(Y/N)
set /p "cho=>"
if %cho%==Y goto LOCK
if %cho%==y goto LOCK
if %cho%==n goto END
if %cho%==N goto END

echo Invalid choice.
goto CONFIRM

:LOCK
echo Enter the password for the folder (You can get random password)
set /p "pass=>"

ren %foldername% %FullFolderName%

attrib +h +s %FullFolderName%
if %pass%==random goto RANDOM_PASSWORD
if %pass%==RANDOM goto RANDOM_PASSWORD

echo %pass% >> %FullFolderName%/password
attrib +h +s  %FullFolderName%/password

echo Folder locked
goto End

:UNLOCK
attrib -h -s  %FullFolderName%\password

echo Enter password to unlock folder:
 <%FullFolderName%\password set /p "pass="

set /p "EnteredPass=>"
if NOT %EnteredPass%== %pass% (
  set CurrentError="Invalid Password"
  goto FAIL
)

attrib -h -s %FullFolderName%
ren %FullFolderName% %foldername%

del "%foldername%\password"
echo Folder Unlocked successfully
pause
goto End

:FAIL
color 4
echo ERROR: %CurrentError%
pause
goto End

:RANDOM_PASSWORD
cd .\PasswordGenerator
node passGen %FullFolderName%  %standartPasswordLength%
cd ..\
pause
attrib +h +s  %FullFolderName%\password
goto End

:MDLOCKER
md %foldername%
echo Folder created successfully
pause
goto End

:End
cls
