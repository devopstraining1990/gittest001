class DotNetSolutionBuild {
    [string] $SolutionPath
    [string] $ProjectName
    [string] $OutputPath
    [string] $Configuration

    DotNetSolutionBuild([string] $SolutionPath, [string] $ProjectName, [string] $OutputPath, [string] $Configuration) {
        $this.SolutionPath = $SolutionPath
        $this.ProjectName = $ProjectName
        $this.OutputPath = $OutputPath
        $this.Configuration = $Configuration
    }

    [void] BuildSolutionCopyDll() {
        try {
            Write-Host "I ma herre"
            ##Set-Location "C:\Users\honey\Powershell7\dotnet-8-samples-main\src\WeatherApi"
            Write-Host "I am also here"
            #cd .\WeatherApi
            $solpath = Join-Path (Join-Path $this.SolutionPath "src") ($this.ProjectName)
            dotnet build $solpath --configuration $this.Configuration

            $dllPath = Join-Path (Join-Path $this.SolutionPath  "artifacts" ) ("bin\$($this.ProjectName)\$($this.Configuration)")
  
            $finalPath = Join-Path -Path $dllPath -ChildPath "*"

            $outpath = Join-Path $this.OutputPath $this.ProjectName

            Remove-Item -Path $outpath -Recurse -Force

                New-Item -Path $outpath -ItemType Directory
                Write-Host "Directory created successfully: $outpath"
      
            Copy-Item -Path $finalPath -Destination  $outpath -Force

        }

        catch {
            Write-Host "Excepton Occured: $_.Exception.Message"
        }
    }
}

$solutionPath = "C:\Users\honey\Powershell7\dotnet-8-samples-main\"
$projectName = "CSharp12"
$outputPath = "C:\Users\honey\Powershell7\Output-Dlls\"
$configuraton = "Release"

$buildsolution = [DotNetSolutionBuild]::new($solutionPath, $projectName, $outputPath, $configuraton)
$buildsolution.BuildSolutionCopyDll()
