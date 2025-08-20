# Resume & Cover Letter Maker

A Flutter application that helps users create, edit, and store resumes and cover letters locally. The app follows the MVVM (Model-View-ViewModel) architecture, uses Provider for state management, and leverages Hive for lightweight local storage.

It also integrates the Gemini API to provide AI-powered assistance in tailoring resumes and cover letters to specific job descriptions.

---

## Features

- Create and edit professional resumes
- Build tailored cover letters
- AI assistance with Gemini API
  - Improve resume structure and wording
  - Generate job-specific cover letters
  - Optimize content for ATS (Applicant Tracking Systems)
- Local storage with Hive (offline access, no internet required)
- Preview resumes and cover letters before exporting
- Export to PDF format
- Multiple templates and styles for customization
- Built with MVVM architecture for clean separation of concerns
- Provider state management for reactive UI updates

---

## Tech Stack

- Flutter (cross-platform mobile framework)
- Hive (local NoSQL database for offline storage)
- Provider (state management)
- MVVM Architecture (structured and scalable codebase)
- Gemini API (AI-powered resume & cover letter generation)

---


## Demo

Watch the video demo:

https://github.com/user-attachments/assets/07523cf8-5d17-4510-8c0b-fffc223dd3dd


---

## Project Structure

    lib/
    │── models/        # Data models (Resume, Cover Letter)
    │── viewmodels/    # Business logic & state handling
    │── views/         # UI screens (resume, cover letter, templates)
    │── utility/       # widgets, themes, adapters(for hive),
    │── main.dart      # App entry point

---

## Installation

1) Clone the repository

    git clone 
    cd resume-cover-letter-maker

2) Install dependencies

    flutter pub get

3) Add your Gemini API key in environment/config (example)

    // e.g., lib/services/ai_config.dart
    const String geminiApiKey = "YOUR_API_KEY_HERE";

4) Run the app

    flutter run

---
