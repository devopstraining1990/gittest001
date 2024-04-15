$custiomobject = @{
    firstname = "suresh"
    lastname  = "meenige"
}

$outobj = New-Object psobject -Property $custiomobject;
Write-Host $outobj | Format-List 