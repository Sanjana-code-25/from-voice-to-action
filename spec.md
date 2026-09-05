# Project Specification: Voice Notes ➔ Action Items

## 1. Project Overview
The **Voice Notes ➔ Action Items** application turns a rambling audio voice memo into a clean summary with clearly extracted action items. It simplifies long audio recordings into structured, actionable text outputs for enhanced productivity.

---

## 2. Core Features
1. **Audio Input Handling:**
   - **Record Audio:** In-browser microphone audio recording capability.
   - **Upload Audio:** File uploader supporting `.mp3`, `.wav`, and `.m4a` audio formats.
2. **Speech-to-Text (STT) Transcription:**
   - Transcribe audio clips into clean text using Whisper API or `faster-whisper`.
3. **LLM Summarization & Extraction:**
   - Process transcripts using OpenAI API (`gpt-4o-mini` or `gpt-3.5-turbo`).
   - Generate a short, structured summary.
   - Extract actionable key points / tasks list from the voice note.
4. **User Interface (UI):**
   - Clean, readable Streamlit or FastAPI/React web layout.
   - Separate display boxes for **Raw Transcript**, **Executive Summary**, and **Action Items**.

---

## 3. Tech Stack
- **Frontend / UI:** Streamlit (or HTML/Tailwind CSS with FastAPI)
- **Speech-to-Text:** OpenAI Whisper API / `faster-whisper`
- **LLM:** OpenAI API (`gpt-4o-mini`)
- **Backend Environment:** Python 3.10+
- **PDF Generation:** `reportlab` or `fpdf2`

---

## 4. Stretch Goals (Advanced Features)
- **Batch Processing:** Ability to upload multiple audio recordings simultaneously.
- **Export Capabilities:** Download the processed summary and action items as a PDF or shareable note file (`.txt` / `.pdf`).

---

## 5. System Architecture Flow
```text
[Audio Input: Record / Upload] 
         │
         ▼
[STT Engine: Whisper API] ──► (Generates Raw Text)
         │
         ▼
[LLM Engine: OpenAI GPT] ──► (Generates Summary + Action Items)
         │
         ▼
[Simple Readable UI] ──► [Export PDF / Batch Process]