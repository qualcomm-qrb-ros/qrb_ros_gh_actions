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

- [👋 Overview](#-overview)
- [🔎 Table of Contents](#-table-of-contents)
- [🎯 Supported Workflows & Actions](#-supported-workflows--actions)
- [🚩 Get Started](#-get-started)
  - [Action-lint](#action-lint)
  - [Commit-lint](#commit-lint)
  - [Cpp Code Style Checker](#cpp-code-style-checker)
  - [Qualcomm Preflight Checks](#qualcomm-preflight-checks)
  - [QIRP Build Checker](#qirp-build-checker)
  - [Ubuntu Build](#ubuntu-build)
  - [Upload Artifact](#upload-artifact)
- [🤝 Contributing](#-contributing)
- [📜 License](#-license)

## 🎯 Supported Workflows & Actions
| Name                         | Type              | Description                                            |
| ---------------------------- | ----------------- | ------------------------------------------------------ |
| `action-lint`                | Reusable Workflow | Lints GitHub Actions workflow files using actionlint   |
| `commit-lint`                | Reusable Workflow | Validates commit messages using Commitlint             |
| `cpp-code-style-checker`     | Reusable Workflow | Lints C++ code style using cpplint                     |
| `qcom-preflight-checks`      | Reusable Workflow | Runs Qualcomm preflight checks (semgrep, repolinter, copyright, etc.) |
| `qirp-sdk-build-checker`     | Reusable Workflow | Checks the build results of the QIRP SDK               |
| `ubuntu-build`               | Reusable Workflow | Builds ROS packages on Ubuntu and generates Debian packages |
| `upload-artifact`            | Composite Action  | Uploads build artifacts to S3 with retention tagging   |


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
  pull_request:

jobs:
  call_action_linter:
    uses: qualcomm-qrb-ros/qrb_ros_gh_actions/.github/workflows/action-lint.yml@main
```


### Commit-lint
This is a reusable GitHub Actions workflow that automatically validates Git commit messages using Commitlint. It helps maintain a clean and standardized commit history across your repositories by ensuring all commits adhere to a predefined convention (e.g., Conventional Commits). This workflow can be called by other repositories to apply commit linting checks on Pull Requests.

#### Usage
To use the `commit-lint` workflow, create a `.github/workflows/commit-lint.yml` file in your repository:

```yaml
# .github/workflows/commit-lint.yml
name: Commit Message Lint

on: [pull_request]

jobs:
  call_commit_lint:
    uses: qualcomm-qrb-ros/qrb_ros_gh_actions/.github/workflows/commit-lint.yml@main
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
  pull_request:

jobs:
  call_cpp_style_checker:
    uses: qualcomm-qrb-ros/qrb_ros_gh_actions/.github/workflows/cpp-code-style-checker.yml@main
```

### Qualcomm Preflight Checks
This is a reusable GitHub Actions workflow that runs Qualcomm preflight security and compliance checks, including semgrep scanning, dependency review, repolinter, copyright/license check, and commit email validation. This workflow can be called by other repositories to apply these checks on pull requests and pushes.

#### Usage
To use the `qcom-preflight-checks` workflow, create a `.github/workflows/qcom-preflight-checks.yml` file in your repository:

```yaml
# .github/workflows/qcom-preflight-checks.yml
name: Qualcomm Preflight Checks

on:
  push:
  pull_request:

jobs:
  preflight:
    uses: qualcomm-qrb-ros/qrb_ros_gh_actions/.github/workflows/qcom-preflight-checks.yml@main
```

### QIRP Build Checker
This is a reusable GitHub Actions workflow that automatically checks QIRP (Qualcomm Integrated Robotics Product) SDK compliance for your repository. It helps ensure that your repository adheres to QIRP guidelines and best practices. This workflow can be called by other repositories to apply QIRP checks on Pull Requests.

#### Usage
```yaml
name: QIRP Build Test

on:
  push:
  pull_request:

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
This workflow builds ROS packages on Ubuntu, generates Debian packages, and optionally uploads artifacts to S3. It is designed to be used as a reusable workflow supporting both `jazzy` and `lyrical` ROS distributions.

#### Usage
To use the `ubuntu-build` workflow, add the following code to your repository's `.github/workflows/ubuntu-build.yml` file:

```yaml
name: Standard ROS Build Checker

on:
    push:
    pull_request:

jobs:
  ros-build:
    uses: qualcomm-qrb-ros/qrb_ros_gh_actions/.github/workflows/ubuntu-build.yml@main
    # with:
    #   # QRB ROS dependencies to clone before build
    #   dependencies: "qualcomm-qrb-ros/qrb_ros_transport qualcomm-qrb-ros/lib_mem_dmabuf"
    #   # Specific parameters to colcon build
    #   colcon_args: --cmake-clean-first
    #   # ROS2 distribution to use (jazzy or lyrical)
    #   ros-distro: "jazzy"
    #   # Runner label: single string for GitHub-hosted or JSON array for self-hosted
    #   # Auto-detected from ros-distro when empty
    #   runner: '["self-hosted","arm64"]'
    #   # Shell commands to run during environment setup
    #   env_setup_commands: "sudo apt install libboost-all-dev"
    # secrets:
    #   # AWS credentials for S3 artifact upload (optional)
    #   AWS_ACCESS_KEY: ${{ secrets.AWS_ACCESS_KEY }}
    #   AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

### Upload Artifact
This is a composite action that uploads build artifacts to an S3 bucket with configurable retention tagging. It supports both `x86_64` and `aarch64` architectures and installs the AWS CLI automatically if not present.

#### Usage
```yaml
- name: Upload artifacts to S3
  uses: qualcomm-qrb-ros/qrb_ros_gh_actions/.github/actions/upload-artifact@main
  with:
    path: ./uploads
    destination: my-org/my-repo/run-123/
    s3_bucket: my-s3-bucket
    # retention: 45d  # 7d, 15d, 30d, 45d, 365d (default: 45d)
    # fileserver_url: https://qli-prod-artifacts.qualcomm.com
    # write-summary: "true"
```

**Inputs:**

| Input            | Required | Default                                      | Description                              |
| ---------------- | -------- | -------------------------------------------- | ---------------------------------------- |
| `path`           | Yes      | —                                            | Directory or file to upload              |
| `destination`    | Yes      | —                                            | S3 key prefix for the destination        |
| `s3_bucket`      | Yes      | —                                            | S3 bucket name                           |
| `retention`      | No       | `45d`                                        | Retention tag value (`7d`, `15d`, `30d`, `45d`, `365d`) |
| `fileserver_url` | No       | `https://qli-prod-artifacts.qualcomm.com`    | Base URL for downloading artifacts       |
| `write-summary`  | No       | `true`                                       | Append uploaded file list to job summary |

**Outputs:**

| Output  | Description                                          |
| ------- | ---------------------------------------------------- |
| `url`   | Base download URL directory for uploaded artifacts   |
| `files` | Newline-separated list of successfully uploaded file paths |

## 🤝 Contributing

We love community contributions! Get started by reading our [CONTRIBUTING.md](CONTRIBUTING.md).  
Feel free to create an issue for bug reports, feature requests, or any discussion 💡.

## 📜 License

Project is licensed under the [BSD-3-Clause](https://spdx.org/licenses/BSD-3-Clause.html) License. See [LICENSE](./LICENSE) for the full license text.