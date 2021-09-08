@echo off

docker build --tag joelvaneenwyk/msys2 .
if errorlevel 1 exit /b 2

docker push joelvaneenwyk/msys2
docker run -it joelvaneenwyk/msys2
