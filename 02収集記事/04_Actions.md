# GitHub Actions: Deep Dive

## What is it?
Integrated CI/CD directly in the repo. Automate "Build, Test, Deploy" and more (triage issues, labeling).

## Core Concepts
- **Workflow**: YAML file in `.github/workflows`.
- **Events**: Triggers (`push`, `pull_request`, `schedule`, `workflow_dispatch`).
- **Runners**: Standard (Ubuntu/Win/Mac) or Self-Hosted.
- **Marketplace**: Thousands of pre-built actions to reuse.

## Advanced Usage
- **Matrix Builds**: Run tests across 3 OSs and 4 Node versions (12 jobs) automatically.
- **Reusable Workflows**: Call one workflow from another (module usage).
- **Concurrency Groups**: Cancel outdated builds when new commits are pushed (save money/time).
- **Caching**: `actions/cache` to store npm/pip/maven dependencies between runs.
- **Secrets**: Encrypted variables for keys/tokens.
- **Conditions**: `if: github.ref == 'refs/heads/main'` to only deploy on main.

## Best Practices
1.  **Pin Versions**: Use `@v1.2.3` or SHA, not `@master` for 3rd party actions (security).
2.  **Least Privilege**: Restrict `GITHUB_TOKEN` permissions.
3.  **Linting**: Use `actionlint` to check YAML syntax.
