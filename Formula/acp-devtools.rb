class AcpDevtools < Formula
  desc "Visual debugger and inspector for the Agent Client Protocol (ACP)"
  homepage "https://github.com/maksugr/acp-devtools"
  url "https://registry.npmjs.org/acp-devtools/-/acp-devtools-0.6.1.tgz"
  sha256 "1b2cd0b4d6c0d781e1d681d8bc09aba672484c950fd835c5493eb225fb66cf49"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    # `std_npm_args` runs `npm install` with `--ignore-scripts`, which is
    # safe for pure-JS packages but skips `better-sqlite3`'s postinstall —
    # the step that fetches a prebuilt binding for the local Node ABI (or
    # falls back to a node-gyp source build). Without it, every command
    # fails with "Could not locate the bindings file". Rebuild explicitly
    # so the binding is in place before the symlink lands in `bin`.
    cd libexec/"lib/node_modules/acp-devtools" do
      system "npm", "rebuild", "better-sqlite3"
    end
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # `--version` only proves the binary runs — it does not touch the
    # native binding, so it would happily pass even when better-sqlite3
    # is broken (the regression that shipped in 0.2.0). `doctor` opens
    # captures.db, which calls `new Database()`; that load fails fast
    # if the binding is missing or ABI-incompatible.
    assert_match version.to_s, shell_output("#{bin}/acp-devtools --version")
    ENV["ACP_DEVTOOLS_HOME"] = testpath/"home"
    system bin/"acp-devtools", "doctor"
  end
end
