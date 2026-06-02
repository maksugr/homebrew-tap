class AcpDevtools < Formula
  desc "Visual debugger and inspector for the Agent Client Protocol (ACP)"
  homepage "https://github.com/maksugr/acp-devtools"
  url "https://registry.npmjs.org/acp-devtools/-/acp-devtools-0.1.0.tgz"
  sha256 "91a783f348620dff5ab159440862196c16e06acb9a4f1f97302cd7df6b76ec58"
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
