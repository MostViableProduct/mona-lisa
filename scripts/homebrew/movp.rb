class Movp < Formula
  desc "MoVP control plane plugins for AI coding tools"
  homepage "https://github.com/MostViableProduct/mona-lisa"
  url "https://github.com/MostViableProduct/mona-lisa/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "PLACEHOLDER_UPDATE_ON_FIRST_RELEASE"
  license "MIT"

  depends_on "node@18"

  def install
    # GitHub tarballs extract into a versioned top-level folder
    # (e.g. mona-lisa-1.0.0/). Homebrew auto-strips one level when
    # using `url` with a GitHub archive tarball, so Dir[] paths are
    # relative to the repo root. If this assumption breaks during
    # `brew install --build-from-source`, add:
    #   cd "mona-lisa-#{version}" before the install lines.
    (share/"movp/claude-plugin").install Dir["claude-plugin/*"]
    (share/"movp/codex-plugin").install Dir["codex-plugin/*"]
    (share/"movp/cursor-plugin").install Dir["cursor-plugin/*"]
  end

  def caveats
    <<~EOS
      Plugins installed to: #{share}/movp/

      To set up MoVP in your project:

        cd your-project
        npx @movp/cli init
        claude --plugin-dir #{share}/movp/claude-plugin

      For Cursor:  --plugin-dir #{share}/movp/cursor-plugin
      For Codex:   --plugin-dir #{share}/movp/codex-plugin

      Full docs: https://github.com/MostViableProduct/mona-lisa
    EOS
  end

  test do
    assert_predicate share/"movp/claude-plugin/.claude-plugin/plugin.json", :exist?
    assert_predicate share/"movp/codex-plugin/.codex-plugin/plugin.json", :exist?
    assert_predicate share/"movp/cursor-plugin/.cursor-plugin/plugin.json", :exist?
  end
end
