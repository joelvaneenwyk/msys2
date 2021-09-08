# escape=`

# select as base image matching your host to get process isolation
FROM mcr.microsoft.com/windows/servercore:20H2

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -UseBasicParsing -uri "https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.sfx.exe" -OutFile msys2.exe; `
    .\msys2.exe -y -oC:\; `
    Remove-Item msys2.exe ;

SHELL ["cmd", "/s", "/c"]
RUN echo cmd /s /c C:\\msys64\\msys2_shell.cmd -where C:\\Users\\ContainerAdministrator -here -no-start -msys2 -defterm -shell bash -lc "%*" >"C:\bash.bat"

# https://www.msys2.org/docs/ci/#docker
SHELL ["cmd", "/s", "/c", "C:\\bash.bat"]
RUN echo Finished initial setup.
RUN pacman --noconfirm -Syuu
RUN pacman --noconfirm -Syuu
RUN pacman --noconfirm -Scc

WORKDIR C:\Users\ContainerAdministrator\
COPY ./ ./
RUN cp -f nsswitch.conf /etc/nsswitch.conf
RUN ./setup.sh

ENTRYPOINT [ "C:\\msys64\\usr\\bin\\bash.exe", "-l" ]
