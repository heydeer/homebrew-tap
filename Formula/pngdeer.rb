class Pngdeer < Formula
  desc "Lossy PNG and WebP compression with automatic quality selection"
  homepage "https://github.com/heydeer/pngdeer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.2.0/pngdeer-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "5e1745e08232d60a6050c611ed57521b8d0352e7f3a43d60d5ae2b4a79c073b8"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.2.0/pngdeer-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "5324df85d4b891b59f3f830ea68c03b4fb5157bc4591d10436854daf39c7d4f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.2.0/pngdeer-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "475b0e2661f1e22f2056743fc02e278f2a99aa79e6823bab17d3b759b802ac2e"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.2.0/pngdeer-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "43fec61382c9a389f47d07de8e5d309319fbbd40bb7ba254a2a09d6e2e70e966"
    end
  end

  def install
    bin.install "pngdeer"
    prefix.install "LICENSE"
    pkgshare.install "THIRD_PARTY_LICENSES.txt"
  end

  test do
    system bin/"pngdeer", test_fixtures("test.png"), "-o", "input.png", "--upscale", "8"
    system bin/"pngdeer", "input.png", "-o", "output.png", "--target", "85"
    assert_path_exists testpath/"output.png"
    assert_operator (testpath/"output.png").size, :<, (testpath/"input.png").size
    assert_equal "100.0000", shell_output("#{bin}/pngdeer input.png --score output.png").strip
    system bin/"pngdeer", "input.png", "-o", "output.webp"
    assert_equal "RIFF", File.binread(testpath/"output.webp", 4)
  end
end
