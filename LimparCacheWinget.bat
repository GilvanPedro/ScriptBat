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
:: rd apaga a pasta inteira (del /s so apagava os arquivos e deixava as subpastas)
if exist "%TEMP%\WinGet" rd /s /q "%TEMP%\WinGet" >nul 2>&1
del /q /f "%LOCALAPPDATA%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\DiagOutputDir\*.log" >nul 2>&1

echo.
echo [PROCESSO] Redefinindo e atualizando as fontes de pacotes...
winget source reset --force
set "CODIGO=%errorLevel%"

if "%CODIGO%"=="0" (
    echo.
    echo [OK] Limpeza e otimizacao concluidas com sucesso!
    echo Espaco em disco recuperado.
) else (
    echo.
    echo [ERRO] Houve um problema ao tentar limpar o cache ^(Codigo: %CODIGO%^)
)

echo ------------------------------------------
pause
