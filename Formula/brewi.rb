class Brewi < Formula
  desc "Interactive Homebrew package management script"
  homepage "https://github.com/marijnbent/homebrew-interactive-install"
  url "https://raw.githubusercontent.com/marijnbent/homebrew-interactive-install/refs/heads/main/brew-interactive.sh"
  version "0.1.0"

  # To get the SHA256:
  # `curl -L "https://raw.githubusercontent.com/marijnbent/homebrew-interactive-install/refs/heads/main/brew-interactive.sh" | shasum -a 256
  sha256 "3f7e48090364be7e1f7dacb9799502282aa6fbb11e70f92cf9ff37070f5b9602"

  depends_on "fzf"

  def install
    bin.install "brew-interactive.sh" => "brewi"
  end

  test do
    assert_predicate bin/"brewi", :exist?
    assert_predicate bin/"brewi", :executable?
  end
end