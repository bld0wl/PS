    # Folder cleaner 1.0

    # Define with "-directory" what folder that is supposed to get some sweet luvin
    [CmdLetBinding()] 
    param (
            [string]$directory
    )


    $fileExtensions = @{
    "1. Images" = @('.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff', '.svg', '.webp', '.heif', '.raw', '.heic', '.ai', '.psd', '.indd')
    "2. Movies" = @('.mp4', '.mov', '.avi', '.mkv', '.wmv', '.flv', '.mpeg', '.webm', '.3gp', '.m4v')
    "3. Documents" = @('.txt', '.doc', '.docx', '.pdf', '.odt', '.rtf', '.tex', '.md', '.pages', '.xls', '.xlsx', '.xlsm')
    "4. Logs" = @('.log', '.evtx', '.csv')
    "5. Archives"  = @('.zip', '.rar', '.tar', '.7z','.iso', '.dmg')
    "6. Executables" = $('.exe', '.msi')
    "7. Audio" = $('.mp3', '.wav', '.ogg')

    }

    # Get all the files in the defined directory
    $files = Get-ChildItem -Path $directory -File

    # For every file in the defined directory do this
    foreach ($file in $files)   {

        # For every category in the hash list do this
        foreach ($category in $fileExtensions.Keys) {
    
            # If the files extension lives in the hahs list do this
            if ($file.Extension -in $fileExtensions[$category]) {

                # Set sorting destination
                $fileDestination = Join-Path $directory $category

                # If the category-folder doesnt exist, create it
                if (-not (Test-path $fileDestination)) {

                    # Create folder
                    New-Item -path $fileDestination -ItemType Directory
                    Write-Host "Folder '$fileDestination' created."
                    
                }

                try {
                    
                    # Move the file to its directory
                    Move-Item -path $file.FullName -Destination $fileDestination
                    Write-Host "Sorting '$($file.Fullname)' to where its supposed to live."

                } catch {

                    Write-host "Error moving '$file.Fullname' to '$fileDestination' due to it not existing..."
                
                }

                }

            }

    }



