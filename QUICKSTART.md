# SAZ-Mini Quick Start

**Transform your development with intelligent AI orchestration in under 5 minutes.**

## ⚡ Installation (2 minutes)

### Quick Install (One-liner)
```bash
# Install SAZ-Mini globally
curl -sSL https://raw.githubusercontent.com/Gravicity/SAZ-Mini/main/install.sh | bash

# Setup your project  
cd /your/project
~/.saz-mini/setup.sh

# Restart Claude Code: Ctrl+C twice, then: claude --resume
```

### Alternative: Clone First (to browse templates)
```bash
git clone https://github.com/Gravicity/SAZ-Mini.git && cd SAZ-Mini
chmod +x install.sh && ./install.sh
```

## 🚀 First Steps

Once restarted, try these commands:

### New Project
```
"I want to build a [SaaS dashboard/mobile app/API service]"
```
→ SuperAgent deploys project-planner → Researches templates → Creates roadmap

### Existing Project  
```
"Analyze this codebase for optimization opportunities"
```
→ SuperAgent deploys project-analyzer → Finds issues → Recommends improvements

### Specific Need
```
"I need to integrate Stripe payments"
```
→ SuperAgent generates api-integration-specialist → Handles Stripe setup

## 🎯 What You Get

**4 Core Agents:**
- `project-planner` - Research templates, create roadmaps
- `project-analyzer` - Assess codebases, find optimizations
- `memory-manager` - RAG search, complex handoffs
- `agent-generator` - Create custom agents on-demand

**5 Templates:**
- `nextjs-app-builder` - Modern React/Next.js apps
- `api-integration-specialist` - Third-party APIs (Stripe, OpenAI)
- `database-architect` - Schema design, migrations
- `ui-component-builder` - Component libraries, design systems
- `deployment-automation-specialist` - CI/CD, hosting

**3 Workflows:**
- `new-saas-app` - Complete SaaS in 1-2 weeks
- `optimize-existing-app` - Systematic improvements
- `add-new-feature` - Feature addition in 3-7 days

## 🔧 Key Commands

```bash
# Health check
~/.saz-mini/health-check.sh

# Update framework
~/.saz-mini/update.sh

# Interactive setup
~/.saz-mini/setup.sh --interactive

# Check agents
ls .claude/agents/

# View memory
cat .saz/memory/project.md
```

## 💡 Pro Tips

1. **Start with templates** - Don't build from scratch
2. **Let planner research** - It finds proven patterns
3. **Generate on-demand** - Only create agents you need
4. **Update memory** - Keep discoveries for next session
5. **Restart after generation** - New agents need restart

## 🐛 Troubleshooting

**SuperAgent not responding?**
- Check CLAUDE.md exists in project root
- Restart Claude Code (Ctrl+C x2, `claude --resume`)

**Agents not found?**
- Run `~/.saz-mini/health-check.sh`
- Check `.claude/agents/` directory exists

**Need help?**
- Run setup with `--interactive` flag
- Check memory files in `.saz/memory/`

---

**Ready in 5 minutes. Intelligent orchestration for life. 🚀**