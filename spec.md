# Spec: AWS CLI Auto-Prompt Mode

## Problem Statement

The `AWS_CLI_AUTO_PROMPT=on-partial` environment variable is defined inside a `.gitpod.yml` task that no longer runs reliably since the project moved to a devcontainer setup. As a result, the AWS CLI auto-prompt mode is not activated when the environment starts.

## Requirements

- `AWS_CLI_AUTO_PROMPT=on-partial` must be set in both:
  1. `.gitpod.yml` — as a top-level `env` block so it applies to all tasks
  2. `devcontainer.json` — via `remoteEnv` so it applies in the devcontainer

## Acceptance Criteria

- Running any incomplete AWS CLI command (e.g. `aws s3`) triggers the interactive auto-prompt
- The variable is present in both `.gitpod.yml` and `devcontainer.json`
- No duplicate or conflicting definitions remain in `.gitpod.yml` task-level env blocks

## Implementation Steps

1. Add a top-level `env` block to `.gitpod.yml` with `AWS_CLI_AUTO_PROMPT: on-partial` and remove the task-level env from the `Setup AWS CLI` task
2. Add `remoteEnv` to `.devcontainer/devcontainer.json` with `AWS_CLI_AUTO_PROMPT: on-partial`
