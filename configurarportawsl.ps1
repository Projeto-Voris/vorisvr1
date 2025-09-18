# Script para encaminhar porta do Host Windows para o Guest WSL2

# --- Configuração ---
$wsl_port = 8080
$windows_port = 8080
# --------------------

Write-Host "Iniciando configuração de port forwarding para WSL2..."

# Pega o endereço IP da distro WSL. O comando wsl.exe executa um comando dentro do Linux.
$wsl_ip_string = wsl.exe -- ip addr show eth0 | findstr "inet "
$wsl_ip = ($wsl_ip_string -split ' ')[5] -replace '/.*'

# Verifica se o IP foi encontrado
if (-not $wsl_ip) {
    Write-Host "Erro: Não foi possível encontrar o endereço IP do WSL2. Verifique se o WSL está em execução." -ForegroundColor Red
    exit
}

Write-Host "IP do WSL2 encontrado: $wsl_ip" -ForegroundColor Green

# Remove qualquer regra de proxy antiga para esta porta, para evitar conflitos.
netsh interface portproxy delete v4tov4 listenport=$windows_port listenaddress=0.0.0.0

# Cria a nova regra de encaminhamento de porta
# O Windows (0.0.0.0) na porta $windows_port vai encaminhar para o IP do WSL na porta $wsl_port
netsh interface portproxy add v4tov4 listenport=$windows_port listenaddress=0.0.0.0 connectport=$wsl_port connectaddress=$wsl_ip

Write-Host "Sucesso! A porta $windows_port do Windows agora está encaminhando para a porta $wsl_port no IP $wsl_ip do WSL." -ForegroundColor Cyan
Write-Host "Pressione qualquer tecla para sair..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") | Out-Null