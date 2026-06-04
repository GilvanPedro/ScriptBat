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
echo             INICIANDO INSTALAÇÕES
echo ==========================================
echo.

:: ==========================================
::              LISTA DE APLICATIVOS
:: ==========================================
set "apps=Zoom.Zoom Mozilla.Firefox.pt-BR VideoLAN.VLC Google.Chrome Adobe.Acrobat.Reader.64-bit TheDocumentFoundation.LibreOffice 7zip.7zip Microsoft.Edge CodecGuide.K-LiteCodecPack.Standard"

:: ==========================================
::               LOOP DE INSTALAÇÃO
:: ==========================================
for %%a in (%apps%) do (
    echo [PROCESSO] Tentando instalar: %%a
    
    :: Comando alterado para 'winget install' com parâmetros de automação e aceitação de termos
    winget install --id "%%a" -e --silent --force --accept-source-agreements --accept-package-agreements
    
    if %errorLevel% equ 0 (
        echo [OK] Sucesso ao instalar: %%a
    ) else (
        echo [ERRO] Falha ao instalar %%a (Código: %errorLevel%)
    )
    echo ------------------------------------------
)
pause
