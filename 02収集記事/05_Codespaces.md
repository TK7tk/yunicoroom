# GitHub Codespaces

## What is it?
Instant, cloud-based development environment. VS Code in the browser (or connected to local VS Code).

## Key Benefits
- **No "Works on my machine"**: Environment defined in code (`devcontainer.json`).
- **Instant Onboarding**: New hire clicks "Code -> Open in Codespaces" and is ready in minutes. No install scripts.
- **Power**: Use an iPad or restricted laptop to code on a 32-core cloud VM.
- **Security**: Code stays in the cloud, not on the laptop (good for contractors).

## Use Cases
1.  **PR Review**: Spin up the PR branch, run the app, verify the fix, destroy.
2.  **Teaching/Workshops**: Identical env for all students.
3.  **Complex Setup**: Projects needing specific Docker sidecars (DB, Redis, Kafka) pre-orchestrated.

## Configuration
- `.devcontainer/devcontainer.json`: Defines image, extensions, ports, settings.
- **Dotfiles**: Personal customization (aliases, themes) applied on top.
