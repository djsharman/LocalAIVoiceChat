@echo off
setlocal

REM Set the URL and output directory
set "URL=https://huggingface.co/TheBloke/zephyr-7B-beta-GGUF/resolve/main/zephyr-7b-beta.Q5_K_M.gguf"
set "OUTDIR=models"
set "OUTFILE=zephyr-7b-beta.Q5_K_M.gguf"

REM Create output directory if it doesn't exist
if not exist "%OUTDIR%" (
    mkdir "%OUTDIR%"
)

REM Download the file using curl
if exist "%OUTDIR%\%OUTFILE%" (
    echo Model file already exists, skipping download.
) else (
    echo Downloading model file...
    curl -L -o "%OUTDIR%\%OUTFILE%" "%URL%"
)

endlocal
