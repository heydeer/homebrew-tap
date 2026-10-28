class Pngdeer < Formula
  desc "Lossy PNG and WebP compression with automatic quality selection"
  homepage "https://github.com/heydeer/pngdeer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.2.1/pngdeer-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "02b256e26059a01925095de3cee202f24ddaed5c3a366cea24e11031d67a02e4"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.2.1/pngdeer-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "dd026d55eb96c738666e24337d5c0624c4fc69864b77167363b02d22cabd8c60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.2.1/pngdeer-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "16571f8521589ce89e0820ad2543b39f5069b80937733f156727cfa57f39c1b0"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.2.1/pngdeer-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "343a3b3cf2818dfb3eada1406ab6fab5deaf834750f7e3da3c99db0367c745c5"
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
