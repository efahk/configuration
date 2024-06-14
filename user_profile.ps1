# Load prompt config 
oh-my-posh --init --shell pwsh --config "$env:POSH_THEMES_PATH\negligible.omp.json" | Invoke-Expression

# Icons 
Import-Module -Name Terminal-Icons

# PSReadLinejk
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History


# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Aliases
Set-Alias vim nvim

# No use case for hte ones below here 
#Set-Alias ll ls 
#Set-Alias g git 
#Set-Alias grep findstr 
#Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
#Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Utilities
function which ($command)
{
	Get-Command -Name $command -ErrorAction SilentlyContinue | 
		Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })

.  C:\Users\kwefah\Documents\PowerShell\Aliases.ps1
