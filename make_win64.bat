@echo off
set BuildDir=.\build

if exist %BuildDir% (
	echo deleting %BuildDir% cache files...
	del %BuildDir%\* /Q /f /s
	echo deleted all cache files done
) else (
	echo create build directory %BuildDir%
	md %BuildDir%
)

cd %BuildDir%
pushd
cmake  -G "Visual Studio 16 2019" -A x64  .. 
popd
pause