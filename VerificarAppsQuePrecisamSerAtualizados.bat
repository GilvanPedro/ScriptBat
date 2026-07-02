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

title Auditoria de Software - Winget
cls
echo ==========================================
echo       GERANDO RELATORIO DE ATUALIZACOES
echo ==========================================
echo.

set "REPORT_FILE=%USERPROFILE%\Desktop\Relatorio_Apps_Desatualizados.txt"

echo [PROCESSO] Analisando o sistema por softwares desatualizados...
echo Gerando relatorio, por favor aguarde...

:: Cria o cabecalho do arquivo de texto
echo =================================================== > "%REPORT_FILE%"
echo   RELATORIO DE APLICATIVOS DESATUALIZADOS (WINGET) >> "%REPORT_FILE%"
echo   Gerado em: %date% as %time% >> "%REPORT_FILE%"
echo =================================================== >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

:: Exporta apenas a lista do que precisa de upgrade para o arquivo
winget upgrade >> "%REPORT_FILE%"

if %errorLevel% equ 0 (
    echo.
    echo [OK] Relatorio gerado com sucesso!
    echo [INFO] O arquivo foi salvo na sua Area de Trabalho como:
    echo        "Relatorio_Apps_Desatualizados.txt"
) else (
    echo.
    echo [AVISO] O processo terminou (Codigo: %errorLevel%). 
    echo Verifique o arquivo na sua Area de Trabalho.
)

echo ------------------------------------------
pause
