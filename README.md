# AgentStation Homebrew Tap

This is the official [Homebrew](https://brew.sh) tap for AgentStation tools.

## Installation

```bash
brew tap agentstation/tap
```

Homebrew 6 requires trust for packages from third-party taps. The commands below
trust each package separately. See [Homebrew tap trust](https://docs.brew.sh/Tap-Trust).

## Available Casks

Casks install pre-built binaries from GitHub releases.

### ago

A restriction-only Go linter. Every rule rejects a legal Go construct to keep a codebase in a smaller, more predictable subset of the language.

```bash
brew trust --cask agentstation/tap/ago
brew install --cask agentstation/tap/ago
```

### neovex

Self-hosted JavaScript backend runtime powered by V8.

```bash
brew trust --cask agentstation/tap/neovex
brew install --cask agentstation/tap/neovex
```

### starmap

AI Model Catalog System - Discover, compare, and sync AI models across providers.

```bash
brew trust --cask agentstation/tap/starmap
brew install --cask agentstation/tap/starmap
```

### starport

OpenAI- and OpenRouter-compatible LLM inference gateway.

```bash
brew trust --cask agentstation/tap/starport
brew install --cask agentstation/tap/starport
```

### tokenizer

High-performance tokenizer implementations in Go with unified CLI. Features Llama 3 tokenizer with exact compatibility, streaming support, and comprehensive tooling.

```bash
brew trust --cask agentstation/tap/tokenizer
brew install --cask agentstation/tap/tokenizer
```

### vhs

A tool for recording terminal GIFs and SVGs. AgentStation fork with SVG output support.

```bash
brew trust --cask agentstation/tap/vhs
brew install --cask agentstation/tap/vhs
```

## Available Formulas

Formulas build from source.

### pocket

Graph execution engine for LLM workflows - CLI tool for executing workflows defined as graphs.

```bash
brew trust --formula agentstation/tap/pocket
brew install --HEAD --formula agentstation/tap/pocket
```

Pocket has no tagged CLI release. The Homebrew formula builds the current `master` branch with `--HEAD`.

### tydirium

Email authentication checker - "It's an older email, sir, but it checks out."

```bash
brew trust --formula agentstation/tap/tydirium
brew install --formula agentstation/tap/tydirium
```

## Alternative Installation Methods

These tools are also available via [Nix](https://nixos.org/) and [Devbox](https://www.jetify.com/devbox):

### Using Devbox
```bash
devbox add github:agentstation/nix-packages#neovex
devbox add github:agentstation/nix-packages#starmap
devbox add github:agentstation/nix-packages#tokenizer
devbox add github:agentstation/nix-packages#vhs
devbox add github:agentstation/nix-packages#pocket
devbox add github:agentstation/nix-packages#tydirium
```

### Using Nix
```bash
nix run github:agentstation/nix-packages#neovex -- --help
nix run github:agentstation/nix-packages#starmap -- --help
nix run github:agentstation/nix-packages#tokenizer -- --help
nix run github:agentstation/nix-packages#vhs -- --help
nix run github:agentstation/nix-packages#pocket -- --help
nix run github:agentstation/nix-packages#tydirium -- --help
```

For more Nix installation options, see [agentstation/nix-packages](https://github.com/agentstation/nix-packages).

## Development

To add a new formula or cask:

1. Create a new `.rb` file in `Formula/` (for source builds) or `Casks/` (for pre-built binaries)
2. Follow the [Homebrew formula cookbook](https://docs.brew.sh/Formula-Cookbook) or [cask cookbook](https://docs.brew.sh/Cask-Cookbook)
3. Test locally: `brew install --build-from-source ./Formula/<name>.rb` or `brew install --cask ./Casks/<name>.rb`
4. Submit a PR

## License

All formulas and casks in this repository are licensed under the MIT License.