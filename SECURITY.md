# Security Policy

The Store Rails team takes the security and integrity of our software and user data very seriously. We appreciate the responsible disclosure of security vulnerabilities by researchers, developers, and users.

This document outlines our security policies, supported versions, and the process for reporting vulnerabilities.

---

## Supported Versions

We provide security patches and updates for the following versions:

| Version / Branch | Supported | Notes |
| :--- | :--- | :--- |
| `main` | :white_check_mark: | Active development branch |
| Rails 8.1.x | :white_check_mark: | Current Rails release line |
| Ruby 3.4.x | :white_check_mark: | Target runtime version |
| < 8.0.0 | :x: | Unsupported |

---

## Reporting a Vulnerability

> [!CAUTION]
> **Please do not report security vulnerabilities through public GitHub issues, pull requests, or public forums.**

If you discover a security vulnerability in Store Rails, please report it privately through one of the following channels:

### Option 1: GitHub Private Vulnerability Reporting (Recommended)

1. Navigate to the repository's [Security Advisories](https://github.com/faDark13/store_rails/security/advisories) page.
2. Click **Report a vulnerability**.
3. Fill out the advisory form with detailed information and submit.

### Option 2: Direct Email

If you cannot use GitHub Security Advisories, send an encrypted or direct email to:

- **Contact**: `dark1234tan@gmail.com`
- **Subject**: `[SECURITY] Vulnerability in Store Rails - <Short Summary>`

---

## What to Include in Your Report

To help us triage and resolve the issue quickly, please provide as much context as possible:

1. **Vulnerability Summary**: A concise description of the security issue.
2. **Steps to Reproduce**: Detailed, step-by-step instructions or a minimal Proof of Concept (PoC) script/request.
3. **Affected Component(s)**: Specific controllers, models, routes, or dependencies involved.
4. **Impact Assessment**: The potential consequences if exploited (e.g., unauthorized access, data exfiltration, privilege escalation, denial of service).
5. **Environment**: Ruby version, Rails version, and configuration details.
6. **Suggested Remediation**: A patch or proposed fix (if available).

---

## Our Response Process & Timeline

Once a vulnerability is reported:

1. **Initial Acknowledgment**: We will acknowledge receipt of your report within **48 hours**.
2. **Triage & Validation**: The maintainers will assess and verify the vulnerability, determining its severity and scope.
3. **Patch Development**: We will develop a fix in a private branch and coordinate verification with the reporter.
4. **Coordinated Disclosure**: A security patch will be released alongside a security advisory. We strive to complete this within **30 days** of initial triage.
5. **Credit**: We will gladly credit you in our release notes and GitHub Security Advisory (unless you prefer to remain anonymous).

---

## Security Practices in This Project

Store Rails incorporates security throughout the development lifecycle:

- **Automated Static Code Analysis**: [Brakeman](https://brakemanscanner.org/) runs on every pull request to catch common Rails security flaws (SQL injection, unsafe redirects, XSS).
- **Gem Dependency Auditing**: [bundler-audit](https://github.com/flavorjones/bundler-audit) inspects Ruby gems against the National Vulnerability Database (NVD) and Ruby Advisory Database.
- **JavaScript Dependency Auditing**: `bin/importmap audit` continuously scans ESM packages for known vulnerabilities.
- **Automated Dependency Updates**: [Dependabot](https://github.com/dependabot) is configured to monitor and propose updates for vulnerabilities in gems and actions.
- **Container Hardening**:
  - Production containers execute as a dedicated, non-root user (`rails:rails` with UID 1000).
  - Uses minimal base images (`ruby:3.4.10-slim`) to minimize attack surface.
  - Utilizes `jemalloc` for memory management and leak mitigation.
- **Built-in Rails Defenses**:
  - Cross-Site Request Forgery (CSRF) protection enabled by default.
  - Strong Parameters strictly enforced across all controllers.
  - Content Security Policy (CSP) headers configured for modern web standards.
  - Secure-by-default HTTP cookies with `SameSite` and `HttpOnly` attributes.

Thank you for helping keep Store Rails and our community secure!
