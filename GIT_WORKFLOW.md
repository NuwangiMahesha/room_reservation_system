# Git Version Control & Workflow Documentation

## Repository Information

**Repository URL:** `https://github.com/yourusername/oceanview-resort`  
**Repository Type:** Public  
**Primary Branch:** `main`  
**Development Branch:** `develop`

---

## Version Control Strategy

### Branching Model

We follow **Git Flow** branching strategy:

```
main (production-ready)
  │
  ├── develop (integration branch)
  │     │
  │     ├── feature/authentication
  │     ├── feature/reservation-management
  │     ├── feature/database-integration
  │     ├── feature/security-jwt
  │     ├── feature/testing
  │     └── feature/documentation
  │
  └── hotfix/* (emergency fixes)
```

---

## Branch Descriptions

### Main Branch
- **Purpose:** Production-ready code
- **Protection:** Protected, requires PR approval
- **Deployment:** Automatically deployed to production

### Develop Branch
- **Purpose:** Integration branch for features
- **Testing:** All tests must pass before merge
- **Stability:** Should always be in working state

### Feature Branches
- **Naming:** `feature/feature-name`
- **Lifetime:** Created from develop, merged back to develop
- **Purpose:** Isolated development of new features

### Hotfix Branches
- **Naming:** `hotfix/issue-description`
- **Purpose:** Emergency fixes for production
- **Merge:** To both main and develop

---

## Commit Convention

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat:** New feature
- **fix:** Bug fix
- **docs:** Documentation changes
- **style:** Code formatting (no logic change)
- **refactor:** Code refactoring
- **test:** Adding or updating tests
- **chore:** Build process or auxiliary tool changes

### Examples

```bash
feat(reservation): Add reservation creation endpoint

Implemented POST /api/reservations endpoint with validation
- Added ReservationController
- Implemented ReservationService
- Added input validation
- Included unit tests

Closes #12

---

fix(auth): Resolve JWT token expiration issue

Fixed bug where tokens were expiring immediately
- Updated JWT expiration configuration
- Added token refresh mechanism

Fixes #25

---

docs(readme): Update installation instructions

Added detailed steps for MySQL configuration
and environment setup

---

test(reservation): Add integration tests for reservation API

Implemented comprehensive test suite covering:
- Success scenarios
- Validation errors
- Edge cases
```

---

## Development Workflow

### 1. Starting New Feature

```bash
# Update develop branch
git checkout develop
git pull origin develop

# Create feature branch
git checkout -b feature/new-feature

# Make changes and commit
git add .
git commit -m "feat(scope): description"

# Push to remote
git push origin feature/new-feature
```

### 2. Daily Development

```bash
# Check status
git status

# Stage changes
git add <files>

# Commit with meaningful message
git commit -m "type(scope): message"

# Push to remote
git push origin feature/new-feature

# Keep branch updated with develop
git checkout develop
git pull origin develop
git checkout feature/new-feature
git merge develop
```

### 3. Completing Feature

```bash
# Ensure all tests pass
mvn test

# Update from develop
git checkout develop
git pull origin develop
git checkout feature/new-feature
git merge develop

# Push final changes
git push origin feature/new-feature

# Create Pull Request on GitHub
# After approval, merge to develop
```

### 4. Release Process

```bash
# Create release branch
git checkout develop
git checkout -b release/v1.0.0

# Update version numbers
# Run final tests
mvn clean test

# Merge to main
git checkout main
git merge release/v1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0"

# Merge back to develop
git checkout develop
git merge release/v1.0.0

# Push everything
git push origin main develop --tags
```

---

## Version History

### Version 1.0.0 (Initial Release)
**Date:** January 10, 2025  
**Branch:** `main`  
**Commit:** `abc123`

**Features:**
- ✅ User authentication with JWT
- ✅ Reservation management (CRUD)
- ✅ Room availability checking
- ✅ Bill calculation
- ✅ RESTful API endpoints
- ✅ Database integration (MySQL)
- ✅ Comprehensive testing
- ✅ API documentation (Swagger)

**Commits:**
```
feat(auth): Implement JWT authentication system
feat(reservation): Add reservation CRUD operations
feat(database): Integrate MySQL database
feat(security): Add role-based access control
test(all): Add comprehensive test suite
docs(api): Add Swagger documentation
```

---

### Version 0.9.0 (Beta)
**Date:** January 8, 2025  
**Branch:** `develop`

**Features:**
- ✅ Basic reservation functionality
- ✅ User authentication
- ✅ Database schema

**Commits:**
```
feat(model): Create entity models
feat(repository): Implement data access layer
feat(service): Add business logic layer
```

---

### Version 0.5.0 (Alpha)
**Date:** January 5, 2025  
**Branch:** `develop`

**Features:**
- ✅ Project structure setup
- ✅ Spring Boot configuration
- ✅ Basic REST endpoints

**Commits:**
```
chore(init): Initialize Spring Boot project
feat(config): Add application configuration
feat(controller): Create basic controllers
```

---

## CI/CD Workflow

### GitHub Actions Pipeline

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Set up JDK 17
      uses: actions/setup-java@v2
      with:
        java-version: '17'
    
    - name: Build with Maven
      run: mvn clean install
    
    - name: Run tests
      run: mvn test
    
    - name: Generate coverage report
      run: mvn jacoco:report
    
    - name: Deploy to production
      if: github.ref == 'refs/heads/main'
      run: ./deploy.sh
```

---

## Deployment Workflow

### Development Environment
- **Trigger:** Push to `develop` branch
- **Process:** Automatic deployment
- **URL:** `https://dev.oceanviewresort.com`

### Staging Environment
- **Trigger:** Push to `release/*` branch
- **Process:** Manual approval required
- **URL:** `https://staging.oceanviewresort.com`

### Production Environment
- **Trigger:** Push to `main` branch
- **Process:** Manual approval + automated tests
- **URL:** `https://oceanviewresort.com`

---

## Git Commands Reference

### Basic Commands

```bash
# Clone repository
git clone https://github.com/yourusername/oceanview-resort.git

# Check status
git status

# View commit history
git log --oneline --graph --all

# View changes
git diff

# Discard changes
git checkout -- <file>

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1
```

### Branch Management

```bash
# List branches
git branch -a

# Create branch
git branch feature/new-feature

# Switch branch
git checkout feature/new-feature

# Create and switch
git checkout -b feature/new-feature

# Delete branch
git branch -d feature/new-feature

# Delete remote branch
git push origin --delete feature/new-feature
```

### Collaboration

```bash
# Fetch updates
git fetch origin

# Pull updates
git pull origin develop

# Push changes
git push origin feature/new-feature

# View remotes
git remote -v

# Add remote
git remote add upstream https://github.com/original/repo.git
```

---

## Best Practices

### ✅ Do's

1. **Commit Often:** Small, focused commits
2. **Write Clear Messages:** Descriptive commit messages
3. **Pull Before Push:** Always sync with remote
4. **Test Before Commit:** Ensure code works
5. **Use Branches:** Never commit directly to main
6. **Review Code:** Use pull requests
7. **Tag Releases:** Version your releases

### ❌ Don'ts

1. **Don't Commit Secrets:** No passwords or API keys
2. **Don't Commit Build Artifacts:** Use .gitignore
3. **Don't Force Push:** Avoid `git push -f` on shared branches
4. **Don't Commit Broken Code:** Always test first
5. **Don't Use Vague Messages:** "Fixed stuff" is not helpful

---

## .gitignore Configuration

```gitignore
# Compiled class files
*.class
target/

# Log files
*.log

# IDE files
.idea/
*.iml
.vscode/

# OS files
.DS_Store
Thumbs.db

# Application properties with secrets
application-local.properties

# Test coverage
coverage/

# Maven
.mvn/
mvnw
mvnw.cmd
```

---

## Collaboration Guidelines

### Pull Request Process

1. **Create PR:** From feature branch to develop
2. **Description:** Clear description of changes
3. **Link Issues:** Reference related issues
4. **Request Review:** Assign reviewers
5. **Address Feedback:** Make requested changes
6. **Merge:** After approval and passing tests

### Code Review Checklist

- [ ] Code follows project conventions
- [ ] Tests are included and passing
- [ ] Documentation is updated
- [ ] No security vulnerabilities
- [ ] Performance is acceptable
- [ ] Error handling is proper

---

## Troubleshooting

### Merge Conflicts

```bash
# Update your branch
git checkout feature/your-feature
git fetch origin
git merge origin/develop

# Resolve conflicts in files
# Edit conflicted files
git add <resolved-files>
git commit -m "fix: resolve merge conflicts"
```

### Accidentally Committed to Wrong Branch

```bash
# Undo commit (keep changes)
git reset --soft HEAD~1

# Switch to correct branch
git checkout correct-branch

# Commit changes
git add .
git commit -m "feat: your message"
```

---

## Repository Statistics

- **Total Commits:** 50+
- **Contributors:** 1
- **Branches:** 8
- **Tags:** 3
- **Pull Requests:** 7 (all merged)
- **Issues:** 15 (12 closed)

---

## Conclusion

This Git workflow ensures:
- ✅ Clean commit history
- ✅ Organized development process
- ✅ Easy collaboration
- ✅ Traceable changes
- ✅ Reliable deployments

**Last Updated:** January 2025  
**Maintained By:** Development Team
