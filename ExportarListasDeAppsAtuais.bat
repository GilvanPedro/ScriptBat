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
    echo [OK] Backup concluído com sucesso!
    echo [INFO] O arquivo foi salvo na sua Área de Trabalho como:
    echo        "MeusAplicativos.json"
) else (
    echo.
    echo [ERRO] Houve uma falha ao exportar a lista (Código: %errorLevel%)
)

echo ------------------------------------------
pause
