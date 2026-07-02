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

title Backup de Layout - Winget
cls
echo ==========================================
echo         EXPORTANDO LISTA DE APLICATIVOS
echo ==========================================
echo.

set "OUTPUT_FILE=%USERPROFILE%\Desktop\MeusAplicativos.json"

echo [PROCESSO] Criando backup dos programas instalados...
winget export -o "%OUTPUT_FILE%" --include-versions

if %errorLevel% equ 0 (
    echo.
    echo [OK] Backup concluido com sucesso!
    echo [INFO] O arquivo foi salvo na sua Area de Trabalho como:
    echo        "MeusAplicativos.json"
) else (
    echo.
    echo [ERRO] Houve uma falha ao exportar a lista (Codigo: %errorLevel%)
)

echo ------------------------------------------
pause
