# Example http://www.omdbapi.com/?t=Rambo&y=2019&apikey=f174109a#
$Base_URL="http://www.omdbapi.com/?"
$API_Key="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
$Search_String = "Rambo"
$Year = "2019"
$Parameters="t=$Search_String&y=$Year&apikey=$API_KEY"

Function Get-MovieInfo
{
Param(
    [Parameter(Mandatory=$true,Position=0)] $MovieName,
    [Parameter(Position=1)] [ValidateSet('full','short')] $Plot ="short",
    [Parameter(Position=2)] $Year
    )
    Write-Output "http://www.omdbapi.com/?=$MovieName&y=&plot=$Plot&r=xml&apikey=$API_Key"
( [ xml ] (Invoke-WebRequest "http://www.omdbapi.com/?t=$MovieName&y=$Year&plot=$Plot&r=xml&apikey=$API_Key")).root.movie
}

Set-Location "D:\Movies"

$my_file_objects = Get-Childitem –Path D:\Movies -File -Recurse |  Where-Object { $_ -NotMatch ".ps1"} |  Where-Object { $_ -NotMatch ".txt"}

foreach ($search in $my_file_objects){

    $processString = $search.Name
    Write-Output "Processing: $search"
    $StripFileExtension = $processString.Substring(0, $processString.IndexOf('.'))
    $pos = $StripFileExtension.IndexOf(" ")
    $SearchStringYear = $StripFileExtension.Substring(0, $pos)
    $SearchStringName = $StripFileExtension.Substring($pos+1)
    #Write-Output "Searching with $SearchStringName $SearchStringYear"
    $result = Get-MovieInfo $SearchStringName Short $SearchStringYear
    if (!($result.type )) {
        Write-Output "Failed to get a result for $SearchStringName $SearchStringYear"
    } 
    else
    {
        #Write-Output "Writing Synopsis for $SearchStringName $SearchStringYear to $SearchStringYear\$SearchString.txt"
        if (Test-Path D:\Movies\$SearchStringYear\$SearchStringName.txt)
        {
            Remove-Item D:\Movies\$SearchStringYear\$SearchStringName.txt
            Write-Output $result | Out-File D:\Movies\$SearchStringYear\$SearchStringName.txt
        }
        else
        {
            Write-Output $result | Out-File D:\Movies\$SearchStringYear\$SearchStringName.txt
        }


    }

}
