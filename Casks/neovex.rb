cask "neovex" do
  name "neovex"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/agentstation/neovex"
  version "0.1.22"

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
      sha256 "9f53ba792f2523905f649b5144ac32157a52ef04c8bae6434a18224a1b586885"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_x86_64.tar.gz"
      sha256 "bfae01c8b2f0d57f5d271b8c61a20934c6a1e51416858d274bab84cc453e335c"
    end
    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_arm64.tar.gz"
      sha256 "1204569d2670767d9f83d295837162a6723520319799134136963d38d4ac272c"
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

