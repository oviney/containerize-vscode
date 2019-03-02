# buid docker image according to our spec
# docker build --no-cache -t oviney/ubuntu-vscode:latest .

# start VcXsrv if it is not started yet
$prog="$env:ProgramFiles\VcXsrv\vcxsrv.exe"
if (! (ps | ? {$_.path -eq $prog})) {& $prog -multiwindow -ac}

# get the IP address used by Docker for Windows
#| where {$_.InterfaceAlias -eq 'vEthernet (DockerNAT)' -and $_.AddressFamily -eq 'IPv4'} `
$ip = Get-NetIPAddress `
    | where {$_.InterfaceAlias -eq 'vEthernet (Default Switch)' -and $_.AddressFamily -eq 'IPv4'} `
    | select -ExpandProperty IPAddress

echo $ip

# start Visual Studo Code as the vscode user
# $cmd="export DISPLAY=${ip}:0; code -w ."
$cmd="code -w ."
set-variable -name DISPLAY -value ${ip}:0.0
echo $DISPLAY
docker run -ti -e DISPLAY=$DISPLAY --rm --security-opt seccomp=unconfined --name toolbox oviney/ubuntu-vscode:latest su - vscode -c $cmd