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

# executes mingw shell command
function exec-install-shell($bash) {
    $command = '"' + $bash + '" --login -i "bin\install.sh" ' + '"' + $bash + '" ' + '"' + $cwd + '"'
    iex "& $command"
}

# run docker image given by name
function test-image($name) {
    docker run -ti --rm $name whoami
    "$?"
}

# prints message and separator
function status-line($msg) {
    Write-Host $msg
    Write-Host "----------------------------------------------------------"
}


# find dokcer and docker-machine path
$DockerPath        = which docker
$DockerMachinePath = which docker-machine


# check whether is docker installed
if (!$DockerPath -Or !$DockerMachinePath) {
    Write-Host "Docker is not installed, running DockerToolbox installer"
    $installer = "$cwd\libs\DockerToolbox.exe"
    Write-Host $installer
    Start-Process $installer -NoNewWindow -Wait
    Write-Host "Installation finished. Exiting installation script for it to take an effect."
    Write-Host "After terminal exits run installation script again."
    pause
    exit
}


# inject docker env
status-line "Preparing docker..."
docker-machine create --driver virtualbox default
docker-machine start default
& "docker-machine.exe" env | Invoke-Expression

# find bash
$BashPath32a = "${Env:ProgramFiles(x86)}\Git\bin\bash.exe"
$BashPath32b = "${Env:ProgramFiles}\Git\bin\bash.exe"
$BashPath64  = "${Env:ProgramW6432}\Git\bin\bash.exe"
$BashPath    = which bash

$BashLocations = @($BashPath32a, $BashPath32b, $BashPath64, $BashPath)

# test bash locations and run configure if found
Foreach ($bash in $BashLocations) {
    if($bash) {
        #Write-Host "Testing path: $bash"
        if (Test-Path $bash) {
            status-line "Executing shell using $bash"
            exec-install-shell $bash
            Break
        }
    }
}


# test image
status-line "Testing image '@IMAGE_NAME@'"
test-image "@IMAGE_NAME@"

# test altered image
status-line "Testing image '@IMAGE_NAME@:user'"
test-image "@IMAGE_NAME@:user"

# exit installation
status-line "Installation finished, press any key to exit ..."
#$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")