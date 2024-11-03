# Configuração de codificação para UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 > $null

# Arte ASCII em UTF-8
$asciiArt = @"
                                                                                          
                      :-=++***++=-                                                ======  
                   -+*************.                                               *****+  
                 :****************                                               :*****-  
                :*******+-.     .:     .-==+++==:       .-==+++==:.      :-=++=-.=*****:  
                *******:             -************=   -************=   -***************.  
               -******+     .*****- +*****-::+*****- =*****-::+*****- =*****+-::+******   
               -******+     -*****.-*****.    *****-:*****:    *****=.******    :*****=   
               .*******+:.  +***** =*****    :*****:-*****.   .*****::*****+    =*****-   
                :****************+ :*****+=-=*****- .******--=*****= :******+--+******.   
                  -+*************=  -***********+:   :***********+:   -***************    
    :----------::.   .:---==--::.     .:-===--:        .:-====-:.       :-===-: -----:    
    +**************+:                                                                     
    ******++++*******                                                                     
   .*****=     ******      ::----:.      :::::  .:--:.   .:--:.               ,;;,        
   -*****=...:=****+.   -+**********=.  -*****+*******+:+*******.          ,ttttooo#;     
   +*************+:    +*****==+******  +*****+=+*******==******-              #ooo#o#    
   ******----=*****+: =*****    -*****. *****+   +*****.  =*****:             tooot  t#   
  .*****=     .****** *****=    =***** .*****=   *****+   +*****             #ooo~        
  :*****=::::-+*****+ +*****-.:-*****- -*****:  .*****=   *****+            #ooo~         
  =****************=  .************+:  =*****   -*****:  .*****=          ;oooo;          
  =+++++++++++==-.      :=+*****+-:    ++++++   -+++++   :+++++:         toooo,           
                                                                       ;oooot             
              ,                                                      ;#oooo;              
              ,t;                                                  ;#oooot                
                ;#t;                                             ;#oooot                  
                  ;#ot;                                       ;tooooot,                    
                    ,too#~;                                ;toooooo~                       
                       ;tooo#t~,                      ,;~#oooooot;                        
                          ;t#ooooo#t~~;;,,,,,,,;;~~t#oooooooot;                           
                              ;t#ooooooooooooooooooooooot~,                              
                                  ,;~tt#ooooooooo##t~;,                                   
                                                                                          
                                                                                          

"@

# Função para exibir a arte ASCII com cores
function Show-AsciiArt {
    param (
        [string]$art
    )

    foreach ($line in $art -split "`n") {
        foreach ($char in $line.ToCharArray()) {
            switch ($char) {
                'o' { Write-Host $char -NoNewline -ForegroundColor DarkYellow }
                't' { Write-Host $char -NoNewline -ForegroundColor DarkYellow }
                '~' { Write-Host $char -NoNewline -ForegroundColor Cyan }
                '#' { Write-Host $char -NoNewline -ForegroundColor Cyan }
                ',' { Write-Host $char -NoNewline -ForegroundColor Cyan }
                '=' { Write-Host $char -NoNewline -ForegroundColor Blue }
                '+' { Write-Host $char -NoNewline -ForegroundColor Blue }
                '*' { Write-Host $char -NoNewline -ForegroundColor Blue }
                ':' { Write-Host $char -NoNewline -ForegroundColor Blue }
                '.' { Write-Host $char -NoNewline -ForegroundColor Blue }
                '-' { Write-Host $char -NoNewline -ForegroundColor Blue }
                default { Write-Host $char -NoNewline }  # Caractere padrão
            }
        }
        Write-Host  # Nova linha
    }
}

# Configurações adicionais de interface, caso estejam interferindo
$host.UI.RawUI.BackgroundColor = "Black"  # Fundo preto
$host.UI.RawUI.ForegroundColor = "Green"  # Texto verde padrão
Clear-Host


function Prompt {
    Write-Host ("Terminal TI > " + $(Get-Location)) -NoNewline -ForegroundColor Yellow
    return " "
}

# Dicionário para armazenar as opções do menu principal
$menuOptions = @{
    "1" = @{ Description = "Limpeza"; Action = { Show-CleanupMenu } }
    "2" = @{ Description = "Internet"; Action = { Show-InternetMenu } }
    "3" = @{ Description = "Configurações"; Action = { Show-InternetMenu } }
    "4" = @{ Description = "Obter Log"; Action = { Show-InternetMenu } }
    "r" = @{ Description = "Sair"; Action = { return $false } }
}

function Show-CleanupMenu {
    Clear-Host
   Show-AsciiArt -art $asciiArt
    Write-Host "Menu de Limpeza:"
    $cleanupOptions = @{
        "a" = @{ Description = "Limpar Downloads de todos os usuários"; Action = { Clear-Downloads } }
        "b" = @{ Description = "Limpar Arquivos Temporários de todos os usuários"; Action = { Clear-TempFiles } }
        "r" = @{ Description = "Voltar ao Menu Principal"; Action = { return $false } }
    }
    foreach ($key in $cleanupOptions.Keys) {
        Write-Host "$key. $($cleanupOptions[$key].Description)"
    }
    $choice = Read-Host "Digite a opção desejada"
    if ($cleanupOptions.ContainsKey($choice)) {
        if ($choice -ne 'r') {
            & $cleanupOptions[$choice].Action
        }
        return $true
    } else {
        Write-Host "Opção inválida. Por favor, escolha uma opção válida." -ForegroundColor Red
    }
}

function Show-InternetMenu {
    Clear-Host
   Show-AsciiArt -art $asciiArt
    Write-Host "Menu de Internet:"
    $internetOptions = @{
        "a" = @{ Description = "Reiniciar o Roteador"; Action = { Restart-Router } }
        "b" = @{ Description = "Verificar Conexão"; Action = { Check-Connection } }
        "r" = @{ Description = "Voltar ao Menu Principal"; Action = { return $false } }
    }
    foreach ($key in $internetOptions.Keys) {
        Write-Host "$key. $($internetOptions[$key].Description)"
    }
    $choice = Read-Host "Digite a opção desejada"
    if ($internetOptions.ContainsKey($choice)) {
        if ($choice -ne 'r') {
            & $internetOptions[$choice].Action
        }
        return $true
    } else {
        Write-Host "Opção inválida. Por favor, escolha uma opção válida." -ForegroundColor Red
    }
}

# Loop do menu principal, executando a ação correspondente até o usuário escolher sair
$continue = $true
while ($continue) {
    Clear-Host
   Show-AsciiArt -art $asciiArt
    Write-Host "Selecione uma opção:"
    foreach ($key in $menuOptions.Keys) {
        Write-Host "$key. $($menuOptions[$key].Description)"
    }
    
    $choice = Read-Host "Digite a opção desejada"

    if ($menuOptions.ContainsKey($choice)) {
        if ($choice -eq 'r') {
            $continue = $false
        } else {
            $continue = & $menuOptions[$choice].Action
        }
    } else {
        Write-Host "Opção inválida. Por favor, escolha uma opção válida." -ForegroundColor Red
    }
}
