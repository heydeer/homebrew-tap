# HeyDeer Homebrew Tap

Install slimdeer, which makes PNG and JPEG images smaller, or turns them into WebP and AVIF, at an automatic quality:

```bash
brew install heydeer/tap/slimdeer
slimdeer logo.png photo.jpg       # writes logo.min.png and photo.min.jpg
slimdeer photo.jpg -o photo.avif
```

Prebuilt binaries are available for macOS (Apple Silicon and Intel) and Linux (ARM64 and x86-64).

Upgrade with `brew update && brew upgrade slimdeer`. slimdeer was called pngdeer until 0.3.0. Homebrew's trust doesn't follow a rename, so move an installed pngdeer with `brew trust --formula heydeer/tap/slimdeer && brew upgrade`.

Binary archives include the project and third-party licenses.
