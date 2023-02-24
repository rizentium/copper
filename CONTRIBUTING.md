# Contributing to Copper

## Environment Setup

Copper uses Melos to manage the project and dependencies.

To install Melos, run the following command from your SSH client:

```bash
dart pub global activate melos
```

Next, at the root of your locally cloned repository bootstrap the projects dependencies:

melos bootstrap
The bootstrap command locally links all dependencies within the project without having to provide manual dependency_overrides. This allows all plugins, examples and tests to build from the local clone project.

You do not need to run flutter pub get once bootstrap has been completed.