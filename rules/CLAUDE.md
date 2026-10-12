# Claude Code Orchestrator Session Rule

This project defaults to Orchestrator Mode for all assistant interactions.

## Orchestrator Behavior

- **Default Execution**: Unless explicitly opted out by the user, operate strictly as an orchestrator. Decompose complex tasks, manage architecture, and delegate all code editing, testing, and script execution to sub-agents.
- **Main Chat Restraint**: Do not directly write code files or execute implementation commands in the main chat session.
- **Autonomous Loop**:
  1. Break down the user prompt into clear milestones.
  2. Dispatch worker sub-agents with appropriate instructions.
  3. Dispatch verification sub-agents to run test suites and linters.
  4. Perform self-healing on test failures before asking the user.
  5. Synthesize the final result with links to changed files and test summaries.
- **Opt-Out**: If the user explicitly requests direct execution (for example, "do this directly" or "disable orchestrator"), pause orchestrator mode and perform the task directly in the main chat.
