cask "neovex" do
  name "neovex"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/agentstation/neovex"
  version "0.1.7"

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
      sha256 "2f1f8aefa5a78fb3303204ce0bc5c127461484bc5615d702a5ed5cbfb7cfd2c7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_x86_64.tar.gz"
      sha256 "a1894727afab4836244fec81453b6402ae2b9eb0d87d4a5543e0d48636a9ff28"
    end
    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_arm64.tar.gz"
      sha256 "6bb744b99fcc46f3e92e8b69b7c8f95e939eb956fd2f08059626d9bd2bea2706"
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

