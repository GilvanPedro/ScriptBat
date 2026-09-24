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

title Backup de Layout - Winget
cls
echo ==========================================
echo         EXPORTANDO LISTA DE APLICATIVOS
echo ==========================================
echo.

:: Descobre a Area de Trabalho real (funciona mesmo com OneDrive redirecionando a pasta)
for /f "usebackq delims=" %%d in (`powershell -NoProfile -Command "[Environment]::GetFolderPath('Desktop')"`) do set "DESKTOP=%%d"
if not defined DESKTOP set "DESKTOP=%USERPROFILE%\Desktop"

set "OUTPUT_FILE=%DESKTOP%\MeusAplicativos.json"

echo [PROCESSO] Criando backup dos programas instalados...
winget export -o "%OUTPUT_FILE%" --include-versions --accept-source-agreements
set "CODIGO=%errorLevel%"

if "%CODIGO%"=="0" (
    echo.
    echo [OK] Backup concluido com sucesso!
    echo [INFO] O arquivo foi salvo em:
    echo        "%OUTPUT_FILE%"
) else (
    echo.
    echo [ERRO] Houve uma falha ao exportar a lista ^(Codigo: %CODIGO%^)
)

echo ------------------------------------------
pause
