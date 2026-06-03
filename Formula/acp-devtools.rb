class AcpDevtools < Formula
  desc "Visual debugger and inspector for the Agent Client Protocol (ACP)"
  homepage "https://github.com/maksugr/acp-devtools"
  url "https://registry.npmjs.org/acp-devtools/-/acp-devtools-0.2.0.tgz"
  sha256 "1c92cf7e04dd9e3cca1314046c802c91655c80629d438907d50c3022e9663960"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/acp-devtools --version")
  end
end
