@echo off

:: =======================================
:: VERIFICACAO E ELEVACAO DE PRIVILEGIOS
:: =======================================
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando privilegios de Administrador...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Diagnostico e Otimizacao de Rede
cls
echo ==========================================
echo         FLUSH DNS E RENOVACAO DE IP
echo ==========================================
echo.

echo [PROCESSO] Limpando o cache de DNS do Windows...
ipconfig /flushdns
echo.

echo [PROCESSO] Liberando o endereco IP atual...
ipconfig /release >nul
echo.

echo [PROCESSO] Solicitando um novo IP ao roteador (DHCP)...
ipconfig /renew
echo.

echo ==========================================
echo         TESTE DE LATENCIA DA REDE
echo ==========================================
echo [INFO] Iniciando teste de ping no DNS da Cloudflare (1.1.1.1).
echo        Pressione CTRL+C na janela para interromper o teste.
echo.
ping 1.1.1.1 -t
