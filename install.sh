#!/bin/bash
# SAZ-Mini Global Installer
# Transforms Claude Code into SuperAgent-Zero Mini with intelligent orchestration
# Usage: install.sh [--force]

set -e

# Parse arguments
FORCE_INSTALL=false
if [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
    FORCE_INSTALL=true
fi

# Colors (disabled for non-interactive terminals)
if [[ -t 1 ]] && [[ "$TERM" != "dumb" ]]; then
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    YELLOW='\033[1;33m'
    RED='\033[0;31m'
    BOLD='\033[1m'
    NC='\033[0m'
else
    GREEN=''
    BLUE=''
    YELLOW=''
    RED=''
    BOLD=''
    NC=''
fi

# Error handling
handle_error() {
    echo -e "\n${RED}✗ Installation failed!${NC}"
    echo -e "${RED}Error on line $1${NC}"
    echo -e "Please check the error above and try again."
    echo -e "If the problem persists, create an issue at: https://github.com/Gravicity/SAZ-Mini/issues"
    exit 1
}
trap 'handle_error $LINENO' ERR

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}                    SAZ-Mini Installation${NC}"
echo -e "${BLUE}        ${BOLD}SuperAgent-Zero Mini for Claude Code${NC}${BLUE}${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Pre-installation checks
echo -e "\n${BLUE}Pre-installation checks:${NC}"

# Check if bash is available
if ! command -v bash &> /dev/null; then
    echo -e "${RED}✗${NC} Bash is required but not found"
    exit 1
fi
echo -e "${GREEN}✓${NC} Bash available"

# Check if we can create directories in HOME
if [[ ! -w "$HOME" ]]; then
    echo -e "${RED}✗${NC} Cannot write to home directory: $HOME"
    exit 1
fi
echo -e "${GREEN}✓${NC} Home directory writable"

# Determine if running from curl or local clone
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
TEMP_DIR=""

# Check if we're running from a piped curl command or local directory
if [[ -z "$SCRIPT_DIR" ]] || [[ "$SCRIPT_DIR" == "/tmp" ]] || [[ ! -d "$SCRIPT_DIR/templates" ]]; then
    # Running from curl - need to download framework
    echo -e "${GREEN}✓${NC} Downloading SAZ-Mini framework from GitHub..."
    
    # Create temporary directory
    TEMP_DIR=$(mktemp -d -t saz-mini-install-XXXXXX)
    cd "$TEMP_DIR"
    
    # Download and extract latest release
    if command -v curl &> /dev/null; then
        curl -sSL https://github.com/Gravicity/SAZ-Mini/archive/main.tar.gz | tar xz --strip-components=1
    elif command -v wget &> /dev/null; then
        wget -qO- https://github.com/Gravicity/SAZ-Mini/archive/main.tar.gz | tar xz --strip-components=1
    else
        echo -e "${RED}✗${NC} Neither curl nor wget found. Please install one."
        exit 1
    fi
    
    SCRIPT_DIR="$TEMP_DIR"
    echo -e "${GREEN}✓${NC} Framework downloaded successfully"
else
    # Running from local clone
    echo -e "${GREEN}✓${NC} Installation source: ${BLUE}$SCRIPT_DIR${NC}"
fi

# Validate source files exist
REQUIRED_FILES=("templates" "setup.sh" "update.sh" "packs" "VERSION")
for file in "${REQUIRED_FILES[@]}"; do
    if [[ ! -e "$SCRIPT_DIR/$file" ]]; then
        echo -e "${RED}✗${NC} Missing required file: $file"
        echo -e "  Download may have failed. Please try again."
        [[ -n "$TEMP_DIR" ]] && rm -rf "$TEMP_DIR"
        exit 1
    fi
done
echo -e "${GREEN}✓${NC} All required files present"

# Installation directory
INSTALL_DIR="$HOME/.saz-mini"

# Check for existing installation
if [[ -d "$INSTALL_DIR" ]]; then
    echo -e "\n${YELLOW}Existing installation detected at:${NC} $INSTALL_DIR"
    if [[ -f "$INSTALL_DIR/VERSION" ]]; then
        OLD_VERSION=$(head -n1 "$INSTALL_DIR/VERSION" 2>/dev/null || echo "unknown")
        echo -e "${YELLOW}Current version:${NC} $OLD_VERSION"
    fi
    
    # Check if running non-interactively (e.g., via curl | bash) or with --force
    if [[ ! -t 0 ]] || [[ "$FORCE_INSTALL" == true ]]; then
        echo -e "${YELLOW}Updating installation (preserves custom agents)${NC}"
        if [[ "$FORCE_INSTALL" == true ]]; then
            echo -e "${GREEN}✓${NC} Force flag detected - proceeding with update"
        else
            echo -e "${GREEN}✓${NC} Running in non-interactive mode - proceeding with update"
        fi
    else
        echo -e "${YELLOW}This will update your installation (preserves custom agents)${NC}"
        echo -e "Continue? (y/N) "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            echo "Installation cancelled."
            exit 0
        fi
    fi
    
    # Backup custom agents if they exist
    if [[ -d "$INSTALL_DIR/custom-agents-backup" ]]; then
        echo -e "${YELLOW}→${NC} Preserving existing custom agents backup"
    fi
else
    echo -e "\n${YELLOW}→${NC} Creating installation directory at ${BLUE}$INSTALL_DIR${NC}"
fi

# Create installation directory
mkdir -p "$INSTALL_DIR"

# Copy framework files with validation
echo -e "${YELLOW}→${NC} Installing SAZ-Mini framework..."

# Core templates
if ! cp -r "$SCRIPT_DIR/templates" "$INSTALL_DIR/"; then
    echo -e "${RED}✗${NC} Failed to copy templates"
    exit 1
fi

# Scripts
SCRIPTS=("setup.sh" "update.sh")
for script in "${SCRIPTS[@]}"; do
    if ! cp "$SCRIPT_DIR/$script" "$INSTALL_DIR/"; then
        echo -e "${RED}✗${NC} Failed to copy $script"
        exit 1
    fi
    chmod +x "$INSTALL_DIR/$script"
done

# Copy health check if it exists
if [[ -f "$SCRIPT_DIR/health-check.sh" ]]; then
    cp "$SCRIPT_DIR/health-check.sh" "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/health-check.sh"
fi

# Registry and version
if ! cp -r "$SCRIPT_DIR/packs" "$INSTALL_DIR/"; then
    echo -e "${RED}✗${NC} Failed to copy agent registry"
    exit 1
fi

if ! cp "$SCRIPT_DIR/VERSION" "$INSTALL_DIR/"; then
    echo -e "${RED}✗${NC} Failed to copy version file"
    exit 1
fi

# Validate installation
echo -e "${YELLOW}→${NC} Validating installation..."
NEW_VERSION=$(cat "$INSTALL_DIR/VERSION")

# Count templates (v2.0 has 10 templates)
TEMPLATE_COUNT=$(find "$INSTALL_DIR/templates/agents/patterns" -name "*.md" ! -name "README.md" 2>/dev/null | wc -l | tr -d ' ')
if [[ "$TEMPLATE_COUNT" -ne 10 ]]; then
    echo -e "${RED}✗${NC} Template validation failed - expected 10, found $TEMPLATE_COUNT"
    exit 1
fi

# Count starter agents (v2.0 has 6 starter agents)
STARTER_COUNT=$(find "$INSTALL_DIR/templates/agents/starter" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
if [[ "$STARTER_COUNT" -ne 6 ]]; then
    echo -e "${RED}✗${NC} Starter agent validation failed - expected 6, found $STARTER_COUNT"
    exit 1
fi

# Check registry
if ! python3 -c "import json; json.load(open('$INSTALL_DIR/packs/registry.json'))" 2>/dev/null; then
    echo -e "${YELLOW}⚠${NC} Registry JSON validation skipped (python3 not available)"
fi

echo -e "${GREEN}✓${NC} Installation validated successfully"
echo -e "${GREEN}✓${NC} SAZ-Mini v${NEW_VERSION} installed!"

# Success message
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}${BOLD}        🎉 SAZ-Mini Installation Complete! 🎉${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo -e "\n${BLUE}What's installed:${NC}"
echo -e "  • ${GREEN}6 starter agents${NC} (planner, analyzer, memory-manager, agent-generator, agent-preloader, brainstorming-specialist)"
echo -e "  • ${GREEN}10 production templates${NC} (Next.js, API, Database, UI, Deployment + 5 new v2.0 templates)"
echo -e "  • ${GREEN}Single-manifest orchestration (SSOT)${NC} templates and setup support (manifest lanes/tasks/gates/events)"
echo -e "  • ${GREEN}Health check tool${NC} for troubleshooting"

echo -e "\n${BLUE}Next steps:${NC}"
echo -e "  1. Navigate to your project: ${YELLOW}cd /path/to/your/project${NC}"
echo -e "  2. Run setup: ${YELLOW}~/.saz-mini/setup.sh${NC}"
echo -e "  3. ${BOLD}Activate SuperAgent${NC}: Run ${YELLOW}claude${NC} (or ${YELLOW}/init${NC} if already in Claude Code)"
echo -e "  4. Start with: ${YELLOW}\"What should we work on first?\"${NC}"

echo -e "\n${BLUE}Useful commands:${NC}"
echo -e "  • Health check: ${YELLOW}~/.saz-mini/health-check.sh${NC}"
echo -e "  • Update framework: ${YELLOW}~/.saz-mini/update.sh${NC}"
echo -e "  • Project setup: ${YELLOW}~/.saz-mini/setup.sh --interactive${NC}"

echo -e "\n${GREEN}Ready to transform your development workflow with intelligent AI orchestration!${NC}"

# Cleanup temporary directory if used
if [[ -n "$TEMP_DIR" ]]; then
    rm -rf "$TEMP_DIR"
fi