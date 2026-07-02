@echo off
chcp 65001 >nul

title Gerador de Relatório de Hardware
cls
echo ==========================================
echo         COLETANDO INFORMAÇÕES DO PC
echo ==========================================
echo.

set "INFO_FILE=%USERPROFILE%\Desktop\Especificacoes_PC.txt"

echo [PROCESSO] Identificando componentes do sistema...
echo ========================================== > "%INFO_FILE%"
echo         RELATÓRIO TÉCNICO DO SISTEMA      >> "%INFO_FILE%"
echo ========================================== >> "%INFO_FILE%"
echo. >> "%INFO_FILE%"

echo [PLACA-MÃE] >> "%INFO_FILE%"
wmic baseboard get product,Manufacturer,version >> "%INFO_FILE%" 2>&1

echo [PROCESSADOR] >> "%INFO_FILE%"
wmic cpu get name, MaxClockSpeed, NumberOfCores >> "%INFO_FILE%" 2>&1

echo [MEMÓRIA RAM] >> "%INFO_FILE%"
wmic memorychip get capacity, speed, DeviceLocator >> "%INFO_FILE%" 2>&1

echo [SISTEMA OPERACIONAL] >> "%INFO_FILE%"
wmic os get Caption, OSArchitecture, Version >> "%INFO_FILE%" 2>&1

echo.
if %errorLevel% equ 0 (
    echo [OK] Relatório gerado com sucesso!
    echo [INFO] O arquivo foi salvo na sua Área de Trabalho como:
    echo        "Especificacoes_PC.txt"
) else (
    echo [ERRO] Falha ao coletar dados do sistema.
)

echo ------------------------------------------
pause
