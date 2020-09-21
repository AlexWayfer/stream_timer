# Contributing

### 1. Get a task or an issue

### 2. Create a git branch with correct name

*   Use `snake_case` for branch names.
    *   You can use `/` in branch names, but it's not necessary; examples:
        *   `add/money_gem`
        *   `fix/user_registration`

### 3. Make changes

*   Comment code with a single `#`, write comments for humans with double
    examples:
    *   `# logger.debug something`
    *   `# rubocop:disable SomeCop`
    *   `## This class for cool things`
    *   `## TODO: rewrite this`

### 4. Commit changes with correct text in commit message

*   [Write good commit messages](https://chris.beams.io/posts/git-commit/).
*   Add link to Basecamp to-do, Sentry issue or to GitLab issue
    in the commit description on a separated line; examples:
    *   `Resolve #...`
    *   `Resolve https://some-tasks.com/...`
*   Create one commit for some feature, fix, etc.
    *   You can use `git commit --amend` for this.

### 5. Push the branch to remote

### 6. Create a merge request

*   Assign to your team-lead.
*   Check `Remove source branch when merged`.
*   You can select some labels.

### 7. Start a new task while waiting for review

*   Comment merge requests only when you don't expect response,
    otherwise create discussion.
*   Resolve discussion yourself only after code changes,
    otherwise who opened discussion should closed it.
*   Write a comment when you resolve discussion yourself:
    it simplifies the tracking of MR progress and decisions for reviewers;
    examples:
    *   `I did it!`
    *   `I did something similar to what you suggested`
