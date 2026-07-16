class Wakuwi < Formula
  desc "Lightweight, read-only Kubernetes UI"
  homepage "https://github.com/stut/wakuwi"
  version "1.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-arm64"
      sha256 "991fc970a95c71b3e6feefb053dd200b6bb8b75657811a84371cb2db397125f0"
    end
    on_intel do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-amd64"
      sha256 "3bbcb8dc846aadb4370dc4196a3f6e1430b2e4b6b2f1594c57773a1474f08420"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-linux-arm64"
      sha256 "14a147cfc82381bb397c92348ac046e664fc3722646dcb8ded83259466261385"
    end
    on_intel do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-linux-amd64"
      sha256 "79197c96ab930439d2911591ad84ce95a01eccdb3b403f6a964922d12896590c"
    end
  end

  def install
    bin.install Dir["wakuwi-*"].first => "wakuwi"
  end

  service do
    run [opt_bin/"wakuwi"]
    keep_alive true
    log_path var/"log/wakuwi.log"
    error_log_path var/"log/wakuwi.log"
  end

  def caveats
    <<~EOS
      To start wakuwi as a background service:
        brew services start stut/tools/wakuwi

      Or run it manually:
        wakuwi

      Then open http://localhost:9753 in your browser.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wakuwi --version 2>&1", 1)
  end
end
