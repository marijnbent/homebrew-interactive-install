class Brewi < Formula
  desc "Interactive Homebrew package management script"
  homepage "https://github.com/marijnbent/homebrew-interactive-install"
  url "https://raw.githubusercontent.com/marijnbent/homebrew-interactive-install/refs/heads/main/brew-interactive.sh"
  version "0.1.2"

  # To get the SHA256:
  # `curl -L "https://raw.githubusercontent.com/marijnbent/homebrew-interactive-install/refs/heads/main/brew-interactive.sh" | shasum -a 256
  sha256 "d828a1c2b2ad26e9eb6869a255b4068cab8a85efeda2d995f540ef05c3b9140a"

  depends_on "fzf"

  def install
    bin.install "brew-interactive.sh" => "brewi"
    chmod 0755, bin/"brewi" 
  end

  test depends_on 
    assert_predicate bin/"brewi", :exist?
    assert_predicate bin/"brewi", :executable?
  end
end