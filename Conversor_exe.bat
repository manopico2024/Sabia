@echo off

set "destino=Executaveis"

:MENU
cls
title CONVERSOR PYINSTALLER - PYQT5
color 0A
echo ===============================================
echo      GERADOR DE EXECUTAVEL COM PYINSTALLER
echo ===============================================
echo.
echo [1] Gerar Executavel
echo [2] Limpeza
echo [3] Sair
echo.
set /p op=Escolha uma opcao [1-3]: 

if "%op%"=="1" goto SUBMENU_GERAR
if "%op%"=="2" goto SUBMENU_LIMPAR
if "%op%"=="3" exit
goto MENU

:: ---------- SUBMENU GERAR ----------
:SUBMENU_GERAR
cls
echo ===============================================
echo          GERAR EXECUTAVEL - MODO
echo ===============================================
echo.
echo [1] Console (mostra terminal)
echo [2] Janela (sem console)
echo [3] Voltar ao menu principal
echo.
set /p tipo=Escolha uma opcao [1-3]: 

if "%tipo%"=="1" (
    set "console_flag="
    goto GERAR_EXECUTAVEL
)
if "%tipo%"=="2" (
    set "console_flag=--noconsole"
    goto GERAR_EXECUTAVEL
)
if "%tipo%"=="3" goto MENU
goto SUBMENU_GERAR

:GERAR_EXECUTAVEL
cls
echo ===============================================
echo         DADOS PARA GERAR EXECUTAVEL
echo ===============================================
echo.

set /p arquivo=Digite o nome do arquivo Python (ex: app.py): 
set /p nome=Nome do executavel (sem extensao): 
set /p icone=Digite o caminho do icone (.ico) ou deixe em branco: 

:: Cria a pasta de destino se não existir
if not exist "%destino%" (
    mkdir "%destino%"
)

echo.
echo Gerando executavel, aguarde...

if "%icone%"=="" (
    pyinstaller --onefile %console_flag% "%arquivo%" --name "%nome%" --distpath "%destino%"
) else (
    pyinstaller --onefile %console_flag% --icon="%icone%" "%arquivo%" --name "%nome%" --distpath "%destino%"
)

echo.
echo ===============================================
echo   Executável gerado em: %destino%\%nome%.exe
echo ===============================================
pause
goto MENU

:: ---------- SUBMENU LIMPAR ----------
:SUBMENU_LIMPAR
cls
echo ===============================================
echo               LIMPEZA DE ARQUIVOS
echo ===============================================
echo.
echo [1] Limpar build, .spec e pasta %destino%
echo [2] Voltar ao menu principal
echo.
set /p limpar=Escolha uma opcao [1-2]: 

if "%limpar%"=="1" goto LIMPAR
if "%limpar%"=="2" goto MENU
goto SUBMENU_LIMPAR

:LIMPAR
cls
echo Limpando arquivos gerados...
del /f /q *.spec >nul 2>&1
rd /s /q build >nul 2>&1
rd /s /q %destino% >nul 2>&1
echo Limpeza concluída.
pause
goto MENU
