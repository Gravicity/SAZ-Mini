# Optimize Existing Application Workflow

**Best For**: Performance issues, code quality improvements, feature additions
**Time Estimate**: 1-2 weeks depending on scope
**Success Rate**: ✅ High (systematic approach)

## Workflow Steps

### Phase 1: Analysis (Days 1-2)
1. **project-analyzer** → Comprehensive assessment
   - Performance bottlenecks
   - Code quality metrics
   - Security vulnerabilities
   - Technical debt analysis
   - Test coverage gaps

### Phase 2: Priority Planning (Day 3)
2. **project-planner** → Create optimization roadmap
   - Prioritize issues by impact
   - Plan implementation phases
   - Identify required agents

### Phase 3: Implementation (Days 4-10)

**High Priority (Parallel)**:
3a. **database-architect** → Optimize queries and schema
   - Add missing indexes
   - Optimize slow queries
   - Clean up unused data

3b. **ui-component-builder** → Performance improvements
   - Add React.memo where needed
   - Implement lazy loading
   - Optimize bundle size

**Medium Priority (Sequential)**:
4. **api-integration-specialist** → Fix integration issues
   - Add error handling
   - Implement retry logic
   - Update deprecated APIs

### Phase 4: Deployment & Monitoring (Days 11-14)
5. **deployment-automation-specialist** → Improve CI/CD
   - Add performance monitoring
   - Set up error tracking
   - Optimize build process

## Sequential Dependencies
- Analysis must complete before planning
- Database optimizations before API improvements
- All improvements before deployment updates

## Measurement Strategy
**Before Optimization**:
- Lighthouse score
- Bundle size
- Core Web Vitals
- Error rates

**After Optimization**:
- Performance improvements (target: 20%+ boost)
- Reduced error rates
- Better user metrics

## Common Optimization Patterns
- **React**: Add memoization, lazy loading
- **Database**: Index optimization, query improvements  
- **API**: Response caching, error handling
- **Bundle**: Code splitting, tree shaking

## Success Metrics
- ✅ Lighthouse score > 90
- ✅ Bundle size reduced by 20%+
- ✅ Core Web Vitals in green
- ✅ Error rates < 1%

## Red Flags (When to Stop)
- Making changes without measurements
- Optimizing before profiling
- Breaking existing functionality
- Over-engineering simple solutions