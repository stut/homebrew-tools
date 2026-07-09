class Wakuwi < Formula
  desc "Lightweight, read-only Kubernetes UI"
  homepage "https://github.com/stut/wakuwi"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-arm64"
      sha256 "6d50968096c3a084c50d2fbe6cc55e5cde0d52c799063635ea6ed0887c598c3c"
    end
    on_intel do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-amd64"
      sha256 "fb492e345c8c06f804730a49ca0549db4c5917e465c3a6f506fcc0fd8c4c2404"
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
