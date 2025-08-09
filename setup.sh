#!/bin/bash
# SAZ-Mini Project Setup  
# Transforms any project into a SuperAgent-Zero Mini workspace
# Non-interactive by default, --interactive for prompts

set -e

# Parse arguments
INTERACTIVE=false
FORCE=false
for arg in "$@"; do
    case "$arg" in
        --interactive) INTERACTIVE=true ;;
        --force) FORCE=true ;;
        --help)
            echo "SAZ-Mini Project Setup"
            echo
            echo "Usage: $0 [OPTIONS]"
            echo
            echo "Options:"
            echo "  --interactive    Prompt for user choices"
            echo "  --force         Overwrite existing files without prompting" 
            echo "  --help          Show this help message"
            echo
            echo "Examples:"
            echo "  $0                      # Silent setup with defaults"
            echo "  $0 --interactive        # Prompt for all choices"
            echo "  $0 --force             # Overwrite existing setup"
            exit 0
            ;;
    esac
done

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
    echo -e "\n${RED}✗ Setup failed!${NC}"
    echo -e "${RED}Error on line $1${NC}"
    echo -e "Check the error above and try running with --interactive for more control."
    exit 1
}
trap 'handle_error $LINENO' ERR

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}                    SAZ-Mini Project Setup${NC}" 
echo -e "${BLUE}        ${BOLD}Transform this project with AI orchestration${NC}${BLUE}${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Pre-setup analysis
echo -e "\n${BLUE}Project Analysis:${NC}"

# Detect project type
PROJECT_TYPE="Unknown"
if [[ -f "package.json" ]]; then
    if grep -q "next" package.json 2>/dev/null; then
        PROJECT_TYPE="Next.js"
    elif grep -q "react" package.json 2>/dev/null; then
        PROJECT_TYPE="React"
    elif grep -q "vue" package.json 2>/dev/null; then
        PROJECT_TYPE="Vue.js"
    else
        PROJECT_TYPE="Node.js"
    fi
elif [[ -f "requirements.txt" ]] || [[ -f "pyproject.toml" ]]; then
    PROJECT_TYPE="Python"
elif [[ -f "Cargo.toml" ]]; then
    PROJECT_TYPE="Rust"
elif [[ -f "go.mod" ]]; then
    PROJECT_TYPE="Go"
elif [[ -f "composer.json" ]]; then
    PROJECT_TYPE="PHP"
fi

echo -e "${GREEN}✓${NC} Project type: ${YELLOW}$PROJECT_TYPE${NC}"

# Check git repository
if [[ -d ".git" ]]; then
    echo -e "${GREEN}✓${NC} Git repository detected"
else
    echo -e "${YELLOW}○${NC} Not a git repository"
    if [[ "$INTERACTIVE" == true ]]; then
        echo -e "${YELLOW}Warning:${NC} Not in a git repository. Continue anyway? (y/N)"
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            echo "Setup cancelled."
            exit 0
        fi
    fi
fi

# Check directory permissions
if [[ ! -w "." ]]; then
    echo -e "${RED}✗${NC} Cannot write to current directory"
    exit 1
fi
echo -e "${GREEN}✓${NC} Directory writable"

# Source directory (where templates are)
SOURCE_DIR="$HOME/.saz-mini"
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo -e "${RED}Error:${NC} SAZ-Mini not installed. Run install.sh first."
    exit 1
fi

# Check version compatibility
if [[ -f "$SOURCE_DIR/VERSION" ]]; then
    FRAMEWORK_VERSION=$(cat "$SOURCE_DIR/VERSION")
    echo -e "${BLUE}Using SAZ-Mini version:${NC} $FRAMEWORK_VERSION"
else
    echo -e "${YELLOW}Warning:${NC} Could not determine framework version"
fi

# Handle existing CLAUDE.md
if [[ -f "CLAUDE.md" ]]; then
    echo -e "${YELLOW}Found existing CLAUDE.md${NC}"
    
    if [[ "$INTERACTIVE" == true ]]; then
        echo "Options:"
        echo "  1) Backup existing and install SAZ-Mini"
        echo "  2) Append SAZ-Mini to existing"
        echo "  3) Skip CLAUDE.md installation"
        echo -n "Choice (1-3): "
        read -r choice
    else
        choice="1"  # Default: backup
    fi
    
    case "$choice" in
        1)
            echo -e "${YELLOW}→${NC} Backing up existing CLAUDE.md to CLAUDE.md.backup"
            cp CLAUDE.md CLAUDE.md.backup
            cp "$SOURCE_DIR/templates/CLAUDE.md" CLAUDE.md
            ;;
        2)
            echo -e "${YELLOW}→${NC} Appending SAZ-Mini to existing CLAUDE.md"
            echo -e "\n\n# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >> CLAUDE.md
            cat "$SOURCE_DIR/templates/CLAUDE.md" >> CLAUDE.md
            ;;
        3)
            echo -e "${YELLOW}→${NC} Skipping CLAUDE.md installation"
            ;;
        *)
            echo -e "${YELLOW}→${NC} Backing up existing CLAUDE.md to CLAUDE.md.backup"
            cp CLAUDE.md CLAUDE.md.backup
            cp "$SOURCE_DIR/templates/CLAUDE.md" CLAUDE.md
            ;;
    esac
else
    echo -e "${YELLOW}→${NC} Installing CLAUDE.md"
    cp "$SOURCE_DIR/templates/CLAUDE.md" CLAUDE.md
fi

# Install memory system
echo -e "${YELLOW}→${NC} Setting up memory system in .saz/"
mkdir -p .saz/memory
cp "$SOURCE_DIR/templates/memory/project.md" .saz/memory/ 2>/dev/null || true
cp "$SOURCE_DIR/templates/memory/insights.md" .saz/memory/ 2>/dev/null || true
cp "$SOURCE_DIR/templates/memory/workflows.md" .saz/memory/ 2>/dev/null || true

# Install starter agents
echo -e "${YELLOW}→${NC} Installing starter agents in .claude/agents/"
mkdir -p .claude/agents/starter
cp "$SOURCE_DIR/templates/agents/starter/project-analyzer.md" .claude/agents/starter/ 2>/dev/null || true
cp "$SOURCE_DIR/templates/agents/starter/project-planner.md" .claude/agents/starter/ 2>/dev/null || true
cp "$SOURCE_DIR/templates/agents/starter/memory-manager.md" .claude/agents/starter/ 2>/dev/null || true
cp "$SOURCE_DIR/templates/agents/starter/agent-generator.md" .claude/agents/starter/ 2>/dev/null || true

# Create packs directory
echo -e "${YELLOW}→${NC} Setting up packs registry"
mkdir -p .saz/packs
if [[ -f "$SOURCE_DIR/packs/registry.json" ]]; then
    cp "$SOURCE_DIR/packs/registry.json" .saz/packs/
fi

# Project type detection
if [[ -f "package.json" ]]; then
    PROJECT_TYPE="Node.js/JavaScript"
elif [[ -f "requirements.txt" ]] || [[ -f "pyproject.toml" ]]; then
    PROJECT_TYPE="Python"
elif [[ -f "Cargo.toml" ]]; then
    PROJECT_TYPE="Rust"
elif [[ -f "go.mod" ]]; then
    PROJECT_TYPE="Go"
else
    PROJECT_TYPE="Unknown"
fi

# Success message
echo
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}${BOLD}        🎉 SAZ-Mini Project Setup Complete! 🎉${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo -e "\n${BLUE}Your ${YELLOW}${PROJECT_TYPE}${NC}${BLUE} project is now SAZ-Mini enabled!${NC}"

echo -e "\n${BLUE}What's ready:${NC}"
echo -e "  • ${GREEN}SuperAgent-Zero Mini v2.0 identity${NC} in CLAUDE.md"
echo -e "  • ${GREEN}5 starter agents${NC} in .claude/agents/starter/"
echo -e "  • ${GREEN}10 production templates${NC} available for generation"  
echo -e "  • ${GREEN}Memory system${NC} in .saz/memory/"
echo -e "  • ${GREEN}Agent registry${NC} tracking dependencies"

echo -e "\n${BLUE}Starter Agents Installed:${NC}"
echo -e "  • ${YELLOW}project-analyzer${NC} - Analyzes existing codebases"
echo -e "  • ${YELLOW}project-planner${NC} - Plans new implementations"
echo -e "  • ${YELLOW}memory-manager${NC} - RAG search and complex handoffs"
echo -e "  • ${YELLOW}agent-generator${NC} - Creates fit-for-purpose agents"
echo -e "  • ${YELLOW}agent-preloader${NC} - Hot-loading and background preparation"

echo -e "\n${BLUE}Critical next step:${NC}"
echo -e "  ${BOLD}${RED}Activate SuperAgent-Zero Mini:${NC}"
echo -e "  ${YELLOW}Option 1:${NC} Start fresh Claude Code session"
echo -e "    - Exit Claude Code (Ctrl+C twice)"
echo -e "    - Run: ${GREEN}claude${NC}"
echo -e "  ${YELLOW}Option 2:${NC} If already in Claude Code"
echo -e "    - Type: ${GREEN}/init${NC}"

echo -e "\n${BLUE}Once activated, try:${NC}"
echo -e "  ${YELLOW}\"What should we work on first?\"${NC}"
echo -e "  ${YELLOW}\"Help me build a [describe your project]\"${NC}"
echo -e "  ${YELLOW}\"Analyze this codebase for improvements\"${NC}"

# Create a setup marker
echo "$(date): SAZ-Mini v1.0.0 installed" > .saz/.installed

# Add SAZ-Mini patterns to .gitignore if it exists
if [[ -f ".gitignore" ]]; then
    if ! grep -q ".saz/memory/\*.local.md" .gitignore 2>/dev/null; then
        echo -e "\n# SAZ-Mini patterns" >> .gitignore
        echo ".saz/memory/*.local.md" >> .gitignore
        echo ".saz/context/" >> .gitignore
        echo ".saz/.installed" >> .gitignore
        echo ".saz/notes.md" >> .gitignore
        echo -e "${YELLOW}→${NC} Added SAZ-Mini patterns to .gitignore"
    fi
fi

# Validation
echo
echo -e "${BLUE}Running setup validation...${NC}"
VALIDATION_PASSED=true

# Check CLAUDE.md
if [[ -f "CLAUDE.md" ]]; then
    echo -e "${GREEN}✓${NC} SuperAgent identity installed"
else
    echo -e "${RED}✗${NC} CLAUDE.md missing"
    VALIDATION_PASSED=false
fi

# Check memory system
if [[ -d ".saz/memory" ]]; then
    echo -e "${GREEN}✓${NC} Memory system ready"
else
    echo -e "${RED}✗${NC} Memory directory missing"
    VALIDATION_PASSED=false
fi

# Check starter agents (v2.0 has 5 starter agents)
AGENT_COUNT=$(find .claude/agents/starter -name "*.md" 2>/dev/null | wc -l)
if [[ $AGENT_COUNT -eq 5 ]]; then
    echo -e "${GREEN}✓${NC} All 5 starter agents installed"
else
    echo -e "${RED}✗${NC} Expected 5 starter agents, found $AGENT_COUNT"
    VALIDATION_PASSED=false
fi

# Check registry
if [[ -f ".saz/packs/registry.json" ]]; then
    echo -e "${GREEN}✓${NC} Agent registry initialized"
else
    echo -e "${RED}✗${NC} Registry missing"
    VALIDATION_PASSED=false
fi

if [[ "$VALIDATION_PASSED" == true ]]; then
    echo -e "${GREEN}✓${NC} All validation checks passed!"
    echo -e "\n${GREEN}🚀 Welcome to intelligent AI orchestration with SAZ-Mini!${NC}"
else
    echo -e "${YELLOW}⚠${NC}  Some validation checks failed. Setup may be incomplete."
    echo -e "\n${YELLOW}Run health check for detailed diagnosis:${NC}"
    echo -e "  ${YELLOW}~/.saz-mini/health-check.sh${NC}"
fi

# Final activation instructions
echo -e "\n${BLUE}Critical next step:${NC}"
echo -e "  ${BOLD}Activate SuperAgent-Zero Mini:${NC}"
echo -e "  ${YELLOW}1.${NC} Exit Claude Code (Ctrl+C twice) if running"
echo -e "  ${YELLOW}2.${NC} Start fresh: ${GREEN}claude${NC}"
echo -e "  ${YELLOW}3.${NC} Or if already in Claude Code: ${GREEN}/init${NC}"
echo -e "\n${BLUE}Once activated, try:${NC}"
echo -e "  ${YELLOW}\"What should we work on first?\"${NC}"