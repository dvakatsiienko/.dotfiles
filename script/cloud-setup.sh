#!/bin/bash
# Cloud environment setup: put Node 24 on PATH before Claude Code launches.
#
# The image ships Node 22 (/opt/node22); package.json engines wants >=24, and
# pnpm only warns about the mismatch instead of failing.
#
# No `set -e`: a setup script that aborts leaves the session with no Node at all.
# Every step degrades instead, and the script reports what it ended up with.

NODE_VERSION=24
FNM_DIR="$HOME/.local/share/fnm"
BIN="$HOME/.local/bin"
export FNM_DIR
mkdir -p "$BIN" "$FNM_DIR"

log() { printf '[setup] %s\n' "$*"; }

# Check the symlink this script controls, not whatever `node` currently
# resolves to — PATH in *this* shell says nothing about the session's PATH.
have_node_24() {
  [ -x "$BIN/node" ] &&
    [ "$("$BIN/node" -p 'process.versions.node.split(".")[0]' 2>/dev/null)" = "$NODE_VERSION" ]
}

# ---------------------------------------------------------------- fnm binary
# fnm.vercel.app (the documented installer) is 403 under Trusted network
# access. These are the reachable routes, cheapest first.
install_fnm() {
  [ -x "$BIN/fnm" ] && return 0

  # GitHub releases. Arch matters: the x64 and arm64 assets have different names.
  case "$(uname -m)" in
    x86_64) asset=fnm-linux.zip ;;
    aarch64 | arm64) asset=fnm-arm64.zip ;;
    *) asset= ;;
  esac

  if [ -n "$asset" ] && command -v curl >/dev/null && command -v unzip >/dev/null; then
    tmp=$(mktemp -d)
    if curl -fsSL --retry 3 --retry-delay 2 --connect-timeout 20 \
      -o "$tmp/fnm.zip" \
      "https://github.com/Schniz/fnm/releases/latest/download/$asset" &&
      unzip -oq "$tmp/fnm.zip" -d "$tmp" &&
      install -m755 "$tmp/fnm" "$BIN/fnm" 2>/dev/null; then
      rm -rf "$tmp"
      log "fnm from GitHub release"
      return 0
    fi
    rm -rf "$tmp"
    log "GitHub release route failed"
  fi

  # crates.io is reachable directly (not via the proxy allowlist). Slow to
  # compile, but it does not depend on release-asset naming holding still.
  if command -v cargo >/dev/null 2>&1; then
    log "falling back to cargo install fnm (slow)"
    cargo install fnm --root "$HOME/.local" --quiet 2>/dev/null && return 0
    log "cargo route failed"
  fi

  return 1
}

# ------------------------------------------------------------------ install
if install_fnm; then
  "$BIN/fnm" install "$NODE_VERSION" 2>&1 | tail -1
  "$BIN/fnm" alias "$NODE_VERSION" default >/dev/null 2>&1

  # The setup script runs in its own shell; a bare `fnm use` dies with it and
  # Claude Code still launches on Node 22. Symlinks in ~/.local/bin persist,
  # and that directory already precedes /opt/node22/bin on PATH.
  node_bin=$(ls -d "$FNM_DIR"/node-versions/v"$NODE_VERSION".*/installation/bin 2>/dev/null | sort -V | tail -1)
  if [ -n "$node_bin" ] && [ -x "$node_bin/node" ]; then
    for b in node npm npx; do
      [ -e "$node_bin/$b" ] && ln -sf "$node_bin/$b" "$BIN/$b"
    done
  fi
fi

# nvm ships in the image at /opt/nvm. Last resort, and it needs no network of
# its own beyond nodejs.org, which Trusted allows.
if ! have_node_24; then
  log "fnm route did not yield Node $NODE_VERSION, trying nvm"
  export NVM_DIR=/opt/nvm
  # shellcheck disable=SC1091
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" &&
    nvm install "$NODE_VERSION" >/dev/null 2>&1 &&
    node_bin=$(dirname "$(nvm which "$NODE_VERSION" 2>/dev/null)") &&
    [ -x "$node_bin/node" ] &&
    for b in node npm npx; do
      [ -e "$node_bin/$b" ] && ln -sf "$node_bin/$b" "$BIN/$b"
    done
fi

# ~/.local/bin leading PATH is what makes the symlinks win. If the image ever
# reorders PATH, fall back to writing it into the shell profile.
case ":$PATH:" in
  *":$BIN:"*) ;;
  *)
    log "$BIN not on PATH, appending to profile"
    printf '\nexport PATH="%s:$PATH"\n' "$BIN" >>"$HOME/.bashrc"
    printf '\nexport PATH="%s:$PATH"\n' "$BIN" >>"$HOME/.zshrc" 2>/dev/null
    ;;
esac

corepack enable >/dev/null 2>&1

# Never fail the session over this: report and let CI catch a wrong runtime.
if have_node_24; then
  log "node $("$BIN/node" --version) at $BIN/node"
else
  log "WARNING: wanted Node $NODE_VERSION, got $(node --version 2>/dev/null || echo none)"
fi
exit 0
