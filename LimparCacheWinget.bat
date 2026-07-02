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

title Otimização e Limpeza - Winget
cls
echo ==========================================
echo         LIMPEZA DE CACHE DO WINGET
echo ==========================================
echo.

echo [PROCESSO] Removendo instaladores antigos e arquivos temporários...
winget Repair

echo.
echo [PROCESSO] Redefinindo e atualizando as fontes de pacotes...
winget source reset --force

if %errorLevel% equ 0 (
    echo.
    echo [OK] Limpeza e otimização concluídas com sucesso!
    echo Espaço em disco recuperado.
) else (
    echo.
    echo [ERRO] Houve um problema ao tentar limpar o cache (Código: %errorLevel%)
)

echo ------------------------------------------
pause
