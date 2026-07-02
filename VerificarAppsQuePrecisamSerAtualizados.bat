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

title Auditoria de Software - Winget
cls
echo ==========================================
echo       GERANDO RELATÓRIO DE ATUALIZAÇÕES
echo ==========================================
echo.

set "REPORT_FILE=%USERPROFILE%\Desktop\Relatorio_Apps_Desatualizados.txt"

echo [PROCESSO] Analisando o sistema por softwares desatualizados...
echo Gerando relatório, por favor aguarde...

:: Cria o cabeçalho do arquivo de texto
echo =================================================== > "%REPORT_FILE%"
echo   RELATÓRIO DE APLICATIVOS DESATUALIZADOS (WINGET) >> "%REPORT_FILE%"
echo   Gerado em: %date% às %time% >> "%REPORT_FILE%"
echo =================================================== >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

:: Exporta apenas a lista do que precisa de upgrade para o arquivo
winget upgrade >> "%REPORT_FILE%"

if %errorLevel% equ 0 (
    echo.
    echo [OK] Relatório gerado com sucesso!
    echo [INFO] O arquivo foi salvo na sua Área de Trabalho como:
    echo        "Relatorio_Apps_Desatualizados.txt"
) else (
    echo.
    echo [AVISO] O processo terminou (Código: %errorLevel%). 
    echo Verifique o arquivo na sua Área de Trabalho.
)

echo ------------------------------------------
pause
