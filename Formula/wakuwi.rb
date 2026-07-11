class Wakuwi < Formula
  desc "Lightweight, read-only Kubernetes UI"
  homepage "https://github.com/stut/wakuwi"
  version "1.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-arm64"
      sha256 "9ab998fe443735ee4c6ad1abe29ea1baf071fdd3c2c3145318aabec64c1675e6"
    end
    on_intel do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-amd64"
      sha256 "7e489e090dfafcd4b62016915b00722ab70380736441fb48a922e47e3a79310f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-linux-arm64"
      sha256 "5b30d45c20a9db82a5ef8b41b64c4f06490b71f60608a427450ae129473a82e8"
    end
    on_intel do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-linux-amd64"
      sha256 "314f25ec979a09ba108492142c530fc9de98561feaf38634f632328d3864923a"
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
