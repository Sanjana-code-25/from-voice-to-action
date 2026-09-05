# From Voice to Action

A Streamlit app that turns a voice memo into a clean transcript, executive summary, and actionable task list. This implementation follows `spec.md` as the source of truth.

## What is included

- In-browser microphone recording.
- Batch upload for `.mp3`, `.wav`, and `.m4a` files.
- Demo/Test mode for running the complete interface without payment.
- Free local Whisper transcription and Ollama summaries when installed.
- Google Gemini cloud processing when `GEMINI_API_KEY` is configured privately.
- Separate raw transcript, executive summary, and action item sections.
- Searchable note history with delete support.
- Teacher/student sign-in and teacher messages.
- Downloadable `.txt`, PDF, Word, email, and calendar exports.

## Approach

1. Streamlit provides the browser interface for recording and uploading audio.
2. The selected processing mode determines how the note is handled:
	- **Demo / Test** returns safe sample results for demonstrations.
	- **Free local** uses Faster-Whisper for transcription and Ollama for summaries on the current computer.
	- **Google Gemini cloud** sends audio to Gemini using a private server-side API key.
3. The result is organized into a transcript, summary, action items, owners, and due dates.
4. Written notes and teacher messages are saved locally in JSON files for the current installation.

## Prerequisites

- Python 3.10 or newer.
- For Demo/Test mode: no API key or payment.
- For Free local mode: Ollama with the `llama3.2` model.
- For Google Gemini cloud mode: a Gemini API key with available quota.
- A modern browser with microphone permission if you want to record in the browser.

## Run locally on Windows

Open PowerShell in this folder and run:

```powershell
py -3 -m venv .venv
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
```

The app can run without an API key in Demo/Test mode. For Free local mode, install Ollama and download the model:

```powershell
ollama pull llama3.2
```

Start the app:

```powershell
streamlit run app.py
```

Streamlit will print a local URL, normally `http://localhost:8501`. Open it in your browser.

### Teacher one-command setup on Windows

After cloning the repository, open PowerShell in the project folder and run:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\setup_teacher_windows.ps1
.\.venv\Scripts\python.exe -m streamlit run app.py
```

The script installs the Python packages and downloads the free `llama3.2` Ollama model. In the app, choose **Free local** for real speech-to-text. Choose **Demo / Test** only when Ollama is not installed.

## Run locally on macOS or Linux

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
cp .env.example .env
# Set GEMINI_API_KEY only if using Google Gemini cloud mode.
streamlit run app.py
```

## Using the app

1. Sign in as a teacher.
2. Choose **Demo / Test** to test without payment, **Free local** for real transcription on that computer, or **Google Gemini cloud** when a Gemini key is configured.
3. Record a note with the microphone control or upload one or more supported audio files.
4. Select **Transcribe and extract actions**.
5. Review the transcript, summary, and action items.
6. Download a text note, PDF, Word document, email draft, or calendar file from the export section.

## Quick start for teacher review

After downloading or cloning this repository on Windows, open PowerShell in the project folder and run:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\setup_teacher_windows.ps1
.\.venv\Scripts\python.exe -m streamlit run app.py
```

Open the local URL printed by Streamlit, usually `http://localhost:8501`.

Use the teacher account:

```text
Username: teacher1
Password: teacher123
```

Choose **Demo / Test** to review the complete interface without an API key, payment, or Ollama. Choose **Free local** only after installing Ollama and running `ollama pull llama3.2`.

The `.env` file is not required for Demo / Test or Free local mode. It is only needed for Google Gemini cloud mode.

## Global deployment

1. Push the repository to GitHub without uploading `.env`, `.venv`, `notes_history.json`, or `teacher_messages.json`.
2. Deploy `app.py` with Streamlit Community Cloud.
3. Add this secret under the app settings:

```toml
GEMINI_API_KEY = "your_gemini_api_key_here"
```

4. Open the Streamlit URL from any device and select **Google Gemini cloud**.

## Assumptions

- Users have a modern browser and allow microphone access when recording.
- Audio files are `.mp3`, `.wav`, or `.m4a`.
- Demo/Test mode is acceptable when no AI service or local model is available.
- Free local mode has enough computer memory and disk space to download Whisper and Ollama models.
- Gemini cloud mode has an active API key and available quota.
- The starter teacher and student accounts are for demonstration only.

## Known limitations

- Demo/Test mode does not transcribe the user's real speech; it returns sample content.
- Free local mode requires Ollama, the `llama3.2` model, and a local installation of the project.
- Gemini cloud processing may have quotas, usage limits, or costs after free usage is exhausted.
- Local JSON storage is not a production database and is not shared automatically between devices.
- The starter login credentials are hardcoded for demonstration and are not suitable for a public production system.
- Search history, messages, and notes can be lost if the deployment platform does not provide persistent storage.
- Transcription quality depends on microphone quality, accent, language, background noise, and the selected model.
- The app does not yet provide secure password hashing, account registration, password reset, or administrator management.

## Processing notes

Free local mode keeps audio on the computer running the app. Ollama creates the summary locally. Demo/Test mode uses sample output and is intended for repository demonstrations. Gemini cloud mode sends audio to Google and requires a Gemini API key with available quota.

## Project files

- `app.py` - Streamlit UI, processing flow, Gemini/local integrations, and exports.
- `requirements.txt` - Python dependencies.
- `.env.example` - Environment variable template.
- `spec.md` - Original project specification.