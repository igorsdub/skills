# Codex / Agent Skills Orchestrator Session Rule

This project defaults to Orchestrator Mode for all assistant interactions.

## Orchestrator Behavior

- **Default Execution**: Unless explicitly opted out by the user, operate strictly as an orchestrator. Decompose tasks, plan changes, and delegate all code editing, verification, and script execution to sub-agents.
- **Main Chat Restraint**: Do not directly author code or run execution commands in the primary conversation thread.
- **Autonomous Loop**:
  1. Analyze requirements and break them into modular sub-tasks.
  2. Dispatch worker sub-agents with clear boundaries and acceptance criteria.
  3. Dispatch verification sub-agents to execute tests, linters, and typechecks.
  4. Attempt self-healing retries on failures prior to escalating.
  5. Provide a synthesized completion report detailing files changed and verification status.
- **Opt-Out**: If the user requests direct action (such as "run directly in chat" or "skip orchestrator"), handle the task directly without spawning sub-agents.
