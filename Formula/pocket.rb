class Pocket < Formula
  desc "Graph execution engine for LLM workflows - CLI tool for executing workflows defined as graphs"
  homepage "https://github.com/agentstation/pocket"
  url "https://github.com/agentstation/pocket/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "placeholder_sha256_will_be_updated_after_release"
  license "MIT"
  head "https://github.com/agentstation/pocket.git", branch: "master"

  depends_on "go" => :build

  def install
    if build.bottle?
      # When installing from a bottle, the binary is pre-built
      bin.install "pocket"
    else
      # Build from source
      system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/pocket"
    end
    
    # Install shell completions if they exist
    bash_completion.install "completions/pocket.bash" if File.exist?("completions/pocket.bash")
    zsh_completion.install "completions/_pocket" if File.exist?("completions/_pocket")
    fish_completion.install "completions/pocket.fish" if File.exist?("completions/pocket.fish")
    
    # Install documentation
    doc.install "README.md", "LICENSE"
    doc.install Dir["docs/*"] if Dir.exist?("docs")
    
    # Install examples
    if Dir.exist?("examples/cli")
      pkgshare.install "examples/cli" => "examples"
    end
  end

  test do
    # Test version command
    assert_match version.to_s, shell_output("#{bin}/pocket version")
    
    # Test help output
    assert_match "Usage:", shell_output("#{bin}/pocket --help")
    
    # Create a simple test workflow
    (testpath/"test.yaml").write <<~EOS
      name: test-workflow
      start: hello
      
      nodes:
        - name: hello
          type: echo
          config:
            message: "Hello from Homebrew test!"
    EOS
    
    # Test dry run
    output = shell_output("#{bin}/pocket run --dry-run #{testpath}/test.yaml")
    assert_match "test-workflow", output
    
    # Test validate command
    assert_match "valid", shell_output("#{bin}/pocket validate #{testpath}/test.yaml")
    
    # Test nodes list command
    output = shell_output("#{bin}/pocket nodes list")
    assert_match "echo", output
    assert_match "http", output
    assert_match "conditional", output
  end

  def caveats
    <<~EOS
      #{Tty.bold}Pocket has been installed! 🚀#{Tty.reset}

      #{Tty.green}Quick start:#{Tty.reset}
        pocket run workflow.yaml      # Run a workflow
        pocket validate workflow.yaml # Validate workflow syntax
        pocket nodes list            # List available nodes
        pocket --help               # Show all commands

      #{Tty.blue}Create your first workflow:#{Tty.reset}
        cat > hello.yaml << 'EOF'
        name: hello-world
        start: greet
        
        nodes:
          - name: greet
            type: echo
            config:
              message: "Hello from Pocket!"
        EOF
        
        pocket run hello.yaml

      #{Tty.yellow}Examples:#{Tty.reset}
        View examples: ls #{opt_pkgshare}/examples/
        
      #{Tty.cyan}Documentation:#{Tty.reset}
        Full docs: https://github.com/agentstation/pocket/tree/master/docs
        Quick start: https://github.com/agentstation/pocket/blob/master/docs/cli/getting-started.md
        
      Build powerful LLM workflows with graphs that think, decide, and act!
    EOS
  end
end