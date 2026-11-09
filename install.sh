#!/usr/bin/env bash
# Universal AI Agent Skill Installer
# Usage:
#   curl -sSL https://raw.githubusercontent.com/dhaulagani/powerful-agent-skills/main/install.sh | bash -s <skill-id|all>

set -e

SKILL_TARGET="${1:-all}"
REPO_BASE="https://raw.githubusercontent.com/dhaulagani/powerful-agent-skills/main"

# Detect target skills directory
if [ -d "$HOME/.gemini/config/skills" ]; then
    DEST="$HOME/.gemini/config/skills"
    AGENT="Antigravity / Gemini"
elif [ -d "$HOME/.claude/skills" ]; then
    DEST="$HOME/.claude/skills"
    AGENT="Claude Code"
elif [ -d "$HOME/.cursor/skills" ]; then
    DEST="$HOME/.cursor/skills"
    AGENT="Cursor"
else
    DEST="./.agents/skills"
    AGENT="Local Workspace (.agents/skills)"
fi

mkdir -p "$DEST"
echo "[*] Installing to $AGENT skills directory: $DEST"

install_single_skill() {
    local sid="$1"
    echo "  -> Downloading skill: $sid..."
    mkdir -p "$DEST/$sid"
    curl -fsSL "$REPO_BASE/skills/$sid/SKILL.md" -o "$DEST/$sid/SKILL.md" || {
        echo "  [!] Warning: failed to fetch SKILL.md for $sid"
    }
}

ALL_SKILLS=(
    "rea" "matt-pocock-skills" "superpowers" "ecc-context-mode" "deepseek-harness"
    "karpathy-skills" "opencode" "ponytail" "graphify" "orca"
    "claude-mem" "taste-skill" "agent-reach" "impeccable" "voicestudio"
    "archify" "hyperframes" "diagram-design" "gods-eye-view" "security-audit"
    "deeptutor" "hallmark" "t3-code"
)

if [ "$SKILL_TARGET" = "all" ]; then
    echo "[*] Installing all 23 trending agent skills..."
    for s in "${ALL_SKILLS[@]}"; do
        install_single_skill "$s"
    done
    echo "[✓] Successfully installed all 23 agent skills into $DEST!"
else
    install_single_skill "$SKILL_TARGET"
    echo "[✓] Successfully installed skill '$SKILL_TARGET' into $DEST!"
fi
