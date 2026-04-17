cask "neovex" do
  name "neovex"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/agentstation/neovex"
  version "0.1.10"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "neovex"

  on_macos do
    on_intel do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_darwin_x86_64.tar.gz"
      sha256 ""
    end
    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_darwin_arm64.tar.gz"
      sha256 "b7190350be58c53644a8243ad93d4b8c509c58a982c9422b7a815185ff55cda5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_x86_64.tar.gz"
      sha256 "a9557c2f3feccc9a482331697e18940f47e209423f2f6dc1d8b06e7f45c855c5"
    end
    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_arm64.tar.gz"
      sha256 "3e50aa487fccb02e9e0f3a9cea774562eb5d1062b1fcb634a2b1d20f15e26e5a"
    end
  end

  postflight do
    if system_command("/usr/bin/xattr", args: ["-h"]).exit_status == 0
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/neovex"], sudo: false
    end
  end

  caveats do
    "Neovex has been installed!"
    ""
    "Quick start:"
    "  neovex --help              # Show all commands"
    "  neovex --port 8080         # Start server on port 8080"
    ""
    "Documentation: https://github.com/agentstation/neovex"
  end
end

