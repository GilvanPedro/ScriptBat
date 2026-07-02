@echo off
chcp 65001 >nul

:: =======================================
:: VERIFICAÇÃO E ELEVAÇÃO DE PRIVILÉGIOS
:: =======================================
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando privilégios de Administrador...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Gerenciador de Atualizações - Winget
cls
echo ==========================================
echo            BUSCANDO ATUALIZAÇÕES
echo ==========================================
echo.

echo [PROCESSO] Verificando se há pacotes desatualizados...
winget upgrade

echo.
echo ==========================================
echo            INICIANDO ATUALIZAÇÕES
echo ==========================================
echo [PROCESSO] Atualizando todos os aplicativos elegíveis...
echo.

:: O comando abaixo atualiza TODOS os apps do PC que possuem updates disponíveis
winget upgrade --all --silent --include-unknown --accept-source-agreements --accept-package-agreements

if %errorLevel% equ 0 (
    echo.
    echo [OK] Todos os aplicativos foram atualizados com sucesso!
) else (
    echo.
    echo [AVISO/ERRO] Algum aplicativo pode ter falhado ou não havia atualizações (Código: %errorLevel%)
)

echo ------------------------------------------
pause
