class Pngdeer < Formula
  desc "Lossy PNG compression with automatic quality selection"
  homepage "https://github.com/heydeer/homebrew-tap"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.1/pngdeer-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "ec8d53fd37d22a257ac58d481e675577c09fe0add12cc3035b747f8abe7d91da"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.1/pngdeer-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "e837fd81cdfe775cc87e56a4f995c21ec8052ee888cc324a0393c15d91e9f982"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.1/pngdeer-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "593e4fec96bcffbdaf2e3e53f4bc541188365a5b57eb03d754de545ce324a675"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.1/pngdeer-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3320e36a384d7b9f728574dde8c23cc8096d40a39f592d4d28682f71a39b8e01"
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
