---
description: Research GitHub features and generate a comprehensive report and website.
---

# GitHub Research & Report Workflow

## Steps

1.  **Web Research**
    - Search for "GitHub features", "GitHub guide", "GitHub advanced tips".
    - Target at least 5 reliable sources (Official docs, Engineering blogs, Expert articles).
    - Focus on: Use cases, Advantages vs competitors, Usage Tips.

2.  **Information Extraction**
    - Read each source.
    - Extract key insights into markdown files in the `02` directory.
    - Filename format: `02/Source_X_Title.md`.

3.  **Report Synthesis**
    - Combine all extracted info into `03/YYYY-MM-DD_GitHub_Report.md`.
    - Follow `agent/rules/expert_writing.md`.
    - Length: 30,000+ characters.

4.  **HTML & Media Generation**
    - Convert the report to HTML: `04/YYYY-MM-DD.index.html`.
    - Style: Japanese News Site (NanoBananaPro).
    - Images: Generate "NanoBananaPro" style images for headers/sections using `generate_image`.
    - Content: Rich media, responsive design.
