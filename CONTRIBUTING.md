# Contribution Rules

## Branching Strategy

To streamline development for both backend and frontend, we use a straightforward branching strategy centered around the `main` branch for stability and `develop` for ongoing work. Each feature has its own dedicated branch created from `develop`.

### Branch Hierarchy

1. **Main Branch**:  
   - **`main`**: This branch holds stable, production-ready code. Code is only merged here once it has passed all testing and reviews.

2. **Development Branch**:  
   - **`develop`**: Used as the main integration branch where completed features from both backend and frontend are merged for final testing before production.

3. **Feature Branches**:  
   - Feature branches are created from `develop` for individual features. Naming conventions help distinguish between frontend and backend features.
   - **Frontend feature branch naming**: `fe-feat-[feature-name]`
   - **Backend feature branch naming**: `be-feat-[feature-name]`

#### Example Branch Names:
   - `fe-feat-login-page`
   - `fe-feat-navigation-bar`
   - `be-feat-authentication`
   - `be-feat-database-migration`

### Workflow

1. **Create a feature branch**: Begin by creating a feature branch from `develop`.
   - Example: `git checkout -b fe-feat-[feature-name]` or `git checkout -b be-feat-[feature-name]`

2. **Commit regularly**: Make frequent, meaningful commits with descriptive messages following commit message guidelines.

3. **Push your branch**: Regularly push your branch to the remote repository to avoid conflicts.
   - Example: `git push -u origin fe-feat-[feature-name]`

4. **Merge feature branches**:  
   - When the feature is complete, open a pull request to merge into `develop`.
   - The pull request should include all necessary documentation, tests, and implementation details to ensure a smooth review process.
   - After testing, if the feature functions as expected, the merge will proceed into `develop` — however, only the team lead (or designated leader) of the respective module (frontend or backend) is authorized to perform this merge. This ensures a controlled, high-quality integration, as team leads are responsible for verifying that the feature aligns with project standards and does not introduce unexpected issues in the develop branch.

5. **Final merge to `main`**:  
   - Once all features are stable and tested in `develop`, they are merged into `main` for production.
   - Only the project manager is authorized to perform this final merge to `main`
---

## Commit Message Guidelines

Follow **Conventional Commits** format for all commit messages:

### Format:
```
<type>: <subject>
```

- **type**: The nature of the change:
   - `feat`: Adding a new feature
   - `fix`: Bug fix
   - `refactor`: Refactoring code
   - `docs`: Updating documentation
   - `style`: Code style changes
   - `test`: Adding or updating tests
   - `chore`: Routine tasks

- **subject**: Brief description.

### Example Commit Messages:
   - `feat: add login functionality`
   - `fix: resolve layout issue on homepage`
   - `refactor: optimize user retrieval function`

---

## Pull Requests

- Ensure your branch is up-to-date with `develop` before creating a pull request. Example: `git pull origin develop`
- Provide a clear title and description, linking to relevant issues.
- Request reviews from team members, particularly from the team lead, before merging.

## Setting Up and Getting Started

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/kan3103/Pet-Spa-mobile-app.git
   cd Pet-Spa-mobile-app
   ```

2. **Switch to Development Branch**:
   ```bash
   git checkout -b develop origin/develop
   ```

3. **Install Dependencies**:
   Follow project instructions to install dependencies.