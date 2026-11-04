class Slimdeer < Formula
  desc "Smaller PNG and JPEG images, or WebP and AVIF, at an automatic quality"
  homepage "https://github.com/heydeer/slimdeer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/slimdeer-v0.3.1/slimdeer-0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "067fefc24760c5ff023b4e278df308b6b580540fdf6cf71df6480275f9af13e8"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/slimdeer-v0.3.1/slimdeer-0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "24091ca1c5b60ef57a712f240437e282bdb4d2af01f7911dbdba9f081d76146e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/heydeer/homebrew-tap/releases/download/slimdeer-v0.3.1/slimdeer-0.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "edd69de4f1d9605ed6f7e26fec0d557c5e3e73ecf81d773efaf8cc2123b662c7"
    end

    on_intel do
      url "https://github.com/heydeer/homebrew-tap/releases/download/slimdeer-v0.3.1/slimdeer-0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5c1b8d0ba169cefa6b811711e1d86e688c5eb0d83f308855346e406ae2794d05"
    end
  end

  def install
    bin.install "slimdeer"
    # slimdeer was pngdeer until 0.3.0; the old command keeps working for a release
    bin.install_symlink "slimdeer" => "pngdeer"
    prefix.install "LICENSE"
    pkgshare.install "THIRD_PARTY_LICENSES.txt"
  end

  test do
    system bin/"slimdeer", test_fixtures("test.png"), "-o", "input.png", "--upscale", "8"
    system bin/"slimdeer", "input.png", "-o", "output.png", "--target", "85"
    assert_path_exists testpath/"output.png"
    assert_operator (testpath/"output.png").size, :<, (testpath/"input.png").size
    assert_equal "100.0000", shell_output("#{bin}/slimdeer input.png --score output.png").strip
  end
end
