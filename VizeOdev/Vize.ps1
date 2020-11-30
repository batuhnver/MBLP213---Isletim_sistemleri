function arrayFilterSpace {
    param($array)
    $result = @()
    for($i = 0; $i -lt $array.length; $i++) {
        if ($array[$i]) {
            $result += $array[$i];
        }
    }
    return $result
}

$output = ""
$i = 0
foreach($item in Get-Process) {
   $find = netstat -ano | findstr $item.Id 

   if ($find) {
        $result = arrayFilterSpace("$find".Split(' '));
        $port = $result[1].Substring($result[1].lastIndexOf(':')+1)
        
        $name = $item.Name
        $path = $item.Path
        $protocol = $result[0]

        $data = "Servis Adı: $name`r`n"
        $data += "Port: $port`r`n"
        $data += "Protokol: $protocol`r`n"
        $data += "Path: $path`r`n`r`n"
        $output += $data
        $data
        $i++
    }
}

$totalText = "`r`nToplamda Bulunan: $i"
$output += $totalText
$totalText

cd ~\Desktop
$output | Out-File -FilePath ./output.txt