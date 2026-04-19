cask "neovex" do
  name "neovex"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/agentstation/neovex"
  version "0.1.15"

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
      sha256 "5ef4e21193fdd7957d596450d70cd07d058d4785f560120d7507b89060e8ff59"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_x86_64.tar.gz"
      sha256 "219140d7ca08222d26b5474f52f13cbcd36347e2c86daee9a9f79e15ee31f637"
    end
    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_arm64.tar.gz"
      sha256 "8d4f15a54ebadb156f12f26b3daef074336e37e167df9e33c5059d83f296ab2d"
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

