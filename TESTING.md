# SAZ-Mini Testing Guide

**Complete test scenarios to validate the framework before release.**

## 🧪 Test Scenarios

### 1. Fresh Installation Test
```bash
# Test global installation
./install.sh

# Expected: 
# - Framework installed to ~/.saz-mini/
# - 4 starter agents, 5 templates available
# - Health check executable
# - Success message with next steps

# Validation:
~/.saz-mini/health-check.sh
```

### 2. Project Setup Test
```bash
# Test in empty directory
mkdir test-empty && cd test-empty
~/.saz-mini/setup.sh

# Test in existing project
cd /existing/project
~/.saz-mini/setup.sh --interactive

# Expected:
# - CLAUDE.md installed or handled appropriately
# - .saz/memory/ created with templates
# - .claude/agents/starter/ with 4 agents
# - Registry initialized
# - All validation checks pass
```

### 3. SuperAgent Activation Test
```bash
# After setup, restart Claude Code:
# Ctrl+C twice, then: claude --resume

# Test SuperAgent responses:
# - "What should we work on first?"
# - "Help me build a SaaS dashboard"
# - "Analyze this project for improvements"

# Expected:
# - SuperAgent-Zero Mini identity active
# - Appropriate starter agent deployed
# - Memory files updated
# - Clear next steps provided
```

### 4. Agent Generation Test
```bash
# Test template-based generation
# Ask SuperAgent: "I need a Stripe payment integration"

# Expected:
# - Checks existing templates first
# - Finds api-integration-specialist
# - Customizes for Stripe
# - Saves to .claude/agents/custom/
# - Updates registry.json
# - Provides restart instructions
```

### 5. Workflow Execution Test
```bash
# Test new-saas-app workflow
# Ask SuperAgent: "I want to build a multi-tenant SaaS dashboard"

# Expected:
# - project-planner researches templates
# - Finds Next.js SaaS starters
# - Creates comprehensive roadmap
# - Recommends agent sequence
# - Documents in memory files
```

### 6. Error Recovery Test
```bash
# Test missing framework
rm -rf ~/.saz-mini
~/.saz-mini/setup.sh
# Expected: Clear error message

# Test corrupted registry
echo "invalid json" > .saz/packs/registry.json
# SuperAgent should handle gracefully

# Test missing agents
rm .claude/agents/starter/project-planner.md
# SuperAgent should detect and recommend reinstall
```

### 7. Health Check Test
```bash
# Test comprehensive validation
~/.saz-mini/health-check.sh

# Expected:
# - Checks global installation
# - Validates project setup
# - Counts templates and agents
# - Reports issues with solutions
# - Exit code 0 if healthy
```

### 8. Update Test
```bash
# Test framework update
~/.saz-mini/update.sh

# Expected:
# - Preserves custom agents
# - Updates core templates
# - Maintains project memory
# - Success confirmation
```

## ✅ Success Criteria

### Installation Success
- [ ] `~/.saz-mini/` created with all files
- [ ] 4 starter agents present
- [ ] 5 templates available
- [ ] Health check passes
- [ ] Scripts executable

### Project Setup Success
- [ ] CLAUDE.md installed/handled properly
- [ ] Memory system initialized
- [ ] Agents copied to `.claude/agents/starter/`
- [ ] Registry configured
- [ ] Git patterns added (if .gitignore exists)
- [ ] All validation checks pass

### SuperAgent Activation Success
- [ ] Identity loads after restart
- [ ] Responds to initial queries
- [ ] Deploys appropriate starter agents
- [ ] Updates memory files
- [ ] Provides clear guidance

### Agent Generation Success
- [ ] Template-first approach works
- [ ] Customization successful
- [ ] Registry updated
- [ ] Restart instructions clear
- [ ] Generated agent functional

### Workflow Success
- [ ] Research-driven planning
- [ ] Template recommendations
- [ ] Agent sequence logical
- [ ] Memory documentation complete
- [ ] Next steps actionable

## 🚨 Critical Tests

**Must Pass Before Release:**
1. **Fresh install on clean system**
2. **SuperAgent activation after restart**  
3. **Template-based agent generation**
4. **Error recovery scenarios**
5. **Health check comprehensive validation**

## 🐛 Known Issues to Test

- [ ] Terminal color compatibility (Cursor/VSCode)
- [ ] Registry JSON validation 
- [ ] File permission issues
- [ ] Path resolution on different systems
- [ ] Agent restart requirements

## 📊 Performance Targets

- **Installation**: < 30 seconds
- **Setup**: < 60 seconds  
- **Agent generation**: < 2 minutes
- **Health check**: < 10 seconds
- **Memory file size**: < 50KB total

## 🎯 User Experience Goals

- **Zero configuration** for common cases
- **Clear error messages** with solutions
- **Restart requirements** well communicated  
- **Success indicators** visible throughout
- **Recovery paths** available for all failures

---

**Ready for comprehensive testing and validation!** 🚀