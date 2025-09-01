<div align="center">
  <h1>qrb_ros_gh_actions</h1>
  <p>Centralized CI/CD automation and shared GitHub Actions for QRB ROS projects.</p>
  
  <a href="https://ubuntu.com/download/qualcomm-iot" target="_blank"><img src="https://img.shields.io/badge/Qualcomm%20Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" alt="Qualcomm Ubuntu"></a>
  <a href="https://docs.ros.org/en/jazzy/" target="_blank"><img src="https://img.shields.io/badge/ROS%20Jazzy-1c428a?style=for-the-badge&logo=ros&logoColor=white" alt="Jazzy"></a>
  
</div>

---

## 👋 Overview
A centralized repository for storing and maintaining shared GitHub Actions, CI workflows, and automation scripts for the [qualcomm-qrb-ros](https://github.com/qualcomm-qrb-ros/) organization.
These resources are intended to standardize and streamline CI/CD processes across all qrb-ros projects.


## 🔎 Table of Contents

> 📌 If the content is extensive, we recommend adding a table of contents.

- [👋 Overview](#-overview)
- [🔎 Table of Contents](#-table-of-contents)
- [🎯 Supported Linters](#-supported-linters)
- [🚩 Get Started](#-get-started)
  - [Action-lint](#action-lint)
    - [Usage](#usage)
  - [Commit-lint](#commit-lint)
    - [Usage](#usage-1)
  - [Cpp Code Style Checker](#cpp-code-style-checker)
    - [Usage](#usage-2)
  - [QIRP Build Checker](#qirp-build-checker)
    - [Usage](#usage-3)
  - [Ubuntu Build](#ubuntu-build)
    - [Usage](#usage-4)
- [🤝 Contributing](#-contributing)
- [📜 License](#-license)

## 🎯 Supported Linters
| Linters              | Description                                            |
| -------------------- | ------------------------------------------------------ |
| `action-lint`        | Lints C++ code using a specified style guide |
| `commit-lint`        | Lints Python code using a specified style guide |
| `cpp-code-style-checker` | Lints C++ code style using cpplint |
| `qirp-sdk-build-checker` | Checks the build results of the QIRP SDK |
| `ubuntu-build`       | Checks the build results of the ROS build on Ubuntu | |


## 🚩 Get Started
### Action-lint
This is a reusable GitHub Actions workflow that automatically lints the syntax and structure of your GitHub Actions workflows using actionlint. It helps identify errors, deprecated syntax, and potential issues early in the development cycle, ensuring robust and maintainable CI/CD pipelines. This workflow can be called by other repositories to apply workflow linting checks.

#### Usage
To use the `action-lint` workflow, create a `.github/workflows/action-lint.yml` file in your repository:

```yaml
# .github/workflows/action-lint.yml
name: Action Linter Workflows

on:
  push:
  pull_request: # Also run on PRs

jobs:
  call_action_linter:
    uses: qualcomm-qrb-ros/qrb_ros_gh_actions/.github/workflows/action-lint.yml@main # Adjust the path and ref as needed
    # If your central repository is private, you might need to pass a token:
    # with:
    #   token: ${{ secrets.GITHUB_TOKEN }} # Or a PAT with repo scope for private repos
```


### Commit-lint
This is a reusable GitHub Actions workflow that automatically validates Git commit messages using Commitlint. It helps maintain a clean and standardized commit history across your repositories by ensuring all commits adhere to a predefined convention (e.g., Conventional Commits). This workflow can be called by other repositories to apply commit linting checks on Pull Requests.

#### Usage
To use the `commit-lint` workflow, create a `.github/workflows/commit-lint.yml` file in your repository:

```yaml
# .github/workflows/commit-lint.yml
name: Commit Message Lint

on: [pull_request] # Trigger this workflow on Pull Request events

jobs:
  call_commit_lint:
    uses: qualcomm-qrb-ros/qrb_ros_gh_actions/.github/workflows/commit-lint.yml@main
    # If your central repository is private, you might need to pass a token:
    # with:
    #   token: ${{ secrets.GITHUB_TOKEN }} # Or a PAT with repo scope for private repos
```

### Cpp Code Style Checker
This is a reusable GitHub Actions workflow that automatically checks Cpp code style using cpplint. It helps maintain a consistent code style across your project by enforcing a set of formatting rules. This workflow can be called by other repositories to apply Cpp code style checks on Pull Requests.

#### Usage
To use the `cpp-code-style-checker` workflow, create a `.github/workflows/cpp-code-style-checker.yml` file in your repository:

```yaml
# .github/workflows/cpp-style-checker.yml
name: C++ Code Style Check

on:
  push:
  pull_request: # Run on PRs

jobs:
  call_cpp_style_checker:
    uses: qualcomm-qrb-ros/qrb_ros_gh_actions/.github/workflows/cpp-code-style-checker.yml@main # Adjust the path and ref as needed
    # If your central repository is private, you might need to pass a token:
    # with:
    #   token: ${{ secrets.GITHUB_TOKEN }} # Or a PAT with repo scope for private repos
```

### QIRP Build Checker
This is a reusable GitHub Actions workflow that automatically checks QIRP (Qualcomm Integrated Robotics Product) SDK compliance for your repository. It helps ensure that your repository adheres to QIRP guidelines and best practices. This workflow can be called by other repositories to apply QIRP checks on Pull Requests.

#### Usage
```yaml
name: QIRP Build Test

on:
  push:
  pull_request: # Run on PRs

jobs:
  qirp-sdk-build-checker:
    uses: qualcomm-qrb-ros/qrb_ros_gh_actions/.github/workflows/qirp-sdk-build-checker.yml@main
    # with:
    #   # Download source code of your dependency
    #   dependencies: qualcomm-qrb-ros/qrb_ros_interfaces
    #   # Specific parameters to colcon build
    #   colcon_args:  --cmake-clean-first
    #   # Customized shell commands before "colcon build"
    #   pre_build_commands: "echo "hello""
```

### Ubuntu Build
This workflow is intended to be used by other repositories to run ROS Ubuntu build checks for your repository. It is designed to be used as a reusable workflow, allowing other repositories to easily incorporate Ubuntu build checks into their workflow.

#### Usage
To use the `ubuntu-build` workflow, add the following code to your repository's `.github/workflows/your-workflow.yml` file:

```yaml
name: Standard ROS Build Checker

on:
    push:
    pull_request:

jobs:
  ros-build:
    uses: qualcomm-qrb-ros/qrb_ros_gh_actions/.github/workflows/ubuntu-build.yml@main
    # with:
    #   # QRB ROS dependency
    #   dependencies: "qualcomm-qrb-ros/qrb_ros_transport qualcomm-qrb-ros/lib_mem_dmabuf"
    #   # Specific parameters to colcon build
    #   colcon_args:  --cmake-clean-first
    #   # ROS2 distribution to use, e.g. jazzy
    #   ros-distro: "jazzy"
    #   # List of apt packages to install before colcon build
    #   apt-packages: "libboost-all-dev"
```

## 🤝 Contributing

We love community contributions! Get started by reading our [CONTRIBUTING.md](CONTRIBUTING.md).  
Feel free to create an issue for bug reports, feature requests, or any discussion 💡.

## 📜 License

Project is licensed under the [BSD-3-Clause](https://spdx.org/licenses/BSD-3-Clause.html) License. See [LICENSE](./LICENSE) for the full license text.