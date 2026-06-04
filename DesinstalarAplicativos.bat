@echo off
:: Corrigir acentos (UTF-8)
chcp 65001 >nul

:: ==========================================
::     VERIFICAÇÃO E ELEVAÇÃO DE PRIVILÉGIOS
:: ==========================================
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando privilégios de Administrador...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Gerenciador de Instalações - Winget
cls
echo ==========================================
echo           INICIANDO DESINSTALAÇÕES
echo ==========================================
echo.

:: ==========================================
::              LISTA DE APLICATIVOS
:: ==========================================
set "apps=Zoom.Zoom Mozilla.Firefox VideoLAN.VLC Google.Chrome Adobe.Acrobat.Reader.64-bit TheDocumentFoundation.LibreOffice 7zip.7zip Microsoft.Edge CodecGuide.K-LiteCodecPack.Standard"

:: ==========================================
::               LOOP DE DESINSTALAÇÃO
:: ==========================================
for %%a in (%apps%) do (
    echo [PROCESSO] Tentando remover: %%a
    
    :: Mudança aqui: Adicionado --force e --accept-source-agreements.
    :: Removemos o >nul para você ver o real motivo se der erro.
    winget uninstall --id "%%a" -e --silent --force --accept-source-agreements
    
    if %errorLevel% equ 0 (
        echo [OK] Sucesso ao remover: %%a
    ) else (
        echo [ERRO] Falha ao remover %%a (Código: %errorLevel%)
    )
    echo ------------------------------------------
)
pause
