# AgentStation Homebrew Tap

This is the official [Homebrew](https://brew.sh) tap for AgentStation tools.

## Installation

```bash
brew tap agentstation/tap
```

## Available Formulas

### pocket

Graph execution engine for LLM workflows - CLI tool for executing workflows defined as graphs.

```bash
brew install agentstation/tap/pocket
```

Or directly:

```bash
brew install agentstation/tap/pocket
```

### tydirium

Email authentication checker - "It's an older email, sir, but it checks out."

```bash
brew install agentstation/tap/tydirium
```

Or directly:

```bash
brew install agentstation/tap/tydirium
```

## Development

To add a new formula:

1. Create a new `.rb` file in the `Formula` directory
2. Follow the [Homebrew formula cookbook](https://docs.brew.sh/Formula-Cookbook)
3. Test locally: `brew install --build-from-source ./Formula/<name>.rb`
4. Submit a PR

## License

All formulas in this repository are licensed under the MIT License.