# Spec: Terraform Dev Container Support

## Problem Statement

Terraform `.tf` files display as plain text (no syntax highlighting) in VS Code because the HashiCorp Terraform extension is not installed in the devcontainer. Additionally, the `terraform` CLI is not available (`command not found`), making it impossible to run `terraform init`, `plan`, or `apply`.

Both issues stem from the devcontainer configuration missing Terraform tooling.

## Requirements

1. **Terraform CLI** must be installed in the dev container so `terraform` commands work in the terminal.
2. **HashiCorp Terraform VS Code extension** (`hashicorp.terraform`) must be installed so `.tf` files get proper syntax highlighting and language support.

## Acceptance Criteria

- `terraform --version` succeeds in the terminal without errors.
- `.tf` files display with syntax highlighting (status bar shows `Terraform` or `HCL`, not `Plain Text`).
- `terraform init` runs successfully in `s3/iac/terraform/`.
- The devcontainer rebuilds cleanly with no errors.

## Implementation Steps

1. **Install Terraform CLI** — Add Terraform installation to `.devcontainer/Dockerfile` using the official HashiCorp APT repository (pinned to a stable version, e.g. `1.x`).
2. **Add VS Code extension** — Add `"hashicorp.terraform"` to the `customizations.vscode.extensions` array in `.devcontainer/devcontainer.json`.
3. **Rebuild the devcontainer** — Trigger a devcontainer rebuild so the changes take effect.
4. **Verify** — Confirm `terraform --version` works and `.tf` files show syntax highlighting.
