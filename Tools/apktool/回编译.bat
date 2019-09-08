java -jar apktool.jar b -f %1

@echo off
REM xcopy .\%1\dist\%1.apk .\%1\original\ /y
REM xcopy .\Tools\other.exe .\%1\original\ /y

REM cd .\%1\original
REM other.exe -m %1.apk AndroidManifest.xml META-INF/*
REM cd ..
REM cd ..
REM pause
REM xcopy .\%1\original\%1.apk .\%1\dist\%1\ /y

Pause
EXIT