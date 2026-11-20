@echo off
chcp 65001 >nul
title Deploy - Rugido de Sião

echo ============================================
echo   DEPLOY - RUGIDO DE SIAO
echo ============================================
echo.

set /p MSG="Mensagem do commit: "
if "%MSG%"=="" set MSG=update

echo [1/3] Adicionando arquivos...
git add -A

echo [2/3] Commitando e enviando...
git commit -m "%MSG%"
git push origin main
if errorlevel 1 (
    echo ERRO: Falha ao enviar para o GitHub.
    pause
    exit /b 1
)

echo [3/3] Atualizando no servidor...
ssh root@136.0.53.2 "cd /opt/rugidodesiao && git pull && echo DEPLOY_OK"

if errorlevel 1 (
    echo ERRO: Falha no deploy da VPS.
    pause
    exit /b 1
)

echo.
echo ============================================
echo   DEPLOY CONCLUIDO!
echo   https://rugidodesiao.com.br
echo ============================================
pause
