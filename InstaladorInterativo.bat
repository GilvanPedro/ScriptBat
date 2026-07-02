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

:menu
title Instalador Interativo - Winget
cls
echo ==========================================
echo       SELECIONE O APP PARA INSTALAR
echo ==========================================
echo.
echo [1] Google Chrome
echo [2] Mozilla Firefox
echo [3] VS Code
echo [4] VLC Media Player
echo [5] 7-Zip
echo [6] Sair
echo.
echo ==========================================
set /p opcao="Digite o numero correspondente: "

if "%opcao%"=="1" (set "app=Google.Chrome")
if "%opcao%"=="2" (set "app=Mozilla.Firefox.pt-BR")
if "%opcao%"=="3" (set "app=Microsoft.VisualStudioCode")
if "%opcao%"=="4" (set "app=VideoLAN.VLC")
if "%opcao%"=="5" (set "app=7zip.7zip")
if "%opcao%"=="6" (exit /b)

if not defined app (
    echo.
    echo [ERRO] Opcao invalida! Tente novamente.
    timeout /t 2 >nul
    goto menu
)

cls
echo ==========================================
echo [PROCESSO] Instalando %app%...
echo ==========================================
winget install --id "%app%" -e --silent --accept-source-agreements --accept-package-agreements

if %errorLevel% equ 0 (
    echo.
    echo [OK] %app% instalado com sucesso!
) else (
    echo.
    echo [ERRO] Falha ao instalar %app% (Codigo: %errorLevel%)
)

set "app="
echo.
echo Voltando ao menu em 3 segundos...
timeout /t 3 >nul
goto menu
