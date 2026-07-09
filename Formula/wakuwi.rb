class Wakuwi < Formula
  desc "Lightweight, read-only Kubernetes UI"
  homepage "https://github.com/stut/wakuwi"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-arm64"
      sha256 "6338e4f1fde429ab32aa6851f51228775b3a199c6b04cd72955f9d4477b1f67a"
    end
    on_intel do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-amd64"
      sha256 "f0555f49fa6d60f21e522c544871348c3d42f738fc2dd2b689b14081a59a9c6d"
    end
  end

  def install
    bin.install Dir["wakuwi-darwin-*"].first => "wakuwi"
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
