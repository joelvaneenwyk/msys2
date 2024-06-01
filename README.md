# MSYS2 Windows Container

Setup scripts for a MSYS2 environment on Windows. This was born out of
development work done for [GNU Stow](https://www.gnu.org/software/stow/) and
repeatedly running into issues with host environment changing and impacting
testing.

Total install of an MSYS2 environment for GNU development with documentation
creation tools (e.g., tex, texlive, etc) is 3GB+ and with a considerable build
time. This Docker image is meant to solve that by providing a reliable
environment for testing that changes very little.
