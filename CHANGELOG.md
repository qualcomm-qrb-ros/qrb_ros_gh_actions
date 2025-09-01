
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Describe new features that will be in the next release.
- For example: Initial implementation of feature X.

### Changed
- Describe changes to existing functionality.
- For example: Refactored module Y for improved performance.

### Deprecated
- Describe features that are still available but will be removed in future versions.
- For example: Deprecated old API endpoint `/v1/users`. Use `/v2/users` instead.

### Removed
- Describe features that have been removed in this (unreleased) version.
- For example: Removed support for legacy configuration option Z.

### Fixed
- Describe any bug fixes.
- For example: Fixed an issue where login failed with certain special characters.
- For example: Corrected calculation error in report generation.

### Security
- Describe any security vulnerabilities fixed or security improvements.
- For example: Patched critical security vulnerability related to user authentication.

## [0.1.0] - 2025-9-1
### Added
- Add reusable linters for QRB ROS organization. Linter list:  

| Linters              | Description                                            |
| -------------------- | ------------------------------------------------------ |
| `action-lint`        | Lints C++ code using a specified style guide |
| `commit-lint`        | Lints Python code using a specified style guide |
| `cpp-code-style-checker` | Lints C++ code style using cpplint |
| `qirp-sdk-build-checker` | Checks the build results of the QIRP SDK |
| `ubuntu-build`       | Checks the build results of the ROS build on Ubuntu | |
- Add description and usage to each linter actions.