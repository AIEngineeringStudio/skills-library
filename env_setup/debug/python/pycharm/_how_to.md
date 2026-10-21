## How it works

```
PyCharm
  └── runs app code directly
  └── connects to PostgreSQL in Docker on localhost:5432
```

```
┌─────────────────────────────────────────────┐
│ Docker                                      │
│   db container → localhost:5432             │
└─────────────────────────────────────────────┘
          ↑ connects via DATABASE_URL
┌─────────────────────────────────────────────┐
│ Your Mac                                    │
│   PyCharm runs app code directly            │
│   Full debugger — breakpoints, inspection   │
└─────────────────────────────────────────────┘
```

**Port 5432** is already exposed in `docker-compose.dev.yml`

**Step 1:**  Start ONLY the **DB container**

```
docker compose -f docker-compose.yml \
               -f docker-compose.dev.yml up db -d
```

**Step 2:** Install dependencies locally

```
cd backend
uv sync --dev
```

**Step 3:**  Create a local .env for running outside Docker

- The existing `.env` uses `db` as the hostname (Docker internal).
- Locally you need `localhost`
- create `.env.local`

### .env (Docker)

- Inside Docker, containers talk to each other using service names (`db`).

```
DATABASE_URL=postgresql+asyncpg://postgres:XXXXX@db:5432/taskdb
                                                 ^^
                                         Docker service name
```

### .env.local (PyCharm / local)

- Outside Docker, your Mac connects via `localhost`.

```
DATABASE_URL=postgresql+asyncpg://postgres:XXXXX@localhost:5432/taskdb
                                                 ^^^^^^^^^
                                                  your Mac
```
**Rule to remember:**
```
.env       → lives next to docker-compose.yml
.env.local → lives next to pyproject.toml
```

**Step 4:** Configure PyCharm run configuration

```text
1. PyCharm → Run → Edit Configurations
2. Click + → Python
3. Set:
   Script kind       : Module
   Module name       : uvicorn 
   Script Parameters : app.main:app --host 0.0.0.0 --port 8000 --reload
                       (or app.db.seed to debug seed)
   Working dir       : /path/to/task_manager/backend
   Environment       : click "..." → add .env.local variables
                       OR set EnvFile path to backend/.env.local
4. Click OK
```

**Step 5:** Set breakpoint and click the green bug icon.

- PyCharm runs the code locally
- Connects to PostgreSQL in Docker
- Stops at your breakpoint.
