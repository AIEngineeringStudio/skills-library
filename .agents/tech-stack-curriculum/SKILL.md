---
name: tech-stack-curriculum
description: Curriculum and sequencing rules for teaching the workspace technology stack (Python/uv, .env/python-dotenv, pydantic-settings, Agentic AI, MCP, FastMCP, FastAPI, Docker, PostgreSQL). Use together with the first-principles-learning skill.
---

# Tech Stack Curriculum

Use this skill whenever the learner asks to learn a technology in the workspace stack. Apply it together with the `first-principles-learning` skill, which defines the learner profile, teaching style, and per-concept template.

## Stack

- Python with `uv` for project and dependency management.
- `.env` files with `python-dotenv` for local environment variables.
- Pydantic (via `pydantic-settings`) for typed, validated, fail-fast configuration.
- Agentic AI fundamentals (agent loop, tool calling, memory, orchestration, guardrails).
- MCP (Model Context Protocol) client/server concepts.
- FastMCP for building MCP servers.
- FastAPI for production HTTP APIs.
- Docker for reproducible, isolated application environments.
- PostgreSQL for production relational data storage.

## Sequencing rules

- Do not introduce a framework, library, or tool until the underlying concept can be explained without it.
- Introduce one framework or major tool at a time. Never present the whole stack, architecture, or implementation in one response.
- After the foundation is understood, teach the framework step by step: its purpose, the problem it solves, its main abstraction, then its execution flow.
- Prefer technologies and patterns used in enterprise-level production systems. Explain operational tradeoffs, not only the happy path.

## Recommended order

Follow this order unless the learner has a clear reason to change it. Do not advance until the current foundation is demonstrated or the learner explicitly asks to proceed after a brief recap.

1. Python fundamentals needed for the current task.
2. Reproducible project and dependency management without `uv`.
3. `uv` as the project and dependency-management tool.
4. Configuration without a library: environment variables, why secrets don't belong in code, and why missing/bad config should fail fast at startup.
5. `.env` files with `python-dotenv`, then typed, validated, fail-fast configuration with `pydantic-settings`.
6. Agentic AI fundamentals: agent loop (perceive-plan-act), tool calling, memory/context window, multi-step reasoning, orchestration, and guardrails — without any agent framework.
7. HTTP, request/response lifecycles, and API design without FastAPI.
8. FastAPI and its production patterns.
9. MCP concepts: client/server roles, tools, resources, prompts, transport, and why agents need a standard protocol — without FastMCP.
10. FastMCP and its production patterns.
11. Relational data, transactions, and SQL without PostgreSQL-specific features.
12. PostgreSQL and production database practices.
13. Processes, isolation, images, and networking without Docker.
14. Docker and production containerization.
15. Incremental integration of the stack, adding one boundary at a time (e.g., an agent calling an MCP tool over FastMCP, backed by PostgreSQL, all containerized, configured via validated environment variables).

## Versioning and containerization standards

- Pin exact dependency versions. Never use floating versions such as `latest`, `^`, `~`, or an unpinned dependency.
- Identify the current latest supported LTS or stable production version at teaching time. State the version and the date checked. Do not claim a version is LTS unless the upstream project documents that support status.
- Containerize dependency installation and execution. Install and run dependencies inside a Docker build or compose environment rather than on the host, unless a host installation is required and explicitly justified.
- Introduce container concepts one at a time as they become relevant: build context, image layers, lockfiles, reproducibility, secrets, networking, persistent volumes, health checks, non-root execution.
- State the target platform explicitly for every Docker example (e.g., `--platform linux/amd64` vs. `linux/arm64`), or use multi-arch base images so the same Dockerfile and commands run unchanged on Intel and Apple Silicon.

## Configuration and validation standards

- Store local secrets and settings in a `.env` file, loaded with `python-dotenv`. Never commit `.env` to version control; teach and use a `.env.example` file with placeholder values instead.
- Define configuration as a typed `pydantic-settings` `BaseSettings` model wherever the project reads environment variables, instead of scattering raw `os.getenv` calls.
- Required variables must have no default value in the settings model. Let Pydantic raise a validation error when they are missing or the wrong type.
- Fail fast: validate configuration once at process startup (before the app, agent, or server starts serving requests), and exit with a clear error message naming the missing or invalid variable(s). Do not defer validation to first use.
- In Docker, pass environment variables via `--env-file` or the compose `environment:`/`env_file:` keys, and keep the same `pydantic-settings` model as the single source of truth on both the host and in the container.
