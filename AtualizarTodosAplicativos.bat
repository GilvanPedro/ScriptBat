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

title Gerenciador de Atualizacoes - Winget
cls
echo ==========================================
echo            BUSCANDO ATUALIZACOES
echo ==========================================
echo.

echo [PROCESSO] Verificando se ha pacotes desatualizados...
:: --accept-source-agreements evita que o winget trave esperando um "Y" na primeira execucao
winget upgrade --accept-source-agreements

echo.
echo ==========================================
echo            INICIANDO ATUALIZACOES
echo ==========================================
echo [PROCESSO] Atualizando todos os aplicativos elegiveis...
echo.

:: O comando abaixo atualiza TODOS os apps do PC que possuem updates disponiveis
winget upgrade --all --silent --include-unknown --accept-source-agreements --accept-package-agreements
set "CODIGO=%errorLevel%"

if "%CODIGO%"=="0" (
    echo.
    echo [OK] Todos os aplicativos foram atualizados com sucesso!
) else (
    echo.
    echo [AVISO/ERRO] Algum aplicativo pode ter falhado ou nao havia atualizacoes ^(Codigo: %CODIGO%^)
)

echo ------------------------------------------
pause
