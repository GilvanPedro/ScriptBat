@echo off
cls

:: =======================================
:: VERIFICACAO E ELEVACAO DE PRIVILEGIOS
:: =======================================
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando privilegios de Administrador...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Gerenciador de Instalacoes - Winget
cls
echo =======================================
echo           INICIANDO INSTALACOES
echo =======================================
echo.

:: =======================================
:: LISTA DE APLICATIVOS
:: =======================================
set "apps=Zoom.Zoom Mozilla.Firefox.pt-BR VideoLAN.VLC Google.Chrome Adobe.Acrobat.Reader.64-bit TheDocumentFoundation.LibreOffice 7zip.7zip Microsoft.Edge CodecGuide.K-LiteCodecPack.Standard"

:: =======================================
:: LOOP DE INSTALACAO
:: =======================================
for %%a in (%apps%) do (
    echo [PROCESSO] Tentando instalar: %%a
    
    winget install --id "%%a" -e --silent --force --accept-source-agreements --accept-package-agreements
    
    if %errorLevel% equ 0 (
        echo [OK] Sucesso ao instalar: %%a
    ) else (
        echo [ERRO] Falha ao instalar %%a (Codigo: %errorLevel%)
    )
    echo ---------------------------------------
)
pause
