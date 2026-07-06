class Wakuwi < Formula
  desc "Lightweight, read-only Kubernetes UI"
  homepage "https://github.com/stut/wakuwi"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-arm64"
      sha256 "f0d8df092388022afd6003c448fb5a8a29316b0f389277a26fe5b2639c3588a8"
    end
    on_intel do
      url "https://github.com/stut/wakuwi/releases/download/v#{version}/wakuwi-darwin-amd64"
      sha256 "51372feaa730160a3d08be64a6af3400e09501bde20497040aa93025c2f24fac"
    end
  end

  def install
    bin.install Dir["wakuwi-darwin-*"].first => "wakuwi"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wakuwi --version 2>&1", 1)
  end
end
