cask "neovex" do
  name "neovex"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/agentstation/neovex"
  version "0.1.16"

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
      sha256 "e01999c95822ef3cdc2edf25db2f242eac3e21e22045dd88e946a3fb7776f317"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_x86_64.tar.gz"
      sha256 "ef1fb8ae4f30332adf2cda8dc0f2858671a8fc905f120f720969c5fe11a017bb"
    end
    on_arm do
      url "https://github.com/agentstation/neovex/releases/download/v#{version}/neovex_linux_arm64.tar.gz"
      sha256 "cb27f7298ab1172e3ff279ba215a5716272dbc206f3e961704b976a47931787b"
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

