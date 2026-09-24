@echo off

title Gerador de Relatorio de Hardware
cls
echo ==========================================
echo         COLETANDO INFORMACOES DO PC
echo ==========================================
echo.

:: Descobre a Area de Trabalho real (funciona mesmo com OneDrive redirecionando a pasta)
for /f "usebackq delims=" %%d in (`powershell -NoProfile -Command "[Environment]::GetFolderPath('Desktop')"`) do set "DESKTOP=%%d"
if not defined DESKTOP set "DESKTOP=%USERPROFILE%\Desktop"

set "INFO_FILE=%DESKTOP%\Especificacoes_PC.txt"
set "FALHOU=0"

echo [PROCESSO] Identificando componentes do sistema...
echo ========================================== > "%INFO_FILE%"
echo         RELATORIO TECNICO DO SISTEMA      >> "%INFO_FILE%"
echo ========================================== >> "%INFO_FILE%"
echo. >> "%INFO_FILE%"

:: Cada comando marca FALHOU=1 se der erro (antes so o ultimo era verificado)
echo [PLACA-MAE] >> "%INFO_FILE%"
powershell -NoProfile -Command "Get-CimInstance Win32_BaseBoard | Format-List Product, Manufacturer, Version" >> "%INFO_FILE%" 2>&1 || set "FALHOU=1"

echo [PROCESSADOR] >> "%INFO_FILE%"
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Format-List Name, MaxClockSpeed, NumberOfCores" >> "%INFO_FILE%" 2>&1 || set "FALHOU=1"

echo [MEMORIA RAM] >> "%INFO_FILE%"
powershell -NoProfile -Command "Get-CimInstance Win32_PhysicalMemory | Format-List @{n='Capacidade (GB)';e={$_.Capacity/1GB}}, Speed, DeviceLocator" >> "%INFO_FILE%" 2>&1 || set "FALHOU=1"

echo [SISTEMA OPERACIONAL] >> "%INFO_FILE%"
powershell -NoProfile -Command "Get-CimInstance Win32_OperatingSystem | Format-List Caption, OSArchitecture, Version" >> "%INFO_FILE%" 2>&1 || set "FALHOU=1"

echo.
if "%FALHOU%"=="0" (
    echo [OK] Relatorio gerado com sucesso!
    echo [INFO] O arquivo foi salvo em:
    echo        "%INFO_FILE%"
) else (
    echo [ERRO] Falha ao coletar parte dos dados. Confira o arquivo:
    echo        "%INFO_FILE%"
)

echo ------------------------------------------
pause
