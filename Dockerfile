# Docker image for desktop app builds.
FROM windows/servercore:ltsc2019

RUN powershell -Command \
    # Install .net 3.5
    $ProgressPreference = "SilentlyContinue"; Install-WindowsFeature Net-Framework-Core \
    # Install choco
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) \ 
    # Install WiX
    choco install wixtoolset --installargs 'INSTALLFOLDER="C:\wix"' -y \
    # Chocolateyl install dependencies
    choco upgrade golang jq mingw openssl python windows-sdk-10-version-2004-all \
    # Chocolateyl install flutter BETA
    choco install flutter --pre \
    # Instlal Hover-shim.
    $env:GO111MODULE = "on" \
    go get -u -a github.com/worldr/hover-shim

CMD ["powershell"]
