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

:: Descobre a Area de Trabalho real (funciona mesmo com OneDrive redirecionando a pasta)
for /f "usebackq delims=" %%d in (`powershell -NoProfile -Command "[Environment]::GetFolderPath('Desktop')"`) do set "DESKTOP=%%d"
if not defined DESKTOP set "DESKTOP=%USERPROFILE%\Desktop"

set "REPORT_FILE=%DESKTOP%\Relatorio_Apps_Desatualizados.txt"

echo [PROCESSO] Analisando o sistema por softwares desatualizados...
echo Gerando relatorio, por favor aguarde...

:: Cria o cabecalho do arquivo de texto
echo =================================================== > "%REPORT_FILE%"
echo   RELATORIO DE APLICATIVOS DESATUALIZADOS (WINGET) >> "%REPORT_FILE%"
echo   Gerado em: %date% as %time% >> "%REPORT_FILE%"
echo =================================================== >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

:: Exporta apenas a lista do que precisa de upgrade para o arquivo.
:: Sem esses flags, o winget podia travar pedindo "Y" com a pergunta escondida dentro do .txt
winget upgrade --accept-source-agreements --disable-interactivity >> "%REPORT_FILE%"
set "CODIGO=%errorLevel%"

if "%CODIGO%"=="0" (
    echo.
    echo [OK] Relatorio gerado com sucesso!
    echo [INFO] O arquivo foi salvo em:
    echo        "%REPORT_FILE%"
) else (
    echo.
    echo [AVISO] O processo terminou ^(Codigo: %CODIGO%^).
    echo Verifique o arquivo em "%REPORT_FILE%".
)

echo ------------------------------------------
pause
