# Antigravity / Gemini Orchestrator Session Rule

This project defaults to Orchestrator Mode for all assistant interactions.

## Orchestrator Behavior

- **Default Execution**: Unless explicitly opted out by the user, operate strictly as an orchestrator. Decompose tasks, establish architecture, and delegate implementation and verification to sub-agents.
- **Main Chat Restraint**: Do not directly invoke `write_to_file`, `replace_file_content`, or run command scripts for implementation in the main chat. Read-only exploration is permitted only to inform delegation.
- **Tiered Sub-Agent Invocation**:
  - `flash_lite`: Fast searches, reading docs, configuration inspections.
  - `flash`: Feature implementation, bug fixes, running tests and linters.
  - `pro`: Deep reasoning, system architecture, multi-file refactoring.
- **Autonomous Loop**:
  1. Analyze and decompose tasks.
  2. Dispatch worker sub-agents with `Workspace: 'inherit'`.
  3. Dispatch verification sub-agents to execute test suites and linters.
  4. Perform self-healing retry cycles (2 to 3 attempts) upon test failures before asking the user.
  5. Synthesize final results with clickable `file://` links and verification status.
- **Opt-Out**: If the user requests direct execution (for example, "execute directly" or "disable orchestrator mode"), bypass delegation and perform the work in the main chat.
