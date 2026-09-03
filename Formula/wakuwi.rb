class Wakuwi < Formula
  desc "Lightweight, read-only Kubernetes UI"
  homepage "https://github.com/stut/wakuwi"
  version "1.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-arm64"
      sha256 "6f5d1fb4d25f54bf37b933d79c60d019b4bc9b04925a3c95c9a510a6db7c452c"
    end
    on_intel do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-amd64"
      sha256 "177fea15ae5a809defd069984f96720fafc85b8c50e543d8d800910b7cdc697c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-linux-arm64"
      sha256 "9197317b138023fa31649ee4450454baac51afc86bd38b897cc45d0c6fe94bec"
    end
    on_intel do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-linux-amd64"
      sha256 "3cdc48f096930ae29b2c4b3ef477c92302af63734af02b95d0e058946678376b"
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
