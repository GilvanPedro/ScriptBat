@echo off
setlocal

title Organizar Pasta de Downloads
cls
echo ==========================================
echo       ORGANIZANDO PASTA DE DOWNLOADS
echo ==========================================
echo.

set "TARGET_DIR=D:\Download"

:: Se a pasta configurada nao existir, usa a pasta Downloads padrao do usuario
if not exist "%TARGET_DIR%\" (
    echo [AVISO] Pasta "%TARGET_DIR%" nao encontrada. Usando a pasta Downloads padrao.
    set "TARGET_DIR=%USERPROFILE%\Downloads"
)

:: Se nao conseguir entrar na pasta, PARA aqui (antes ele organizava a pasta errada)
cd /d "%TARGET_DIR%" 2>nul || (
    echo [ERRO] Nao foi possivel acessar "%TARGET_DIR%".
    pause
    exit /b 1
)

echo [PROCESSO] Classificando e movendo arquivos de "%CD%"...
set /a MOVIDOS=0

:: Processa arquivo por arquivo para nunca sobrescrever um que ja existe no destino
for %%f in (*) do call :classificar "%%f"

echo.
echo [OK] Pasta de Downloads organizada! %MOVIDOS% arquivo(s) movido(s).
echo ------------------------------------------
pause
exit /b 0


:: =======================================
:: SUB-ROTINA: decide a pasta pela extensao
:: =======================================
:classificar
set "EXT=%~x1"
set "DEST="

for %%e in (.jpg .jpeg .png .gif .bmp .svg .ico .webp) do if /i "%EXT%"=="%%e" set "DEST=Imagens"
for %%e in (.pdf .doc .docx .xls .xlsx .ppt .pptx .txt .csv) do if /i "%EXT%"=="%%e" set "DEST=Documentos"
for %%e in (.mp4 .mkv .avi .mov .mp3 .wav .flac) do if /i "%EXT%"=="%%e" set "DEST=Videos"
for %%e in (.zip .rar .7z .tar .gz) do if /i "%EXT%"=="%%e" set "DEST=Compactados"
:: .bat fica de fora de proposito, pra nao mexer nos seus scripts
for %%e in (.exe .msi .msu) do if /i "%EXT%"=="%%e" set "DEST=Instaladores"

if not defined DEST exit /b

if not exist "%DEST%\" mkdir "%DEST%"

:: Se ja existir um arquivo com o mesmo nome, vira "nome (1).ext", "nome (2).ext"...
set "NOME=%~n1"
set "ALVO=%DEST%\%~nx1"
set /a N=1

:proximo_nome
if not exist "%ALVO%" goto mover
set "ALVO=%DEST%\%NOME% (%N%)%EXT%"
set /a N+=1
goto proximo_nome

:mover
move "%~1" "%ALVO%" >nul 2>&1 && set /a MOVIDOS+=1
exit /b
