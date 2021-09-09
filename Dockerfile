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
RUN pacman -S --quiet --noconfirm --needed `
    msys2-devel msys2-runtime-devel msys2-keyring `
    base-devel git autoconf automake1.16 automake-wrapper libtool libcrypt-devel openssl `
    mingw-w64-x86_64-make mingw-w64-x86_64-gcc mingw-w64-x86_64-binutils `
    texinfo texinfo-tex mingw-w64-x86_64-texlive-bin mingw-w64-x86_64-texlive-core mingw-w64-x86_64-texlive-extra-utils `
    mingw-w64-x86_64-perl `
    mingw-w64-x86_64-poppler

ENV HOME C:\Users\ContainerAdministrator\
ENV MSYS winsymlinks:nativestrict

WORKDIR C:\Users\ContainerAdministrator\
COPY ./ ./
RUN ./setup.sh

ENTRYPOINT [ `
    "cmd", "/s", "/c", `
    "C:\\msys64\\msys2_shell.cmd", `
    "-no-start", "-msys2", "-defterm", "-shell", `
    "bash", "-l" `
]
