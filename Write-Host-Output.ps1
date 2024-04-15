function test-output {
    Write-Output "Hello World!"
}

function  test-host {
    Write-Host "Hello test host" -ForegroundColor Green
    
}

function receive-hsot {
    process { Write-Host $_ -ForegroundColor Yellow }
}

test-output | receive-hsot
test-host | receive-hsot
test-output