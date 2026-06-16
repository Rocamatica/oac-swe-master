# Hugo Installation Reference

**Purpose**: Version and installation guide for Hugo Extended used by REPOC/REPON.
**Last updated**: 2026-06-16

## Current Version

Installed: **v0.163.2** (extended, linux/amd64)
Build date: 2026-06-15

## Installation Methods

### Via npm (recommended for REPON)

```bash
npm install -g hugo-extended
```

This installs a binary wrapper with TypeScript type definitions.

### Via direct binary (alternative)

```bash
# Download from GitHub releases
wget https://github.com/gohugoio/hugo/releases/download/v0.163.2/hugo_extended_0.163.2_linux-amd64.tar.gz
tar -xzf hugo_extended_0.163.2_linux-amd64.tar.gz
sudo mv hugo /usr/local/bin/
```

## Version Policy

- Always use the **latest stable version** (no betas, no RCs)
- Verify before installing: `hugo version`
- Latest check: use `npm view hugo-extended version`

## Requirements

- Node.js 18+ (for npm install)
- Or direct binary download for air-gapped environments
