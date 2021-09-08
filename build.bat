@echo off

docker build --tag msys .
if errorlevel 1 exit /b 2

docker run -it msys
