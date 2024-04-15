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
            $solpath = Join-Path -Path $this.SolutionPath -ChildPath  $this.ProjectName
            dotnet build $solpath --configuration $this.Configuration
            $dllPath = Join-Path (Join-Path $this.SolutionPath  "artifacts" ) ("bin\$($this.ProjectName)\$($this.Configuration)")
            $finalPath = Join-Path -Path $dllPath -ChildPath "*"
            $outpath = Join-Path $this.OutputPath $this.ProjectName
            Remove-Item -Path $outpath -Recurse -Force
            New-Item -Path $outpath -ItemType Directory
            Copy-Item -Path $finalPath -Destination  $outpath -Force

        }

        catch {
            Write-Host "Excepton Occured: $_.Exception.Message"
        }
    }
}

$solutionPath = "C:\Users\honey\Powershell7\dotnet-8-samples-main\"
$projectName = "WeatherApi"
$outputPath = "C:\Users\honey\Powershell7\Output-Dlls\"
$configuraton = "Release"

$buildsolution = [DotNetSolutionBuild]::new($solutionPath, $projectName, $outputPath, $configuraton)
$buildsolution.BuildSolutionCopyDll()
