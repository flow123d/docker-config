# To allow running powershell scripts, open powershell as admin and run:
# Set-ExecutionPolicy Unrestricted

# get script location
$cwd = split-path -parent $MyInvocation.MyCommand.Definition

# finds executable in path and return it (or null)
function which($name) {
    Try {
        $path = (Get-Command $name).Path 2> $null
        if (!$path) {
            return $null
        }
          return $path
    } Catch {
        return $null
    }
}

# prints message and separator
function status-line($msg) {
    Write-Host $msg
    Write-Host "----------------------------------------------------------"
}

# find dokcer and docker-machine path
$DockerPath         = which docker
$DockerMachinePath  = which docker-machine

# check whether is docker installed, if not, we cant do anything
if (!$DockerPath -Or !$DockerMachinePath) {
    Write-Host "Docker is not installed, cannot uninstall image"
    pause
    exit
}

# inject docker env
status-line "Preparing docker..."
docker-machine create --driver virtualbox default
docker-machine start default
& "docker-machine.exe" env | Invoke-Expression

# remove image created
status-line "Removing images '@IMAGE_NAME@:user' and '@IMAGE_NAME@'"
docker rmi -f @IMAGE_NAME@:user
docker rmi -f @IMAGE_NAME@

#Remove-Item -Recurse -Force "$cwd"
#Get-ChildItem -Path $cwd -Recurse | Remove-Item -force -recurse
#Remove-Item $cwd -Force 

# exit uninstall
status-line "Uninstall finished"
#$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")