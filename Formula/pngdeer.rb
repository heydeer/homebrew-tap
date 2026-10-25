class Pngdeer < Formula
  desc "Lossy PNG compression with automatic quality selection"
  homepage "https://github.com/heydeer/homebrew-tap"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on macos: :big_sur

    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.0/pngdeer-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "5a8c07900a2573d58d80c876e96f57619ecbbd3715d74999773965ec34a9193e"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.0/pngdeer-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "f0b458c95d81929f7ac7cfd770469eb462b6d7b1936dda0145ac1dcd45822c47"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.0/pngdeer-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b2cd46a982b22d14232d4c3931100b751ffda1911915660b544e7fad38fae7cb"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.0/pngdeer-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "96ae8405f7e50f0a5daf39180b86a33901d50be6f4b00b79ff5cbcd8d022d44b"
    end
  end

  def install
    bin.install "pngdeer"
    prefix.install "LICENSE-MIT", "LICENSE-APACHE"
    pkgshare.install "THIRD_PARTY_LICENSES.txt"
  end

  test do
    system bin/"pngdeer", test_fixtures("test.png"), "-o", "input.png", "--upscale", "8"
    system bin/"pngdeer", "input.png", "-o", "output.png", "--target", "85"
    assert_path_exists testpath/"output.png"
    assert_operator (testpath/"output.png").size, :<, (testpath/"input.png").size
    assert_equal "100.0000", shell_output("#{bin}/pngdeer input.png --score output.png").strip
  end
end
