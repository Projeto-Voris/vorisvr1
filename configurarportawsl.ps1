# =================================================================
# Script para encaminhar portas do Host Windows para o Guest WSL2
# =================================================================

Write-Host "Iniciando configuração de port forwarding para WSL2..."

# --- Configuração das Portas ---
$unreal_port = 8080
$foxglove_port = 8765
# -----------------------------

# Pega o endereço IP da distro WSL.
$wsl_ip_string = wsl.exe -- ip addr show eth0 | findstr "inet "
$wsl_ip = ($wsl_ip_string -split ' ')[5] -replace '/.*'

# Verifica se o IP foi encontrado
if (-not $wsl_ip) {
    Write-Host "ERRO: Não foi possível encontrar o endereço IP do WSL2. Verifique se o WSL está em execução." -ForegroundColor Red
    exit
}

Write-Host "IP do WSL2 encontrado: $wsl_ip" -ForegroundColor Green

# --- Configuração para Unreal Engine ---
Write-Host "Configurando porta para Unreal Engine ($unreal_port)..."
# Remove qualquer regra de proxy antiga para esta porta.
netsh interface portproxy delete v4tov4 listenport=$unreal_port listenaddress=0.0.0.0
# Cria a nova regra de encaminhamento.
netsh interface portproxy add v4tov4 listenport=$unreal_port listenaddress=0.0.0.0 connectport=$unreal_port connectaddress=$wsl_ip

# --- Configuração para Foxglove ---
Write-Host "Configurando porta para Foxglove ($foxglove_port)..."
# Remove qualquer regra de proxy antiga para esta porta.
netsh interface portproxy delete v4tov4 listenport=$foxglove_port listenaddress=0.0.0.0
# Cria a nova regra de encaminhamento.
netsh interface portproxy add v4tov4 listenport=$foxglove_port listenaddress=0.0.0.0 connectport=$foxglove_port connectaddress=$wsl_ip

Write-Host "--------------------------------------------------------"
Write-Host "SUCESSO! As portas foram encaminhadas para o IP $wsl_ip" -ForegroundColor Cyan
Write-Host "Pressione qualquer tecla para sair..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") | Out-Null