# SAZ-Mini Changelog

## v1.0.0 - Initial Release

### What's New (Extracted from SAZ-2)
- Minimal orchestration identity (CLAUDE.md)
- Lean memory system (.saz/memory/)
- Four essential starter agents
- Enhanced agent-generator (replaces custom-agent-builder)
- Native Task tool integration only

### What's Removed from SAZ-2
- 50+ agent catalog (no bundled agents)
- Complex memory managers (simplified to one)
- superagent.md memory file (not needed)
- context.md tracking (unnecessary complexity)
- Agent installation scripts (use Task directly)
- Project-coordinator agent (merged into planner)
- Custom Python script generation (Task only)
- Heavy orchestration protocols (simplified)
- Agent hierarchy rules (flattened)
- Todo color coding system (minimal now)

### What's Changed
- **CLAUDE.md**: Drastically simplified, focused on orchestration workflow
- **Memory**: From 5 files to 3, bullets-only format
- **Agents**: From catalog-based to generation-based
- **Setup**: Non-interactive by default, --interactive optional
- **Paths**: ~/.saz-mini (global), .saz/ (project memory)
- **Custom-agent-builder**: Deprecated, replaced with agent-generator
- **Orchestration**: Simpler workflow with clear heuristics

### Breaking Changes
- No backward compatibility with SAZ-2 memory format
- Different installation paths to avoid conflicts
- Removed automatic agent catalog installation
- Changed memory file structure and sections

---

## Migration Guide from SAZ-2 to SAZ-Mini

### Before You Start
1. **Backup your SAZ-2 installation**
   ```bash
   cp -r ~/.superagent-zero-2 ~/.superagent-zero-2-backup
   cp -r .superagent .superagent-backup
   ```

2. **Document critical custom agents**
   - List custom agents you've created
   - Note their file locations
   - Save their definitions

### Migration Steps

#### 1. Install SAZ-Mini
```bash
cd /path/to/SAZ-Mini
./install.sh
```

#### 2. Setup in Your Project
```bash
cd /your/project
~/.saz-mini/setup.sh --interactive
# Choose option 1 to backup existing CLAUDE.md
```

#### 3. Migrate Custom Agents
```bash
# Copy your custom agents
cp .claude/agents/custom/*.md .claude/agents/custom/
# Or regenerate them using agent-generator
```

#### 4. Migrate Memory (Selective)
Only migrate what's essential:

From `.superagent/memory/project.md`:
- Copy project overview → `.saz/memory/project.md`
- Copy key decisions → `.saz/memory/project.md`
- Skip verbose sections

From `.superagent/memory/insights.md`:
- Extract bullet points → `.saz/memory/insights.md`
- Remove agent-specific sections
- Keep only high-value discoveries

From `.superagent/memory/workflows.md`:
- Copy validated patterns → `.saz/memory/workflows.md`
- Simplify complex workflows
- Remove agent-specific protocols

#### 5. Adjust Workflow

**Old SAZ-2 Way**:
- Deploy from 50+ agent catalog
- Complex starter agent decisions
- Heavy memory protocols
- Multiple memory managers

**New SAZ-Mini Way**:
- Start with 4 starter agents
- Generate custom agents on-demand
- Minimal memory updates
- Single memory-manager for RAG

### Key Differences to Remember

| Aspect | SAZ-2 | SAZ-Mini |
|--------|-------|----------|
| Agent Creation | Select from catalog | Generate on-demand |
| Memory Updates | Detailed sections | Bullets only |
| Orchestration | Complex protocols | Simple workflow |
| Custom Agents | custom-agent-builder | agent-generator |
| Setup | Many prompts | Non-interactive default |
| Philosophy | Everything included | Minimal, expandable |

### Common Issues During Migration

**Issue**: "My specialized agents are missing"
**Solution**: Use agent-generator to recreate them as needed

**Issue**: "Memory seems too simple"
**Solution**: That's intentional - keep only high-signal info

**Issue**: "No agent catalog to browse"
**Solution**: Let agent-generator create exactly what you need

**Issue**: "Workflows seem less sophisticated"
**Solution**: Start simple, build complexity only where needed

### Post-Migration Checklist

- [ ] SAZ-Mini installed globally
- [ ] Project setup complete
- [ ] CLAUDE.md active (restart Claude Code)
- [ ] Essential custom agents migrated
- [ ] Key memory points transferred
- [ ] First task delegated successfully

### Rollback Option

If you need to revert:
```bash
# Restore SAZ-2
mv CLAUDE.md.backup CLAUDE.md
rm -rf .saz
mv .superagent-backup .superagent
# Restart Claude Code
```

---

## Philosophy Note

SAZ-Mini represents a philosophical shift from "everything included" to "generate what you need". This migration is an opportunity to:
- Reduce complexity
- Keep only what provides value
- Build a leaner, more focused system
- Embrace on-demand adaptation

The goal isn't feature parity with SAZ-2, but rather a more elegant approach to the same problems.