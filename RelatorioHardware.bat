@echo off

title Gerador de Relatorio de Hardware
cls
echo ==========================================
echo         COLETANDO INFORMACOES DO PC
echo ==========================================
echo.

set "INFO_FILE=%USERPROFILE%\Desktop\Especificacoes_PC.txt"

echo [PROCESSO] Identificando componentes do sistema...
echo ========================================== > "%INFO_FILE%"
echo         RELATORIO TECNICO DO SISTEMA      >> "%INFO_FILE%"
echo ========================================== >> "%INFO_FILE%"
echo. >> "%INFO_FILE%"

echo [PLACA-MAE] >> "%INFO_FILE%"
powershell -NoProfile -Command "Get-CimInstance Win32_BaseBoard | Format-List Product, Manufacturer, Version" >> "%INFO_FILE%" 2>&1

echo [PROCESSADOR] >> "%INFO_FILE%"
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Format-List Name, MaxClockSpeed, NumberOfCores" >> "%INFO_FILE%" 2>&1

echo [MEMORIA RAM] >> "%INFO_FILE%"
powershell -NoProfile -Command "Get-CimInstance Win32_PhysicalMemory | Format-List Capacity, Speed, DeviceLocator" >> "%INFO_FILE%" 2>&1

echo [SISTEMA OPERACIONAL] >> "%INFO_FILE%"
powershell -NoProfile -Command "Get-CimInstance Win32_OperatingSystem | Format-List Caption, OSArchitecture, Version" >> "%INFO_FILE%" 2>&1

echo.
if %errorLevel% equ 0 (
    echo [OK] Relatorio gerado com sucesso!
    echo [INFO] O arquivo foi salvo na sua Area de Trabalho como:
    echo        "Especificacoes_PC.txt"
) else (
    echo [ERRO] Falha ao coletar dados do sistema.
)

echo ------------------------------------------
pause
