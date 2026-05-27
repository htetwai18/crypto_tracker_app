# Contributing

## Development workflow

This project follows Test-Driven Development (TDD) for all future behavior changes.

For any change that affects behavior (feature, bug fix, refactor):

1. **Red**: write or update a test that fails for the intended behavior.
2. **Green**: implement the smallest code change to make the test pass.
3. **Refactor**: clean up code while keeping the full suite green.

Existing completed features do not require immediate rewrites. Strengthen tests opportunistically when you touch an area.

## Pull request expectations

- Behavior changes must include test coverage updates.
- Keep PRs focused on one behavior or concern when possible.
- Ensure CI stays green before merge.

Include a brief Red/Green/Refactor summary in the PR description:

- What test was failing first?
- What change made it pass?
- What refactor (if any) followed?

## Local parity commands

Run these before opening a PR:

```bash
flutter pub get
flutter analyze
flutter test
```

If you changed formatting-sensitive files, also run:

```bash
flutter format .
```
