@echo off
setlocal

set "ROOT=%~dp0.."
pushd "%ROOT%"

if not exist ".venv\Scripts\python.exe" (
  where py >nul 2>nul || (
    echo Python launcher 'py' was not found. Install Python 3 first.
    exit /b 1
  )
  py -3 -m venv .venv || exit /b 1
  ".venv\Scripts\python.exe" -m pip install --upgrade pip || exit /b 1
  ".venv\Scripts\python.exe" -m pip install -r ".\scripts\requirements.txt" || exit /b 1
)

".venv\Scripts\python.exe" ".\scripts\windows_server.py"
