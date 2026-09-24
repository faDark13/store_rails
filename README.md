# Store Rails

[![CI](https://github.com/faDark13/store_rails/actions/workflows/ci.yml/badge.svg)](https://github.com/faDark13/store_rails/actions/workflows/ci.yml)
[![Ruby](https://img.shields.io/badge/Ruby-3.4.10-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-8.1.3-cc0000.svg)](https://rubyonrails.org/)
[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](LICENSE)

A modern, high-performance web store application built on **Ruby on Rails 8**, designed for speed, developer joy, and seamless production readiness.

---

## Table of Contents

- [Architecture & Tech Stack](#architecture--tech-stack)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Development Workflow](#development-workflow)
- [Running Tests & Quality Checks](#running-tests--quality-checks)
- [Background Jobs & Caching](#background-jobs--caching)
- [Docker & Production Deployment](#docker--production-deployment)
- [Contributing](#contributing)
- [Security](#security)
- [License](#license)

---

## Architecture & Tech Stack

- **Framework**: [Ruby on Rails 8.1](https://rubyonrails.org/) running on **Ruby 3.4.10**
- **Database**: [SQLite3](https://www.sqlite.org/) with WAL mode and multi-database isolation for cache, queue, and cable
- **Solid Suite**:
  - **Cache**: [`solid_cache`](https://github.com/rails/solid_cache) (database-backed cache store)
  - **Queue**: [`solid_queue`](https://github.com/rails/solid_queue) (database-backed Active Job backend)
  - **Cable**: [`solid_cable`](https://github.com/rails/solid_cable) (database-backed Action Cable pub/sub)
- **Frontend & Assets**:
  - **Asset Pipeline**: [Propshaft](https://github.com/rails/propshaft)
  - **JavaScript**: [Importmap Rails](https://github.com/rails/importmap-rails) (Node-free modern ESM JavaScript)
  - **Interactivity**: [Hotwire](https://hotwired.dev/) ([Turbo](https://turbo.hotwired.dev/) & [Stimulus](https://stimulus.hotwired.dev/))
- **Web Server & Acceleration**: [Puma](https://puma.io/) accelerated by [Thruster](https://github.com/basecamp/thruster) (HTTP asset compression, caching, and X-Sendfile)
- **Media Processing**: [Active Storage](https://guides.rubyonrails.org/active_storage_overview.html) with [image_processing](https://github.com/janko/image_processing) via `libvips`
- **Deployment**: [Kamal 2](https://kamal-deploy.org/) containerized deployment with [Docker](https://www.docker.com/)

---

## Prerequisites

Ensure you have the following installed on your local development machine:

1. **Ruby**: `3.4.10` (managed via [rbenv](https://github.com/rbenv/rbenv), [asdf](https://asdf-vm.com/), or [rvm](https://rvm.io/))
2. **Bundler**: `gem install bundler`
3. **SQLite3**: `>= 3.8.0` with development headers (`libsqlite3-dev`)
4. **libvips**: Image processing library
   - **Ubuntu/Debian**: `sudo apt-get install -y libvips`
   - **macOS**: `brew install vips`
   - **Fedora**: `sudo dnf install vips`
5. **Git**

---

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/faDark13/store_rails.git
cd store_rails
```

### 2. Automated Setup

Run the built-in setup script to install dependencies, prepare databases, and clear cache:

```bash
bin/setup
```

> **Note**: `bin/setup` will automatically launch the development server at the end. To run the setup without starting the server, pass `--skip-server`:
> ```bash
> bin/setup --skip-server
> ```

### 3. Start Development Server

If not started by `bin/setup`, launch the local server:

```bash
bin/dev
# or directly:
bin/rails server
```

The application will be accessible at:
- **Web App**: [http://localhost:3000](http://localhost:3000)
- **Health Check**: [http://localhost:3000/up](http://localhost:3000/up) (returns `200 OK` when the application is healthy)

---

## Development Workflow

### Database Operations

The application leverages isolated SQLite databases for development, test, and background systems:

```bash
# Run database migrations
bin/rails db:migrate

# Reset database from seeds
bin/rails db:reset

# Seed the database
bin/rails db:seed
```

### JavaScript Dependencies

JavaScript packages are managed via Importmap without needing npm/yarn:

```bash
# Pin a new package from CDN
bin/importmap pin <package_name>

# Update pinned packages
bin/importmap update

# Check for security vulnerabilities in JS packages
bin/importmap audit
```

---

## Running Tests & Quality Checks

We maintain strict quality, style, and security guidelines enforced via continuous integration.

### All-in-One CI Check

To run the complete CI validation suite locally (linting, vulnerability scanning, database replant, and unit tests):

```bash
bin/ci
```

### Individual Commands

| Check | Command | Description |
| :--- | :--- | :--- |
| **Ruby Tests** | `bin/rails test` | Runs unit, model, controller, and integration tests |
| **System Tests** | `bin/rails test:system` | Runs browser-driven system tests via Capybara & Selenium |
| **Code Style** | `bin/rubocop` | Enforces Rails Omakase coding style guidelines |
| **Code Style Auto-fix** | `bin/rubocop -a` | Automatically fixes safe style offenses |
| **Static Security (Brakeman)**| `bin/brakeman --no-pager` | Scans for Rails security vulnerabilities |
| **Ruby Gem Vulnerabilities** | `bin/bundler-audit` | Checks installed gems against known CVE database |
| **JS Dependency Audit** | `bin/importmap audit` | Audits JavaScript importmap packages |

---

## Background Jobs & Caching

Rails 8 replaces external dependencies (like Redis or Sidekiq) with database-backed services powered by SQLite:

- **Solid Queue**: Jobs are processed asynchronously. In development, the worker runs transparently. In production, workers run either inside Puma or via a dedicated process:
  ```bash
  bin/jobs
  ```
- **Solid Cache**: Stores fragment and action caching directly in `storage/development_cache.sqlite3`.
- **Solid Cable**: Manages WebSocket connections for real-time features using `storage/development_cable.sqlite3`.

---

## Docker & Production Deployment

### Production Docker Container

A multi-stage, hardened [Dockerfile](file:///home/bruce_pham/code/store_rails/Dockerfile) is included:

- Uses `ruby:3.4.10-slim`
- Optimizes memory usage using `jemalloc`
- Executes as a non-privileged user (`rails:rails`)
- Precompiles assets and Bootsnap caches

To build and run the production image locally:

```bash
# Build Docker image
docker build -t store .

# Run container (requires RAILS_MASTER_KEY or config/master.key)
docker run -d -p 80:80 \
  -e RAILS_MASTER_KEY="$(cat config/master.key)" \
  --name store_app store
```

### Kamal Deployment

Deployments are orchestrated using [Kamal](https://kamal-deploy.org/) via [`config/deploy.yml`](file:///home/bruce_pham/code/store_rails/config/deploy.yml):

```bash
# First-time server setup
bin/kamal setup

# Deploy new release
bin/kamal deploy
```

---

## Contributing

We welcome contributions! Please read our [CONTRIBUTING.md](file:///home/bruce_pham/code/store_rails/CONTRIBUTING.md) guide and adhere to our [CODE_OF_CONDUCT.md](file:///home/bruce_pham/code/store_rails/CODE_OF_CONDUCT.md).

---

## Security

Please report any security vulnerabilities responsibly. See [SECURITY.md](file:///home/bruce_pham/code/store_rails/SECURITY.md) for our vulnerability disclosure policy and contact details.

---

## License

This project is licensed under the **GNU Affero General Public License v3.0** (AGPL-3.0). See the [LICENSE](file:///home/bruce_pham/code/store_rails/LICENSE) file for details.
