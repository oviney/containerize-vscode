# start VcXsrv if it is not started yet
$prog="$env:ProgramFiles\VcXsrv\vcxsrv.exe"
if (! (ps | ? {$_.path -eq $prog})) {& $prog -multiwindow -ac}

# docker images

# docker start -ai a1b086104d20

# -v C:\Users\ouray\OneDrive\DEV:/mnt/onedrive

docker run -ti -e DISPLAY=$DISPLAY --rm --security-opt seccomp=unconfined --name toolbox oviney/ubuntu-vscode:latest su - vscode -c $cmd