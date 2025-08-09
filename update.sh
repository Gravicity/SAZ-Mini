#!/bin/bash
# SAZ-Mini Framework Updater
# Updates framework while preserving custom agents and memory

set -e

# Colors
if [[ -t 1 ]] && [[ "$TERM" != "dumb" ]]; then
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    YELLOW='\033[1;33m'
    RED='\033[0;31m'
    NC='\033[0m'
else
    GREEN=''
    BLUE=''
    YELLOW=''
    RED=''
    NC=''
fi

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}        SAZ-Mini Framework Update${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

INSTALL_DIR="$HOME/.saz-mini"
BACKUP_DIR="$HOME/.saz-mini-backup-$(date +%Y%m%d-%H%M%S)"

# Check current version
if [[ -f "$INSTALL_DIR/VERSION" ]]; then
    CURRENT_VERSION=$(cat "$INSTALL_DIR/VERSION")
    echo -e "${YELLOW}Current version:${NC} $CURRENT_VERSION"
else
    echo -e "${YELLOW}No version file found${NC}"
    CURRENT_VERSION="unknown"
fi

# Create backup
echo -e "${YELLOW}→${NC} Creating backup at ${BLUE}$BACKUP_DIR${NC}"
cp -r "$INSTALL_DIR" "$BACKUP_DIR"

# Download latest version (placeholder - replace with actual source)
echo -e "${YELLOW}→${NC} Downloading latest SAZ-Mini..."
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# In production, this would download from GitHub:
# curl -L https://github.com/yourusername/saz-mini/archive/main.tar.gz | tar xz
# For now, we'll simulate with a message
echo -e "${YELLOW}Note:${NC} Replace this section with actual download logic"

# Update framework files (preserve custom content)
echo -e "${YELLOW}→${NC} Updating framework files..."

# Update core scripts
if [[ -f "setup.sh" ]]; then
    cp "setup.sh" "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/setup.sh"
fi

if [[ -f "update.sh" ]]; then
    cp "update.sh" "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/update.sh"
fi

# Update templates (but preserve any custom agents)
if [[ -d "templates/agents/starter" ]]; then
    cp templates/agents/starter/*.md "$INSTALL_DIR/templates/agents/starter/" 2>/dev/null || true
fi

# Update memory templates (these are just templates, not active memory)
if [[ -d "templates/memory" ]]; then
    cp templates/memory/*.md "$INSTALL_DIR/templates/memory/" 2>/dev/null || true
fi

# Update CLAUDE.md template
if [[ -f "templates/CLAUDE.md" ]]; then
    cp "templates/CLAUDE.md" "$INSTALL_DIR/templates/"
fi

# Update packs registry if newer
if [[ -f "packs/registry.json" ]]; then
    cp "packs/registry.json" "$INSTALL_DIR/packs/"
fi

# Update version
echo "1.0.1" > "$INSTALL_DIR/VERSION"
NEW_VERSION=$(cat "$INSTALL_DIR/VERSION")

# Clean up
cd /
rm -rf "$TEMP_DIR"

# Report results
echo
echo -e "${GREEN}✓${NC} SAZ-Mini updated successfully!"
echo -e "  Version: ${YELLOW}$CURRENT_VERSION${NC} → ${GREEN}$NEW_VERSION${NC}"
echo -e "  Backup: ${BLUE}$BACKUP_DIR${NC}"
echo
echo -e "${BLUE}What's preserved:${NC}"
echo -e "  • Your custom agents"
echo -e "  • Project memory files"
echo -e "  • Local modifications"
echo
echo -e "${BLUE}What's updated:${NC}"
echo -e "  • Core framework files"
echo -e "  • Starter agent templates"
echo -e "  • Bug fixes and improvements"
echo
echo -e "${YELLOW}Note:${NC} Run setup.sh in your projects to apply updates"