# Contributing to Orange Cameroon Mobile App

Thank you for your interest in contributing to the Orange Cameroon Mobile App! We value the contributions of our community members and want to make the contribution process as smooth as possible.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Process](#development-process)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Reporting Bugs](#reporting-bugs)
- [Feature Requests](#feature-requests)

## Code of Conduct

We expect all contributors to adhere to our Code of Conduct. Please ensure you:
- Use welcoming and inclusive language
- Respect different viewpoints and experiences
- Accept constructive criticism gracefully
- Focus on what's best for the community
- Show empathy towards other community members

## Getting Started

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/your-username/mobile-app.git
   ```
3. Add the upstream remote:
   ```bash
   git remote add upstream https://github.com/orangecameroon/mobile-app.git
   ```
4. Create a new branch for your feature/fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Process

1. Ensure you're working with the latest code:
   ```bash
   git pull upstream main
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Make your changes
4. Test your changes thoroughly:
   ```bash
   flutter test
   ```

## Pull Request Process

1. Update the README.md with details of changes if needed
2. Follow the commit message convention:
   - feat: (new feature)
   - fix: (bug fix)
   - docs: (documentation changes)
   - style: (formatting, missing semi-colons, etc)
   - refactor: (refactoring code)
   - test: (adding tests, refactoring tests)
   - chore: (updating grunt tasks etc)
3. Ensure your PR description clearly describes the changes
4. Link any related issues using keywords (fixes #123)

## Coding Standards

- Follow the official [Flutter style guide](https://flutter.dev/docs/development/tools/formatting)
- Use meaningful variable and function names
- Write comments for complex logic
- Include documentation for public APIs
- Maintain widget tree structure clarity
- Keep files focused and single-responsibility

### Flutter-specific Guidelines

1. State Management:
   - Use recommended state management solutions (Provider/Bloc)
   - Keep business logic separate from UI
   - Minimize widget rebuilds

2. Widget Structure:
   - Break down large widgets into smaller, reusable components
   - Use const constructors when possible
   - Implement proper error handling

3. Asset Management:
   - Use proper asset organization
   - Optimize images and media files
   - Follow the asset naming convention

## Reporting Bugs

When reporting bugs, please include:
1. Description of the bug
2. Steps to reproduce
3. Expected behavior
4. Screenshots (if applicable)
5. Device/OS information
6. Flutter version
7. Any relevant logs

## Feature Requests

Feature requests are welcome! Please provide:
1. Clear description of the feature
2. Use cases
3. Expected behavior
4. Mock-ups/wireframes (if applicable)

## Communication

- Use GitHub Issues for bug reports and feature requests
- Join our [Discord community](https://discord.gg/orangecameroon) for discussions
- Follow us on [Twitter](https://twitter.com/orangecameroon) for updates

## License

By contributing to the Orange Cameroon Mobile App, you agree that your contributions will be licensed under the same license as the main project.

---

Thank you for contributing to make the Orange Cameroon Mobile App better! 🎉
