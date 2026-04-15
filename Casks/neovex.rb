cask "neovex" do
  name "neovex"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/agentstation/neovex"
  version "0.1.4"

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
      sha256 "fa5ac73f36a66ae1b7f6c8688e83fd9d6941825bca45951134aeae959e874c94"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_x86_64.tar.gz"
      sha256 "e30214eba385bc02836aacb9ba50ae0c24e5e372c513b0459a3b2b23824032a8"
    end
    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_arm64.tar.gz"
      sha256 "f570e9e458ae56d979651171839987a28c3bf47a1ee9e8e3da25e653911f3c95"
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

