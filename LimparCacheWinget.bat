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

title Otimizacao e Limpeza - Winget
cls
echo ==========================================
echo         LIMPEZA DE CACHE DO WINGET
echo ==========================================
echo.

echo [PROCESSO] Removendo instaladores antigos e arquivos temporarios...
if exist "%TEMP%\WinGet" (
    del /q /f /s "%TEMP%\WinGet\*" >nul 2>&1
)
del /q /f "%LOCALAPPDATA%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\DiagOutputDir\*.log" >nul 2>&1

echo.
echo [PROCESSO] Redefinindo e atualizando as fontes de pacotes...
winget source reset --force

if %errorLevel% equ 0 (
    echo.
    echo [OK] Limpeza e otimizacao concluidas com sucesso!
    echo Espaco em disco recuperado.
) else (
    echo.
    echo [ERRO] Houve um problema ao tentar limpar o cache (Codigo: %errorLevel%)
)

echo ------------------------------------------
pause
