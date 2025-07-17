class Tydirium < Formula
  desc "Email authentication checker - It's an older email, sir, but it checks out"
  homepage "https://github.com/agentstation/tydirium"
  url "https://github.com/agentstation/tydirium/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "3b12eb3b2a176b8fe90c6bfa711e90af5df453afdc0c48e5224b00573ea9e8b3"
  license "MIT"
  head "https://github.com/agentstation/tydirium.git", branch: "master"

  # Use system dig command (usually pre-installed)
  uses_from_macos "bind"

  def install
    # Install the main script
    bin.install "tydirium"
    
    # Install shell completions
    bash_completion.install "completions/tydirium.bash" if File.exist?("completions/tydirium.bash")
    zsh_completion.install "completions/_tydirium" if File.exist?("completions/_tydirium")
    fish_completion.install "completions/tydirium.fish" if File.exist?("completions/tydirium.fish")
    
    # Install documentation
    doc.install "README.md", "LICENSE", "CHANGELOG.md"
    doc.install Dir["docs/*"] if Dir.exist?("docs")
    
    # Install man page
    man1.install "man/tydirium.1" if File.exist?("man/tydirium.1")
    
    # Install examples if available
    if Dir.exist?("examples")
      pkgshare.install "examples"
    end
  end

  def post_install
    # Check if dig is available
    unless which("dig")
      opoo <<~EOS
        The 'dig' command was not found in your PATH.
        tydirium requires dig to perform DNS lookups.
        
        On macOS, dig is usually pre-installed.
        On Linux, install with:
          - Debian/Ubuntu: sudo apt-get install dnsutils
          - RHEL/CentOS: sudo yum install bind-utils
          - Arch: sudo pacman -S bind-tools
      EOS
    end
  end

  test do
    # Test version flag
    assert_match version.to_s, shell_output("#{bin}/tydirium -V")
    
    # Test help output
    assert_match "Usage:", shell_output("#{bin}/tydirium -h")
    
    # Test with a known good domain in quick mode
    output = shell_output("#{bin}/tydirium -q google.com")
    assert_match "SPF", output
    assert_match "MX", output
    
    # Test with invalid option
    assert_match "Invalid option", shell_output("#{bin}/tydirium -z 2>&1", 1)
    
    # Test that completions were installed
    assert_predicate bash_completion/"tydirium.bash", :exist?
    assert_predicate zsh_completion/"_tydirium", :exist?
    assert_predicate fish_completion/"tydirium.fish", :exist?
  end

  def caveats
    s = <<~EOS
      #{Tty.bold}tydirium has been installed! 🚀#{Tty.reset}

      #{Tty.green}Quick start:#{Tty.reset}
        tydirium example.com          # Check a domain
        tydirium user@example.com     # Check an email address
        tydirium -q example.com       # Quick mode (3 DNS servers)
        tydirium -v example.com       # Verbose mode (detailed output)
        tydirium -V                   # Show version

      #{Tty.blue}Shell completions:#{Tty.reset}
        Bash: source $(brew --prefix)/etc/bash_completion
        Zsh: Already loaded if using Homebrew's completions
        Fish: Already loaded automatically

      #{Tty.yellow}Common issues:#{Tty.reset}
        • SPF record not found? Check if you're querying the right domain
        • DKIM not found? Try common selectors: google, default, dkim
        • Slow DNS propagation? New records can take up to 48 hours

      #{Tty.cyan}Documentation:#{Tty.reset}
        View docs: open $(brew --prefix)/share/doc/tydirium/README.md
        Report issues: https://github.com/agentstation/tydirium/issues

      May the Force be with your email deliverability!
    EOS


    s
  end
end