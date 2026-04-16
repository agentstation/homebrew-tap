cask "neovex" do
  name "neovex"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/agentstation/neovex"
  version "0.1.8"

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
      sha256 "411d75a0dfeaf1660da927e00300adfd52a6d55b62c0e7690509d87c671e9aa8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_x86_64.tar.gz"
      sha256 "7a929e43a80ed5eb976a53348a74449bb438019502e74ba6e5827526ff4d0ee9"
    end
    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_arm64.tar.gz"
      sha256 "afcadabb825805326eff8a036fc02c753567e162a104c5b7b5ba6fb0d89f7d04"
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

