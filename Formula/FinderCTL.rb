class Finderctl < Formula
  include Language::Python::Virtualenv

  desc "Manage macOS Finder preferences safely"
  homepage "https://github.com/azatisakov/FinderCTL"
  url "https://github.com/azatisakov/FinderCTL/archive/v1.0.0.tar.gz"
  sha256 "b6985ff01c51e3385bafb206059eb1d2517ce3e62a3ff6c225bc2148e0ad23bd"
  license "MIT"

  depends_on "python@3.13"

  def install
    venv = virtualenv_create(libexec)
    venv.pip_install_and_link "typer>=0.12", "ds-store>=1.3", "click>=8.2.1", "shellingham>=1.5.4"

    venv.pip_install_and_link path

    (bin/"finderctl").unlink if (bin/"finderctl").exist?
    ln_s venv.bin/"finderctl", bin/"finderctl"
  end

  test do
    assert_match "FinderCTL", shell_output("#{bin}/finderctl --version 2>&1")
  end
end
