# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is the official Homebrew tap for AgentStation tools. It contains formula definitions for installing AgentStation command-line tools via Homebrew on macOS and Linux.

## Repository Structure

- `Formula/` - Contains Ruby formula files that define how to install each tool
  - Each `.rb` file is a Homebrew formula following the standard formula DSL
  - Current formulas: `pocket.rb`, `tydirium.rb`
- `README.md` - User-facing documentation for the tap

## Common Commands

### Testing Formulas Locally

```bash
# Install from local formula file (for testing before committing)
brew install --build-from-source ./Formula/<name>.rb

# Test the formula installation
brew test agentstation/tap/<formula-name>

# Uninstall to test fresh installs
brew uninstall <formula-name>
```

### Validating Formulas

```bash
# Run brew style checks on formula syntax
brew style Formula/<name>.rb

# Audit formula for common issues (requires formula to be installed)
brew audit --strict --online <formula-name>
```

### Adding or Updating a Formula

1. When updating a formula version:
   - Update the `url` to point to the new release tag
   - Update the `sha256` hash (get from GitHub release page or calculate with `shasum -a 256 <tarball>`)
   - Test the installation locally before committing

2. Formula components to update:
   - `desc` - One-line description
   - `homepage` - Project homepage URL
   - `url` - Source tarball URL (usually GitHub release)
   - `sha256` - SHA256 hash of the source tarball
   - `version` - Extracted automatically from URL if following semver
   - `depends_on` - Build and runtime dependencies
   - `install` method - Build and installation instructions
   - `test` block - Tests that run with `brew test`
   - `caveats` - Post-install messages shown to users

## Important Considerations

- SHA256 hashes must be accurate - never use placeholder values in production
- Test formulas locally before pushing to ensure they install correctly
- The `test` block should include meaningful tests that verify the installation
- Use `build.bottle?` checks when supporting bottle (pre-compiled) distributions
- Follow Homebrew's formula cookbook guidelines for consistency
- Formulas should handle completions and documentation installation when available

## Git Workflow

- Commits should describe what formula was added/updated and what version
- Include relevant details in commit messages (e.g., "Update tydirium to v1.4.0")
- Tag releases are not used in this tap repository - the formulas reference upstream project tags