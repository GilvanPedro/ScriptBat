@echo off
chcp 65001 >nul

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando privilegios de Administrador...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

setlocal enabledelayedexpansion

title Gerenciador de Instalacoes - Winget
cls
echo ==========================================
echo            INICIANDO DESINSTALACOES
echo ==========================================
echo.

set "apps=Zoom.Zoom Mozilla.Firefox VideoLAN.VLC Google.Chrome Adobe.Acrobat.Reader.64-bit 7zip.7zip Microsoft.Edge CodecGuide.K-LiteCodecPack.Standard"

for %%a in (%apps%) do (
    echo [PROCESSO] Tentando remover: %%a
    winget uninstall --id "%%a" -e --silent --force --accept-source-agreements
    if !errorLevel! equ 0 (
        echo [OK] Sucesso ao remover: %%a
    ) else (
        echo [ERRO] Falha ao remover %%a ^(Codigo: !errorLevel!^)
    )
    echo ------------------------------------------
)

endlocal
pause