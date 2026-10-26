class Pngdeer < Formula
  desc "Lossy PNG compression with automatic quality selection"
  homepage "https://github.com/heydeer/pngdeer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.2/pngdeer-0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "933ae8eea6bc6523785f71679dd4402d3c0d334ae8b0249de6b526d7405625c2"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.2/pngdeer-0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "ad733849e5fb44ac3826defafb3e18dc0a7afcdb5df2f61afb36a7ef2402861a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.2/pngdeer-0.1.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "25642fe159dfa86184676535350de9a64fb8bee9f390a5dd306bf999381e3c83"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/pngdeer-v0.1.2/pngdeer-0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "718474797dd0f01b11d95c86f0b525ae7a30f97f747cd79c49797fd165743ab8"
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
  end
end
