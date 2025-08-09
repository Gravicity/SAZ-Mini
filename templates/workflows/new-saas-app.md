# New SaaS Application Workflow

**Best For**: Building SaaS dashboards, B2B tools, subscription services
**Time Estimate**: 1-2 weeks to MVP
**Success Rate**: ✅ High (proven pattern)

## Workflow Steps

### Phase 1: Planning & Research (Day 1)
1. **project-planner** → Research templates and create roadmap
   - Focus: Find Next.js SaaS starters
   - Output: Technology stack + template recommendation
   - Templates to research: Precedent, Taxonomy, T3-app

### Phase 2: Foundation (Days 2-3)
2. **nextjs-app-builder** → Scaffold from template
   - Clone recommended template
   - Set up authentication
   - Configure database

3. **database-architect** → Design schema
   - User/tenant models
   - Subscription/billing tables
   - Application-specific data

### Phase 3: Core Features (Days 4-7)
4. **api-integration-specialist** → Add Stripe billing
   - Payment processing
   - Webhook handling
   - Subscription management

5. **ui-component-builder** → Build dashboard
   - User interface
   - Data visualization
   - Responsive design

### Phase 4: Launch (Days 8-14)
6. **deployment-automation-specialist** → Deploy to production
   - Vercel deployment
   - Environment configuration
   - Custom domain setup

## Parallel Opportunities
- Steps 2-3 can run simultaneously
- Steps 4-5 can run in parallel after database is ready

## Common Pitfalls
- Don't build auth from scratch - use NextAuth/Clerk
- Set up billing early - Stripe integration is complex
- Deploy frequently - catch issues early

## Success Metrics
- ✅ Authentication working
- ✅ Billing integration complete
- ✅ Core features functional
- ✅ Live at custom domain

## Template Recommendations
- **Starter**: https://github.com/shadcn-ui/taxonomy
- **Alternative**: https://github.com/steven-tey/precedent
- **Simple**: Create T3 App with Stripe