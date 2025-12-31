---
description: Create a new long-form article based on user input (vague or specific).
---

# Create New Article Workflow

This workflow transforms a user's vague idea into a detailed, 10,000-character emotionally engaging article in Japanese.

## Steps

1.  **Analyze User Input**
    - Understand the core theme or keywords from the user's input.
    - If the input is too vague, hypothesize potential interesting angles.

2.  **Conduct Deep Research**
    - Use `search_web` to gather extensive information.
    - Look for:
        - Definitions and basic facts.
        - Historical context and origins.
        - Current trends and news.
        - Future predictions.
        - Controversial opinions or debates (to add subjectivity).
        - Related concepts (for Zettelkasten links).

3.  **Plan the Article**
    - **Draft Title**: Create a catchy title.
    - **Filename**: `YYYY-MM-DD_Title.md`.
    - **Outline**: ensure enough sections to reach 10,000 characters.

4.  **Write the Article**
    - **Language**: Japanese.
    - **Tone**: Professional, Subjective, Emotional (!!, emojis).
    - **Length**: Target 10,000+ characters.
    - **Format**: Markdown with Obsidian WikiLinks `[[]]` and Tags `#`.
    - **Destination**: Write to `/01/filename.md`.

5.  **Review**
    - access the created file using `view_file` to ensure it was created correctly.

## Auto-Run
// turbo-all
