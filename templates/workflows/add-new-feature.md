# Add New Feature Workflow

**Best For**: Adding features to existing applications
**Time Estimate**: 3-7 days per feature
**Success Rate**: ✅ High with proper planning

## Workflow Steps

### Phase 1: Feature Analysis (Day 1)
1. **project-analyzer** → Understand current architecture
   - Identify integration points
   - Check existing patterns
   - Find similar implementations
   - Document dependencies

### Phase 2: Feature Planning (Day 1)
2. **project-planner** → Design feature implementation
   - Break down into tasks
   - Plan database changes
   - Design API contracts
   - Create UI mockups

### Phase 3: Implementation (Days 2-5)

**Backend First** (Recommended):
3a. **database-architect** → Schema changes (if needed)
   - Add new tables/columns
   - Update relationships
   - Create migrations

3b. **api-integration-specialist** → API endpoints
   - CRUD operations
   - Business logic
   - Error handling
   - Testing

**Frontend Second**:
4. **ui-component-builder** → User interface
   - New components
   - Update existing UI
   - Form handling
   - State management

### Phase 4: Integration & Testing (Days 6-7)
5. **deployment-automation-specialist** → Deploy feature
   - Feature flags (if available)
   - Staging deployment
   - Production rollout
   - Monitoring setup

## Decision Points

### When to Create Custom Agents
- Feature is domain-specific (e.g., payment processing)
- Complex business logic
- Integration with specialized APIs
- Unique workflow requirements

### Backend vs Frontend First
- **Backend First**: Data-heavy features, APIs
- **Frontend First**: UI-heavy features, interactions
- **Parallel**: Simple CRUD with clear contracts

## Feature Complexity Guide

### Simple Features (3-4 days)
- CRUD operations
- Form additions  
- UI improvements
- Basic integrations

### Complex Features (5-7 days)
- Multi-step workflows
- External API integrations
- Real-time functionality
- Advanced business logic

### Very Complex Features (1-2 weeks)
- Consider breaking into multiple features
- May need custom agent generation
- Requires careful planning and testing

## Testing Strategy
- Unit tests for business logic
- Integration tests for APIs
- E2E tests for critical paths
- Manual testing for UX

## Success Metrics
- ✅ Feature works as designed
- ✅ No regression in existing features
- ✅ Performance impact < 5%
- ✅ User acceptance testing passed

## Rollback Plan
- Feature flags for quick disable
- Database rollback scripts
- Previous version deployment ready