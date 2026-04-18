cask "neovex" do
  name "neovex"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/agentstation/neovex"
  version "0.1.11"

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
      sha256 "43fcae1dc1ce56876d37b4d52b21501cb5f17ee4ae1fbfb0bf2a064153acbeb8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_x86_64.tar.gz"
      sha256 "74249af9c72372c39f12f72a338c00ce3421a50288708996ea7dfc099fe209a8"
    end
    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_arm64.tar.gz"
      sha256 "76f1528590193650036cfc20c61fe657c0775bad85a807b179442c46eae9511f"
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

