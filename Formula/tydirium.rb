class Tydirium < Formula
  desc "Email authentication checker - It's an older email, sir, but it checks out"
  homepage "https://github.com/agentstation/tydirium"
  url "https://github.com/agentstation/tydirium/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "f258c76cb0bd446087fec891c5ac4fb110698a50a72079c920a536d5789281a2"
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