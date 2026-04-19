cask "neovex" do
  name "neovex"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/agentstation/neovex"
  version "0.1.18"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "neovex"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: ">= :sonoma"
    depends_on formula: "slp/krunkit/krunkit"

    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_darwin_arm64.tar.gz"
      sha256 "91a92ce8ed8b22b4bcb48ad4befab2aba8091158ee6364735335a864024f5865"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_x86_64.tar.gz"
      sha256 "17be07928a7a882a1a7b03524e4f522d388d617aaace2a0e8aeae0e81b922299"
    end
    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_arm64.tar.gz"
      sha256 "09005e03e2bd104f9af3663c0cf3119a77eff79921242f071dcc0c162bb3980f"
    end
  end

  postflight do
    if system_command("/usr/bin/xattr", args: ["-h"]).exit_status == 0
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", staged_path.to_s], sudo: false
    end
  end

  caveats do
    "Neovex has been installed!"
    ""
    "Quick start:"
    "  neovex --help              # Show all commands"
    "  neovex machine init        # Record the default macOS machine contract"
    "  neovex serve               # Auto-start the machine if needed"
    ""
    "Documentation: https://github.com/agentstation/neovex"
  end
end

