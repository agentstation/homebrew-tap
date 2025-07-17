class Tydirium < Formula
  desc "Email authentication checker - It's an older email, sir, but it checks out"
  homepage "https://github.com/agentstation/tydirium"
  url "https://github.com/agentstation/tydirium/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "44d5ed0c9779cd99b119ae1e9a84d89f21bff20616ba8d42fdb1c7d01ef93102"
  license "MIT"
  head "https://github.com/agentstation/tydirium.git", branch: "master"

  # Dependencies - dig is part of bind on macOS/Linux
  depends_on "bind" => :optional # Provides 'dig' command if not already present

  def install
    # Install the main script
    bin.install "tydirium"
    
    # Install documentation
    doc.install "README.md", "LICENSE"
    doc.install "docs" if File.exist?("docs")
  end

  test do
    # Test that the script runs and shows help
    assert_match "Usage:", shell_output("#{bin}/tydirium -h")
    
    # Test version output
    assert_match "tydirium", shell_output("#{bin}/tydirium -h")
    
    # Test a basic domain check (using a reliable domain)
    system "#{bin}/tydirium", "-q", "google.com"
  end

  def caveats
    <<~EOS
      tydirium has been installed! 🚀

      Quick start:
        tydirium example.com
        tydirium user@example.com
        tydirium -q example.com  # Quick mode
        tydirium -v example.com  # Verbose mode

      May the Force be with your email deliverability!
    EOS
  end
end