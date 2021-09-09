@echo off

setlocal EnableDelayedExpansion

set _image=joelvaneenwyk/msys2
docker build --tag %_image% .
if errorlevel 1 exit /b 2

docker push %_image%

docker run -it --rm --name "msys2" -v /nfs:/nfs:shared -v %cd%:C:/Users/ContainerAdministrator/workspace %_image%
