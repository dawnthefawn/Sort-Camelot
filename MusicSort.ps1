Function Get-Camelot
{
    Param(
        [String]$path
    )
    Write-host $path
    $camelots = @{
        Dbm = "1A";
        E = "1B";
        Abm = "2A";
        B = "2B";
        Ebm = "3A";
        Gb = "3B";
        Bbm = "4A";
        Db = "4B";
        Fm = "5A";
        Ab = "5B";
        Cm = "6A";
        Eb = "6B";
        Gm = "7A";
        Bb = "7B";
        Dm = "8A";
        F = "8B";
        Am = "9A";
        C = "9B";
        Em = "10A";
        G = "10B";
        Bm = "11A";
        D = "11B";
        Gbm = "12A";
        A = "12B"
    }
    $camelots | ForEach-Object {

        If (-Not(Test-path "$( $path )\$( $_.key )"))
        {
            New-Item -ItemType Directory -path $path -name $( $_.Key )
        }
    }

    $files = Get-Childitem -Recurse -File -Path $path;
    $camelots.Keys | % {
        $currkey = $_
        $currcam = $camelots.($currkey)
        $currcamnum = $currcam.Substring(0, $currcam.Length - 1)
        $currkey
        $Currfiles = $files | where-object { $_.name -like "*- $currkey -*" }
        If (-Not(Test-Path "$path\$currcamnum"))
        {
            New-item -itemtype Directory -path $path -name $currcamnum
        }
        $currfiles | % {
            Try
            {
                Move-item $_.FullName "$path\$currcamnum"
            }
            catch
            {
                write-output $_.exception.message
            }
        }
    }

    Write-output "Total Files: $( ( ($files | measure-object -sum -property length)).sum / 1MB )"


}
Get-Camelot -Path "~/Music/Psydal"
