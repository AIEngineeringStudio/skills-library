Remote debugging inside Docker
--------------------------------------------------------------------------------

### [Debug Flow via two methods](docker_debug_flow.svg)

```
┌─────────────────────┬──────────────────────┬──────────────────────┐
│ Factor              │ Method 1             │ Method 2             │
│                     │ Docker interpreter   │ debugpy attach       │
├─────────────────────┼──────────────────────┼──────────────────────┤
│ PyCharm             │ PyCharm Professional │ PyCharm Professional │
│                     │ only                 │ and VS Code          │
│                     │                      │                      │
│ Code changes        │ None                 │ Add debugpy block    │
│                     │                      │                      │
│ Setup effort        │ Low (GUI wizard)     │ Medium (manual)      │
│                     │                      │                      │
│ Works in CI/staging │ No                   │ Yes                  │
│                     │                      │                      │
│ Production safe     │ No                   │ No (remove before    │
│                     │                      │ deploying)           │
│                     │                      │                      │
│ Breakpoints         │ Yes                  │ Yes                  │
│                     │                      │                      │
│ Variable inspection │ Yes                  │ Yes                  │
│                     │                      │                      │
│ Best for            │ Local dev only       │ Any environment      │
└─────────────────────┴──────────────────────┴──────────────────────┘
```

🔑 Jargon summary

- **Docker interpreter** — PyCharm uses the container's Python binary directly
  as the project interpreter
- **debugpy** — Python debug adapter; opens a TCP port for a debugger to attach
- **Remote attach** — debugger connects to a running process over a network port
- **port mapping** — host:container in docker-compose.yml; forwards traffic from
  host to container

**Method 1 — [Docker interpreter](method1_docker_interpreter_flow.svg)**

- IDE connects directly to the container's Python binary (Python interpreter).
- It handles everything automatically.
- No code changes needed.

**Prerequisites:**

- PyCharm Professional.
- Requires a paid license.

**Steps:**

1. Open Settings → Project → Python Interpreter
2. Click the gear icon → Add interpreter
3. Select On Docker Compose
4. Set your docker-compose.yml path and service name (e.g., app)
5. PyCharm pulls the container image and indexes the interpreter
6. Set breakpoints → click the green bug icon to debug

--------------------------------------------------------------------------------

**Method 2 —[debugpy remote attach](method2_debugpy_flow.svg)**

- You add debugpy to your code,
- expose a port, and
- IDE attaches to it manually.

**Prerequisites:**

- VS Code based IDE.
- Requires debugpy installed in the container.

**Steps:**

1. Place launch.json under `.vscode/ ` 
   - Folder structure for `.vscode/ `
      ```
           task_manager/
           ├── .vscode/
           │   └── launch.json       # ← new
           ├── docker-compose.yml
           ├── docker-compose.dev.yml  # ← add port 5678
           └── backend
               └── app/
                    └── main.py           # ← add debugpy block
      ```
2. Install debugpy in your container:
    - [tool.uv] dev-dependencies is deprecated
        - replace `dev-dependencies `with [dependency-groups]
    - add `debugpy>=1.8",`
   ```
    [tool.uv]
    # uv tool settings — no dev-dependencies here anymore
    
    [dependency-groups]
    dev = [
        "debugpy>=1.8",
        "pytest>=8.3.0",
        "pytest-asyncio>=0.25.0",
        "ruff>=0.9.0",
    ]
   ```
   ```text
    ┌──────────────────────────────┬──────────────────────────────────────┐
    │ Location                     │ When installed                       │
    ├──────────────────────────────┼──────────────────────────────────────┤
    │ [project.dependencies]       │ Always — dev + prod image            │
    │ [tool.uv] dev-dependencies   │ Only with: uv sync --dev             │
    │ [project.optional-deps] dev  │ Only with: uv sync --extra dev       │
    └──────────────────────────────┴──────────────────────────────────────┘
   ```
3. Add this block to your app entrypoint (e.g., app/main.py):
   ```
    import os
    import debugpy
    
    if os.getenv("DEBUG") == "true":
        debugpy.listen(("0.0.0.0", 5678))
        # Uncomment the line below to pause startup until Cursor attaches:
        # debugpy.wait_for_client()
   ```                             

4. Expose port 5678 in docker-compose.dev.yml:
   ```
    services:
      backend:
        build:
          target: dev       # use the new dev stage (has debugpy)

        environment:
          DEBUG: true
   
        ports:
          - "5678:5678"
   ```

   **Rule to remember:**
    - Pick one style per environment block
    ```text
    ┌─────────────┬────────────────────────┬────────────────────┐
    │ Style       │ Syntax                 │ Mix with other?    │
    ├─────────────┼────────────────────────┼────────────────────┤
    │ List style  │ - KEY=VALUE            │ No — pick one      │
    │ Map style   │ KEY: VALUE             │ No — pick one      │
    └─────────────┴────────────────────────┴────────────────────┘   
    ```
5. Attach Debugger
    - rebuild and restart
       ```
       make down
       docker compose -f docker-compose.yml \
                      -f docker-compose.dev.yml build
        make up
        ```
    - Verify Debugpy is ready
        - Run
          ```bash
          curl http://localhost:5678
          ```
        - `debugpy` responds with
            - `curl: (1) Received HTTP/0.9 when not allowed`
            - This means the port is open and responded — but debugpy speaks its
              own binary protocol, not HTTP.
            - curl rejects the response because it expected HTTP/1.x.
        - Attach from Cursor:
        - ```
          1. Cursor → Run & Debug (Mac: Cmd+Shift+D) 
          2. Select "Attach to Docker (debugpy)"    
              → dropdown at the top of the Run & Debug panel
          3. Click the green play button ▶     ← connect to debugpy on port 5678
          4. Set a breakpoint in backend/app/main.py         
               click left of line number       ← set a red dot breakpoint
          5. Trigger that code path     
              → hit the endpoint via browser or curl
                curl http://localhost:8000/health
          6. Cursor pauses at the breakpoint   ← you can inspect variables
                    ```


