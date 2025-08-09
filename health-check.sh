#!/bin/bash
# SAZ-Mini Health Check
# Validates framework installation and project setup

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}        SAZ-Mini Health Check${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

ISSUES_FOUND=0

# Check global installation
echo -e "\n${BLUE}Global Installation:${NC}"
if [[ -d "$HOME/.saz-mini" ]]; then
    echo -e "${GREEN}✓${NC} Framework installed"
    
    if [[ -f "$HOME/.saz-mini/VERSION" ]]; then
        VERSION=$(cat "$HOME/.saz-mini/VERSION")
        echo -e "${GREEN}✓${NC} Version: $VERSION"
    else
        echo -e "${YELLOW}⚠${NC} Version file missing"
        ISSUES_FOUND=$((ISSUES_FOUND + 1))
    fi
    
    # Check templates
    TEMPLATE_COUNT=$(find "$HOME/.saz-mini/templates/agents/patterns" -name "*.md" ! -name "README.md" 2>/dev/null | wc -l)
    if [[ $TEMPLATE_COUNT -eq 5 ]]; then
        echo -e "${GREEN}✓${NC} All 5 agent templates present"
    else
        echo -e "${YELLOW}⚠${NC} Expected 5 templates, found $TEMPLATE_COUNT"
        ISSUES_FOUND=$((ISSUES_FOUND + 1))
    fi
else
    echo -e "${RED}✗${NC} SAZ-Mini not installed globally"
    echo -e "  Run: ./install.sh"
    ISSUES_FOUND=$((ISSUES_FOUND + 1))
fi

# Check project setup (if in a project)
echo -e "\n${BLUE}Project Setup:${NC}"
if [[ -f "CLAUDE.md" ]]; then
    echo -e "${GREEN}✓${NC} SuperAgent identity present"
    
    if grep -q "SuperAgent Zero (Mini)" CLAUDE.md; then
        echo -e "${GREEN}✓${NC} Correct SAZ-Mini identity"
    else
        echo -e "${YELLOW}⚠${NC} Unexpected CLAUDE.md content"
        ISSUES_FOUND=$((ISSUES_FOUND + 1))
    fi
else
    echo -e "${YELLOW}○${NC} No CLAUDE.md (not a SAZ-Mini project)"
fi

if [[ -d ".saz" ]]; then
    echo -e "${GREEN}✓${NC} Memory system present"
    
    # Check memory files
    MEMORY_FILES=(".saz/memory/project.md" ".saz/memory/insights.md" ".saz/memory/workflows.md")
    for file in "${MEMORY_FILES[@]}"; do
        if [[ -f "$file" ]]; then
            echo -e "${GREEN}  ✓${NC} $(basename "$file")"
        else
            echo -e "${RED}  ✗${NC} Missing $(basename "$file")"
            ISSUES_FOUND=$((ISSUES_FOUND + 1))
        fi
    done
else
    echo -e "${YELLOW}○${NC} No .saz directory (not a SAZ-Mini project)"
fi

if [[ -d ".claude/agents" ]]; then
    AGENT_COUNT=$(find .claude/agents -name "*.md" 2>/dev/null | wc -l)
    echo -e "${GREEN}✓${NC} Agent directory present ($AGENT_COUNT agents)"
else
    echo -e "${YELLOW}○${NC} No .claude/agents directory"
fi

# Summary
echo -e "\n${BLUE}Summary:${NC}"
if [[ $ISSUES_FOUND -eq 0 ]]; then
    echo -e "${GREEN}✓${NC} No issues found - SAZ-Mini is healthy!"
else
    echo -e "${YELLOW}⚠${NC} Found $ISSUES_FOUND issue(s) - see above for details"
fi

echo -e "\n${BLUE}Quick Fix Commands:${NC}"
echo -e "  Global install:   ${YELLOW}~/.saz-mini/install.sh${NC}"
echo -e "  Project setup:    ${YELLOW}~/.saz-mini/setup.sh${NC}"
echo -e "  Interactive setup: ${YELLOW}~/.saz-mini/setup.sh --interactive${NC}"

exit $ISSUES_FOUND