# Contributing to Store Rails

Thank you for your interest in contributing to **Store Rails**! We welcome contributions of all kinds, including bug reports, feature requests, documentation improvements, and code submissions.

By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md).

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Contributing Code](#contributing-code)
- [Local Development Setup](#local-development-setup)
- [Development Guidelines](#development-guidelines)
  - [Branch Naming](#branch-naming)
  - [Commit Conventions](#commit-conventions)
  - [Coding Standards & Style](#coding-standards--style)
  - [Testing Standards](#testing-standards)
  - [Security Best Practices](#security-best-practices)
- [Pre-Submission Checklist](#pre-submission-checklist)
- [Pull Request Process](#pull-request-process)
- [Questions and Support](#questions-and-support)

---

## Code of Conduct

This project adheres to the [Contributor Covenant](CODE_OF_CONDUCT.md). Please treat all community members with empathy, kindness, and respect. Unacceptable behavior can be reported to [dark1234tan@gmail.com](mailto:dark1234tan@gmail.com).

---

## How to Contribute

### Reporting Bugs

Before creating a bug report, check existing [GitHub Issues](https://github.com/faDark13/store_rails/issues) to ensure the issue hasn't already been reported.

When filing a new bug report, please include:
- **A clear, descriptive title**.
- **Steps to reproduce**: Step-by-step instructions to recreate the bug.
- **Expected vs. Actual behavior**: What you expected to happen versus what actually happened.
- **Environment details**:
  - Ruby version (`ruby -v`)
  - Rails version (`bin/rails -v`)
  - Operating System / Platform
- **Error logs or stack traces**: Relevant log snippets from `log/development.log` or browser console errors.
- **Screenshots or videos** (if applicable).

### Suggesting Features

We welcome ideas that enhance the application. To propose a feature:
1. Open a new issue with the tag `[Feature Request]`.
2. Clearly describe the problem this feature solves and the user story.
3. Outline your proposed solution and any alternatives considered.
4. Wait for feedback or discussion from maintainers before writing code to ensure alignment with the project vision.

---

## Local Development Setup

### 1. Prerequisites

- **Ruby 3.4.10** (matching `.ruby-version`)
- **SQLite 3** (`>= 3.8.0`)
- **libvips** (required for image processing)
- **Git**

### 2. Fork and Clone

1. Fork the repository to your own GitHub account.
2. Clone your fork locally:
   ```bash
   git clone https://github.com/<your-username>/store_rails.git
   cd store_rails
   ```
3. Add the upstream remote:
   ```bash
   git remote add upstream https://github.com/faDark13/store_rails.git
   ```

### 3. Bootstrap Environment

Run the automated setup script:

```bash
bin/setup
```

This will:
- Install bundle dependencies (`bundle install`)
- Create and migrate databases (`bin/rails db:prepare`)
- Clean logs and temporary files
- Launch the development server

---

## Development Guidelines

### Branch Naming

Create a descriptive topic branch off the latest `main`:

```bash
git checkout main
git pull upstream main
git checkout -b <type>/<short-description>
```

Recommended prefixes:
- `feat/` for new features (e.g., `feat/product-filtering`)
- `fix/` for bug fixes (e.g., `fix/cart-item-count`)
- `docs/` for documentation updates (e.g., `docs/update-readme`)
- `refactor/` for code refactoring without behavior change
- `test/` for adding or updating test suites
- `chore/` for dependency or build-related changes

### Commit Conventions

We follow [Conventional Commits](https://www.conventionalcommits.org/):

Format: `<type>(<scope>): <short description>`

Examples:
- `feat(cart): add persistent cart storage for guest sessions`
- `fix(checkout): validate shipping address before payment step`
- `docs(readme): add troubleshooting section for libvips installation`
- `style(models): format product model with rubocop rules`

Commit messages should:
- Use imperative mood in the subject ("add feature", not "added feature").
- Keep the first line under 72 characters.
- Reference relevant issue numbers (e.g., `Fixes #42`).

### Coding Standards & Style

We follow the **Rails Omakase** style conventions enforced by RuboCop.

- **Check style**:
  ```bash
  bin/rubocop
  ```
- **Auto-correct safe offenses**:
  ```bash
  bin/rubocop -a
  ```
- Write readable, idiomatic Ruby and Rails code.
- Avoid introducing unnecessary third-party gems; favor Rails 8 built-in features (Solid Queue, Solid Cache, Turbo, Stimulus) whenever possible.
- Avoid inline styles or unmodular CSS; keep stylesheets organized under `app/assets/stylesheets/`.

### Testing Standards

Quality is backed by thorough automated testing. All code contributions must be accompanied by relevant tests.

- **Run unit and integration tests**:
  ```bash
  bin/rails test
  ```
- **Run system tests**:
  ```bash
  bin/rails test:system
  ```
- Place tests in the proper `test/` directory (`models/`, `controllers/`, `system/`, etc.).
- Ensure your tests are deterministic and independent of order (`parallelize` is enabled in `test_helper.rb`).

### Security Best Practices

Security is a primary requirement:
- Never commit secrets, API keys, credentials, or `config/master.key`.
- Run static security analysis before committing:
  ```bash
  bin/brakeman --no-pager
  bin/bundler-audit
  bin/importmap audit
  ```
- Always sanitize and validate user input via strong parameters and Active Record validations.

---

## Pre-Submission Checklist

Before pushing your changes and opening a pull request, run the unified CI script:

```bash
bin/ci
```

Ensure that:
- [ ] `bin/ci` executes with exit code 0.
- [ ] RuboCop reports zero offenses (`bin/rubocop`).
- [ ] Brakeman reports zero warnings (`bin/brakeman`).
- [ ] Bundler Audit and Importmap Audit report zero vulnerabilities.
- [ ] All unit, integration, and system tests pass without failure or errors.
- [ ] Documentation has been updated to reflect code changes.
- [ ] Git commit history is clean, readable, and properly formatted.

---

## Pull Request Process

1. Push your branch to your GitHub fork:
   ```bash
   git push origin <branch-name>
   ```
2. Navigate to the repository on GitHub and click **Compare & pull request**.
3. Fill out the PR template with:
   - Summary of changes and motivation.
   - Related issue links (`Closes #123` or `Fixes #123`).
   - Testing steps for reviewers.
   - Screenshots/GIFs if you modified UI elements.
4. Ensure all automated GitHub Actions CI checks turn green.
5. Address any review comments promptly. Once approved, a project maintainer will squash/rebase and merge your contribution.

---

## Questions and Support

If you have questions about the codebase, reach out via:
- [GitHub Discussions / Issues](https://github.com/faDark13/store_rails/issues)
- Maintainer Email: [dark1234tan@gmail.com](mailto:dark1234tan@gmail.com)

Thank you for helping make Store Rails better!
