Set-Location "D:\Movies"

$my_file_objects = Get-ChildItem -File |  Where-Object { $_ -NotMatch ".ps1"} | Group-Object { $_.Name -replace ' .*' }
foreach($dir in $my_file_objects) {

    Write-Output $dir.Name
    if (!(Test-Path $dir.Name)) {
        
        New-Item -Type Directory -Name $dir.Name

    } 
    else 
    {

        Write-Output "$dir.Name folder already created"

    }

    

}

For ($i=0; $i -lt $my_file_objects.Count; $i++) {
    foreach ($Name in $my_file_objects[$i].Name){
            foreach ($file in $my_file_objects[$i].Group){

                Write-Output "Moving $file to $Name"
                Move-Item $file -Destination $Name
            }
    }

}
