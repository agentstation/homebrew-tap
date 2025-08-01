class Tokenizer < Formula
  desc "High-performance tokenizer implementations in Go with unified CLI"
  homepage "https://github.com/agentstation/tokenizer"
  url "https://github.com/agentstation/tokenizer/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "0a0a2725b792b5a02f0f6254f6a167bd2b903c882c69bca90230c8777c83f64c"
  license "MIT"
  head "https://github.com/agentstation/tokenizer.git", branch: "master"

  depends_on "go" => :build

  def install
    if build.bottle?
      # When installing from a bottle, the binary is pre-built
      bin.install "tokenizer"
    else
      # Build from source with version information
      ldflags = %W[
        -s -w
        -X main.version=#{version}
        -X main.commit=#{Utils.git_short_head}
        -X main.buildDate=#{Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")}
        -X main.goVersion=#{Formula["go"].version}
      ]
      system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/tokenizer"
    end
    
    # Install documentation
    doc.install "README.md", "LICENSE", "CLAUDE.md"
    doc.install "llama3/README.md" => "llama3-README.md"
    doc.install "llama3/IMPLEMENTATION.md" => "llama3-IMPLEMENTATION.md"
    
    # Install examples
    if Dir.exist?("examples")
      pkgshare.install "examples"
    end
  end

  test do
    # Test version command
    output = shell_output("#{bin}/tokenizer version")
    assert_match version.to_s, output
    assert_match "commit:", output
    assert_match "built:", output
    assert_match "go version:", output
    
    # Test help output
    assert_match "Usage:", shell_output("#{bin}/tokenizer --help")
    assert_match "Available Commands:", shell_output("#{bin}/tokenizer --help")
    
    # Test llama3 subcommand
    assert_match "llama3", shell_output("#{bin}/tokenizer --help")
    assert_match "encode", shell_output("#{bin}/tokenizer llama3 --help")
    
    # Test encoding
    output = shell_output("#{bin}/tokenizer llama3 encode 'Hello, world!'")
    assert_match "128000", output # begin_of_text token
    assert_match "9906", output   # "Hello" token
    assert_match "128001", output # end_of_text token
    
    # Test decoding
    output = shell_output("#{bin}/tokenizer llama3 decode 128000 9906 11 1917 0 128001")
    assert_match "Hello", output
    assert_match "world", output
    
    # Test info command
    output = shell_output("#{bin}/tokenizer llama3 info")
    assert_match "Vocabulary Size: 128256", output
    assert_match "Regular Tokens: 128000", output
    assert_match "Special Tokens: 256", output
    
    # Test piping
    output = pipe_output("#{bin}/tokenizer llama3 encode", "Test input")
    assert_match "128000", output # begin_of_text token
  end

  def caveats
    <<~EOS
      #{Tty.bold}Tokenizer has been installed! 🚀#{Tty.reset}

      #{Tty.green}Quick start:#{Tty.reset}
        tokenizer llama3 encode "Hello, world!"     # Encode text to tokens
        tokenizer llama3 decode 128000 9906 128001  # Decode tokens to text
        tokenizer llama3 info                       # Show tokenizer info
        tokenizer --help                            # Show all commands

      #{Tty.blue}Examples:#{Tty.reset}
        # Encode text without special tokens
        tokenizer llama3 encode --bos=false --eos=false "Hello"
        
        # Stream large files
        cat document.txt | tokenizer llama3 stream
        
        # Different output formats
        tokenizer llama3 encode -o json "Hello"     # JSON array
        tokenizer llama3 encode -o newline "Hello"  # One token per line

      #{Tty.yellow}Use cases:#{Tty.reset}
        • Count tokens in a file: tokenizer llama3 encode < file.txt | wc -w
        • Process multiple files: for f in *.txt; do tokenizer llama3 encode < "$f" > "${f%.txt}.tokens"; done
        • Round-trip test: tokenizer llama3 encode "test" | tokenizer llama3 decode
        
      #{Tty.cyan}Documentation:#{Tty.reset}
        Full docs: https://github.com/agentstation/tokenizer
        API docs: https://pkg.go.dev/github.com/agentstation/tokenizer
        
      High-performance tokenization for LLMs at your fingertips!
    EOS
  end
end