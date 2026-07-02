@echo off

title Organizar Pasta de Downloads
cls
echo ==========================================
echo       ORGANIZANDO PASTA DE DOWNLOADS
echo ==========================================
echo.

set "TARGET_DIR=D:\Download"
cd /d "%TARGET_DIR%"

echo [PROCESSO] Classificando e movendo arquivos...

:: Criar as pastas caso nao existam
if not exist "Imagens" mkdir "Imagens"
if not exist "Documentos" mkdir "Documentos"
if not exist "Videos" mkdir "Videos"
if not exist "Compactados" mkdir "Compactados"
if not exist "Instaladores" mkdir "Instaladores"

:: Mover Imagens
for %%e in (jpg jpeg png gif bmp svg ico) do (
    move *.%%e "Imagens" >nul 2>&1
)

:: Mover Documentos
for %%e in (pdf doc docx xls xlsx ppt pptx txt csv) do (
    move *.%%e "Documentos" >nul 2>&1
)

:: Mover Videos e Musicas
for %%e in (mp4 mkv avi mov mp3 wav flac) do (
    move *.%%e "Videos" >nul 2>&1
)

:: Mover Arquivos Compactados
for %%e in (zip rar 7z tar gz) do (
    move *.%%e "Compactados" >nul 2>&1
)

:: Mover Instaladores (sem mexer nos arquivos .bat que voce usa!)
for %%e in (exe msi msu) do (
    move *.%%e "Instaladores" >nul 2>&1
)

echo.
echo [OK] Pasta de Downloads organizada com sucesso!
echo ------------------------------------------
pause
