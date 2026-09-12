# Release metadata from goago v0.3.0. Future releases replace this file.
cask "goago" do
  version "0.3.0"

  on_macos do
    on_arm do
      sha256 "0d2b40f19307b1fa6262e90a75783f992d00ad93efca3712361546c2a39a393a"
      url "https://github.com/agentstation/goago/releases/download/v#{version}/goago_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "49d1cab23f0886c3c466fcdbb58dd4a40ee87216122ba426c563fb02837db4b5"
      url "https://github.com/agentstation/goago/releases/download/v#{version}/goago_#{version}_darwin_x86_64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "edc758c977488d2c2138eebc045def99d02e08b74b7ce5eef54ae8f727a9dc53"
      url "https://github.com/agentstation/goago/releases/download/v#{version}/goago_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "fd380b84b452f487bea7f89117500dc0802f6b331cd1012c1eb4591cb8033c40"
      url "https://github.com/agentstation/goago/releases/download/v#{version}/goago_#{version}_linux_x86_64.tar.gz"
    end
  end

  name "goago"
  desc "Linter that enforces one way to write Go"
  homepage "https://github.com/agentstation/goago"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "goago"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/goago"], sudo: false
    end
  end

  # No zap stanza required
end
