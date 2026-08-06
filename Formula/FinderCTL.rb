class Finderctl < Formula
  include Language::Python::Virtualenv

  desc "Manage macOS Finder preferences safely"
  homepage "https://github.com/azatisakov/FinderCTL"
  url "https://github.com/azatisakov/FinderCTL/archive/v1.0.0.tar.gz"
  sha256 "751585b822223147266d826459876dbe3e783e0fd379bacb417e8a11072492d3"
  license "MIT"

  depends_on "python@3.13"

  resource "click" do
    url "https://files.pythonhosted.org/packages/76/d4/81420972a676e8ffea40450d8c8c92943e7218a78fe9b64359836cc9876b/click-8.4.2.tar.gz"
    sha256 "9a6cea6e60b17ebe0a44c5cc636d94f09bd66142c1cd7d8b4cd731c4917a15f6"
  end

  resource "ds-store" do
    url "https://files.pythonhosted.org/packages/65/88/6b56e5648599959735be58281b15e6955c735b759e475a72236f85e28ffe/ds_store-1.3.3.tar.gz"
    sha256 "a7380896ea1e880f7ba07c5cdc24bd1530fb86836cad0be531f3e80e2d721ac5"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/58/15/8b3609fd3830ef7b27b655beb4b4e9c62313a4e8da8c676e142cc210d58e/shellingham-1.5.4.tar.gz"
    sha256 "8dbca0739d487e5bd35ab3ca4b36e11c4078f3a234bfce294b0a0291363404de"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/ae/40/4a3db7990d1f62a53182aa96eaef57aeb2886a27f90a195bc66713565d31/typer-0.27.1.tar.gz"
    sha256 "a79bef8469a79c45498e7b814ecf8d603cc7644e9acbd9e19cac0334240b18df"
  end

  def install
    venv = virtualenv_create(libexec, "python3.13")
    venv.pip_install_and_link "click==8.4.2", "ds-store==1.3.3", "typer==0.27.1"

    # Install the package itself
    venv.pip_install_and_link path

    # Ensure the CLI wrapper is on PATH
    (bin/"finderctl").unlink if (bin/"finderctl").exist?
    ln_s venv.bin/"finderctl", bin/"finderctl"
  end

  test do
    assert_match "FinderCTL", shell_output("#{bin}/finderctl --version 2>&1")
  end
end
