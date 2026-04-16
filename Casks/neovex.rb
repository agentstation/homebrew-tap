cask "neovex" do
  name "neovex"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/agentstation/neovex"
  version "0.1.5"

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
      sha256 "14d21a582e0f9ec29a5d4e1778b70eb4842647253fe4748267bd24a0fae29bc1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_x86_64.tar.gz"
      sha256 "bb7114651eb3101b0024564a2fd6bd3144ee5c3c039b418e1668c0421a26ac3c"
    end
    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_arm64.tar.gz"
      sha256 "314e14071abb193ce2d00fc7da92a89dbd0098153f0ee53cf7e1f89c5193c245"
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

