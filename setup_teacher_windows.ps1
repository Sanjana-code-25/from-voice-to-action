$ErrorActionPreference = "Stop"

Write-Host "Setting up From Voice to Action..." -ForegroundColor Cyan

if (-not (Get-Command py -ErrorAction SilentlyContinue)) {
    throw "Python is not installed. Install Python 3.10 or newer from https://www.python.org/downloads/"
}

if (-not (Test-Path ".venv\Scripts\python.exe")) {
    py -3 -m venv .venv
}

.\.venv\Scripts\python.exe -m pip install --upgrade pip
.\.venv\Scripts\python.exe -m pip install -r requirements.txt

if (Get-Command ollama -ErrorAction SilentlyContinue) {
    ollama pull llama3.2
} else {
    Write-Host "Ollama is not installed. Demo / Test mode will still work." -ForegroundColor Yellow
    Write-Host "Install Ollama later if you want Free local mode: https://ollama.com/download" -ForegroundColor Yellow
}

Write-Host "Setup complete." -ForegroundColor Green
Write-Host "Start the app with: .\.venv\Scripts\python.exe -m streamlit run app.py" -ForegroundColor Yellow
