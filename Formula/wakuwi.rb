class Wakuwi < Formula
  desc "Lightweight, read-only Kubernetes UI"
  homepage "https://github.com/stut/wakuwi"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-arm64"
      sha256 "8feffb3e1a6063e4abe02b2d8f06c05e1824cb0389ac687c67e29f8e73c6797b"
    end
    on_intel do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-amd64"
      sha256 "d357ce49d7021c4a7a8aea543d8233421fc6c74db3a7c0c4933c5653d1d32d7e"
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
