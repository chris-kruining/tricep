Function Build {
    Clear-Host

    az deployment sub create `
      --location 'west europe' `
      --template-file '.\example\containerApps\environment.bicep' `
      --parameters '.\example\containerApps\params\environment.dev.bicepparam' `
      --what-if

    Write-Host 'Done' -ForegroundColor green
}

Function Watch {
    $global:FileChanged = $false

    $folder = "$pwd"
    $filter = "*.bicep"
    
    Write-Host $folder

    $watcher = New-Object System.IO.FileSystemWatcher $folder, $filter -Property @{
        IncludeSubdirectories = $true
        EnableRaisingEvents = $true
    }

    $action = {
        $global:FileChanged = $true
    }

    Register-ObjectEvent $watcher "Created" -Action $action
    Register-ObjectEvent $watcher "Changed" -Action $action
    Register-ObjectEvent $watcher "Deleted" -Action $action
    Register-ObjectEvent $watcher "Renamed" -Action $action

    while ($true){
        while ($global:FileChanged -eq $false){
            # We need this to block the IO thread until there is something to run 
            # so the script doesn't finish. If we call the action directly from 
            # the event it won't be able to write to the console
            Start-Sleep -Milliseconds 100
        }

        # a file has changed, run our stuff on the I/O thread so we can see the output
        Build

        # reset and go again
        $global:FileChanged = $false
    }
}

Watch
