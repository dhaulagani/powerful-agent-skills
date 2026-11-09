# Universal AI Agent Skill Installer for Windows
# Usage:
#   irm https://raw.githubusercontent.com/dhaulagani/powerful-agent-skills/main/install.ps1 | iex -ArgumentList "all"

param(
    [string]$SkillTarget = "all"
)

$RepoBase = "https://raw.githubusercontent.com/dhaulagani/powerful-agent-skills/main"

# Detect target directory
$Dest = ""
if (Test-Path "$HOME\.gemini\config\skills") {
    $Dest = "$HOME\.gemini\config\skills"
    $AgentName = "Antigravity / Gemini"
} elseif (Test-Path "$HOME\.claude\skills") {
    $Dest = "$HOME\.claude\skills"
    $AgentName = "Claude Code"
} else {
    $Dest = ".\.agents\skills"
    $AgentName = "Local Workspace (.agents\skills)"
}

New-Item -ItemType Directory -Force -Path $Dest | Out-Null
Write-Host "[*] Installing to $AgentName skills directory: $Dest" -ForegroundColor Cyan

function Install-Skill([string]$sid) {
    Write-Host "  -> Downloading skill: $sid..." -ForegroundColor Gray
    $SkillDir = Join-Path $Dest $sid
    New-Item -ItemType Directory -Force -Path $SkillDir | Out-Null
    $Url = "$RepoBase/skills/$sid/SKILL.md"
    $OutFile = Join-Path $SkillDir "SKILL.md"
    try {
        Invoke-WebRequest -Uri $Url -OutFile $OutFile -UseBasicParsing -TimeoutSec 10
    } catch {
        Write-Host "  [!] Warning: Failed to fetch $sid" -ForegroundColor Yellow
    }
}

$AllSkills = @(
    "rea", "matt-pocock-skills", "superpowers", "ecc-context-mode", "deepseek-harness",
    "karpathy-skills", "opencode", "ponytail", "graphify", "orca",
    "claude-mem", "taste-skill", "agent-reach", "impeccable", "voicestudio",
    "archify", "hyperframes", "diagram-design", "gods-eye-view", "security-audit",
    "deeptutor", "hallmark", "t3-code"
)

if ($SkillTarget -eq "all") {
    Write-Host "[*] Installing all 23 trending agent skills..." -ForegroundColor Green
    foreach ($s in $AllSkills) {
        Install-Skill $s
    }
    Write-Host "[✓] All 23 agent skills installed successfully into $Dest!" -ForegroundColor Green
} else {
    Install-Skill $SkillTarget
    Write-Host "[✓] Skill '$SkillTarget' installed successfully into $Dest!" -ForegroundColor Green
}
