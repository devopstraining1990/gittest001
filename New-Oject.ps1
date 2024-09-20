$custiomobject = @{
    firstname = "suresh"
    lastname  = "meenige"
}

ytyt yjyuy $outobj = New-Object psobject -Property $custiomobject;
Write-Host $outobj | Format-List 
