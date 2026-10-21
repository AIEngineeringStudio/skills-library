# Docker Commands — Comprehensive Reference

---

## Glossary — Key Terms

| Term          | Definition                                          |
|---------------|-----------------------------------------------------|
| **Image**     | Read-only blueprint for a container                 |
| **Container** | Running instance of an image                        |
| **Volume**    | Persistent storage outside the container filesystem |
| **Service**   | A named container defined in `docker-compose.yml`   |
| **Compose**   | Tool for managing multi-container applications      |
| **Registry**  | Remote store for Docker images (e.g. Docker Hub)    |
| **Tag**       | Label on an image, e.g. `myimage:1.0.0` or `latest` |
| **SIGTERM**   | Graceful stop signal — container can clean up first |
| **SIGKILL**   | Immediate termination — no cleanup                  |

---

## 0. Version & Info

```bash
docker --version          # Show Docker version installed
docker info               # Show system-wide Docker info
```

---

## 1. Registry — Pull & Search

```bash
# Pull image from registry (Docker Hub by default)
docker pull <repo>:<tag>
# Ex: docker pull in28min/todo-rest-api-h2:1.0.0.RELEASE

# Search Docker Hub for images matching keyword
docker search <keyword>
# Ex: docker search mysql

# Push a local image to a registry
docker push <repo>:<tag>
```

> If no tag is specified, Docker uses `latest` by default.
> Note: `latest` is just a label — it may not be the newest version.

---

## 2. Images

> **Purpose:** Manage local Docker images.

```bash
# List all local images (all three are equivalent)
docker images
docker images ls
docker image ls

# Pull image (see Section 1)
docker pull <repo>:<tag>

# Tag an existing image with a new name/tag
docker tag <repo>:<current-tag> <repo>:<new-tag>
# Ex: docker tag myapp:1.0.0 myapp:latest

# View the build steps (layers) of an image
docker image history <image-id>

# View full metadata/config of an image
docker image inspect <image-id>

# Remove an image (two equivalent forms)
docker rmi <image-id>
docker image remove <image-id>

# Remove dangling images only (untagged, unused)
docker image prune

# Remove ALL unused images
docker image prune -a
```

> **Dangling image:** An image with no tag and no container using it.

---

## 3. Containers — Run

> **Purpose:** Start containers from images with various options.

```bash
# Basic run — map host-port to container-port
docker container run -p <host-port>:<container-port> <repo>:<tag>
docker run -p 5000:5000 in28min/todo-rest-api-h2:1.0.0.RELEASE

# Run in detached mode (background)
docker run -p 5000:5000 -d <repo>:<tag>

# Run with memory limit (-m)
# Values: 512m, 1g, etc.
docker run -p 5000:5000 -d -m 512m <repo>:<tag>

# Run with CPU limit (--cpu-quota)
# Total quota = 100000 (100%). 50000 = 50% of one CPU.
docker run -p 5000:5000 -d -m 512m --cpu-quota 50000 <repo>:<tag>

# Run with restart policy (--restart)
# Values: no (default) | always | on-failure | unless-stopped
# 'always' restarts the container automatically after Docker restarts.
docker run -p 5000:5000 -d --restart=always <repo>:<tag>

# Run interactively with a terminal (-it)
docker run -it <repo>:<tag> bash

# Run with a custom name (--name)
docker run --name mycontainer -d <repo>:<tag>

# Run and publish all exposed ports to random host ports (-P)
docker run -P <repo>:<tag>

# Run a new container and open a shell (does not use existing container)
docker run -it <image> bash
```

---

## 4. Containers — List & Status

```bash
# List running containers (three equivalent forms)
docker ps
docker container ls
docker compose ps          # Compose services only

# List ALL containers including stopped ones
docker ps -a
docker container ls -a

# Filter by status
docker ps --filter "status=exited"
docker container ls -f "status=exited"
docker ps -a | grep <partial-id>

# List all containers including stopped (Compose)
docker compose ps --all
```

---

## 5. Containers — Stop, Kill, Pause

```bash
# Graceful stop — sends SIGTERM (container can clean up)
docker stop <container-id>
docker container stop <container-id>

# Immediate termination — sends SIGKILL (no cleanup)
docker kill <container-id>
docker container kill <container-id>

# Pause a container (freeze its state)
docker container pause <container-id>

# Resume a paused container
docker container unpause <container-id>
```

> Use `stop` in normal operations.
> Use `kill` only if the container is stuck and not responding to `stop`.

---

## 6. Containers — Inspect & Debug

```bash
# View full metadata of a container (best debugging tool)
docker container inspect <container-id>
docker inspect <container-id>

# View live processes running inside a container
docker top <container-id>

# View logs from a container
docker logs <container-id>
docker logs -f <container-id>      # Follow (live tail)

# View recent events from the Docker daemon
docker events

# Open a shell inside a RUNNING container
docker compose exec <svc> bash
docker compose exec <svc> sh      # Alpine images use sh
```

---

## 7. Containers — Remove

```bash
# Remove a specific stopped container
docker rm <container-id>

# Remove all stopped containers
docker container prune

# Force remove a running container
docker rm -f <container-id>
```

---

## 8. Stack Control (Compose)

> **Purpose:** Start, stop, and manage the full multi-container stack.

| Command                           | What It Does                             |
|-----------------------------------|------------------------------------------|
| `docker compose up`               | Start all services (foreground)          |
| `docker compose up -d`            | Start all services in background         |
| `docker compose up --build`       | Rebuild images first, then start         |
| `docker compose up --build <svc>` | Rebuild + start one service only         |
| `docker compose down`             | Stop + remove containers                 |
| `docker compose down -v`          | Stop + remove containers **and volumes** |
| `docker compose stop`             | Stop all containers (keep them)          |
| `docker compose stop <svc>`       | Stop one service only                    |
| `docker compose start`            | Start previously stopped containers      |
| `docker compose restart <svc>`    | Restart one service without rebuilding   |

> ⚠️ `down -v` **deletes all volume data** (e.g. Postgres database).

---

## 9. Logs (Compose)

| Command                                  | What It Does                     |
|------------------------------------------|----------------------------------|
| `docker compose logs`                    | Show all service logs            |
| `docker compose logs <svc>`              | Show logs for one service        |
| `docker compose logs -f <svc>`           | Live stream (follow) logs        |
| `docker compose logs --tail=50 <svc>`    | Show last 50 lines only          |
| `docker compose logs --since=1h <svc>`   | Logs from the last hour          |
| `docker compose logs --timestamps <svc>` | Show timestamps alongside output |

---

## 10. Shell Access — exec (Compose)

```bash
docker compose exec backend bash      # Open shell in backend service
docker compose exec db bash           # Open shell in postgres
docker compose exec redis bash        # Open shell in redis

# Run a one-off command in a service
docker compose exec <svc> <command>
```

> Use `sh` instead of `bash` on Alpine-based images.

---

## 11. Database — PostgreSQL

```bash
# Open interactive psql shell
docker compose exec db psql -U postgres

# Run a single SQL query inline
docker compose exec db psql -U postgres -c "SELECT * FROM users;"

# List all databases
docker compose exec db psql -U postgres -l

# Dump a database to file
docker compose exec db pg_dump -U postgres mydb > backup.sql

# Restore a database from file
docker compose exec -T db psql -U postgres mydb < backup.sql
```

---

## 12. Redis

```bash
docker compose exec redis redis-cli           # Open Redis CLI
docker compose exec redis redis-cli ping      # Test: returns PONG
docker compose exec redis redis-cli keys "*"  # List all keys
docker compose exec redis redis-cli get <key> # Get value of key
docker compose exec redis redis-cli del <key> # Delete a key
docker compose exec redis redis-cli flushall  # ⚠️ Wipe all data
```

---

## 13. Images (Compose)

| Command                                    | What It Does                        |
|--------------------------------------------|-------------------------------------|
| `docker compose build`                     | Build all services                  |
| `docker compose build <svc>`               | Build one service only              |
| `docker compose build --no-cache <svc>`    | Force full rebuild (no layer cache) |
| `docker build -t myimage:latest .`         | Build standalone image with tag     |
| `docker build -f Dockerfile.prod -t img .` | Build using alternate Dockerfile    |

> Use `--no-cache` when Dockerfile changes are not being picked up.

---

## 14. Volumes

| Command                       | What It Does                    |
|-------------------------------|---------------------------------|
| `docker volume ls`            | List all volumes                |
| `docker volume inspect <vol>` | Show volume details + host path |
| `docker volume rm <vol>`      | Delete a specific volume ⚠️     |
| `docker volume prune`         | Remove all unused volumes ⚠️    |

### If you want to remove ALL volumes (including used ones):

**Step 1:** Stop containers

```bash
docker stop $(docker ps -aq)
```

**Step 2:** Remove containers

```bash
docker rm $(docker ps -aq)
```

**Step 3:** Remove all volumes

```bash
docker volume rm $(docker volume ls -q)
```

---

## 15. Networking

```bash
docker network ls                            # List all Docker networks
docker network inspect <network-name>        # See connected containers

# Test connectivity from inside a container
docker compose exec backend ping db          # Ping by service name

# Check open ports inside a container
docker compose exec backend netstat -tlnp
```

> Services on the same Compose network can reach each other
> by **service name** (e.g. `db`, `redis`).

---

## 16. Resource Monitoring

```bash
docker stats                    # Live CPU + RAM per container
docker stats --no-stream        # Single snapshot, no live feed
docker compose top              # Processes per Compose service
docker top <container-id>       # Processes in one container
docker inspect <id>             # Full config + network info (JSON)
docker system df                # Disk usage: images/volumes/cache
```

---

## 17. Cleanup — Free Disk Space

| Command                     | Removes                                  |
|-----------------------------|------------------------------------------|
| `docker system prune`       | Stopped containers, unused networks,     |
|                             | dangling images, build cache             |
| `docker system prune -a`    | + all unused images                      |
| `docker system prune -a -v` | + all unused volumes ⚠️ All data deleted |
| `docker container prune`    | Stopped containers only                  |
| `docker image prune`        | Dangling images only                     |
| `docker image prune -a`     | All unused images                        |
| `docker volume prune`       | Unused volumes only ⚠️                   |
| `docker network prune`      | Unused networks only                     |

> Run `docker system df` first to see what can be reclaimed.

---

## 18. File Copy — docker cp

> **Purpose:** Copy files between host and a container.

```bash
# Copy FROM container TO host
docker cp <container-id>:/path/in/container ./local/path
# Ex: docker cp mycontainer:/app/logs/error.log ./error.log

# Copy FROM host TO container
docker cp ./local/file <container-id>:/path/in/container
# Ex: docker cp ./config.json mycontainer:/app/config.json

# Works on stopped containers too
docker compose cp <svc>:/path/in/container ./local/path
```

> Useful for extracting log files, config dumps, or
> injecting a file without rebuilding the image.

---

## 19. Commit a Container

> **Purpose:** Save a modified running container as a new image.

```bash
# Commit a container to a new image
docker commit <container-id> <new-image-name>:<tag>
# Ex: docker commit abc123 myapp-debug:v1

# View the new image
docker images
```

> ⚠️ Avoid using `commit` for production images.
> Use a `Dockerfile` instead — it is reproducible and
> version-controlled. `commit` is useful for quick
> debugging snapshots only.

---

## 20. Registry — Login & Logout

> **Purpose:** Authenticate to push/pull from private registries.

```bash
# Login to Docker Hub (prompts for credentials)
docker login

# Login to a private registry
docker login <registry-url>
# Ex: docker login registry.mycompany.com

# Logout
docker logout
docker logout <registry-url>

# Push a local image to a registry (must be logged in)
docker push <repo>:<tag>
# Ex: docker push mycompany/myapp:1.0.0
```

---

## 21. Compose Config & Profiles

> **Purpose:** Validate Compose files and manage service groups.

```bash
# Validate + view the fully resolved Compose config
# (shows variable substitution, merged files, etc.)
docker compose config

# List all defined Compose services
docker compose config --services

# Start only services belonging to a profile
docker compose --profile <profile-name> up -d
# Ex: docker compose --profile debug up -d

# Start specific services by name
docker compose up -d backend db    # skips redis, etc.
```

> `docker compose config` is the first command to run
> when debugging why a service is not behaving as expected.

---

## 22. Port & Diff Inspection

> **Purpose:** Quick container state checks.

```bash
# Show port mappings for a container
docker port <container-id>
# Ex output: 5000/tcp -> 0.0.0.0:5000

# Show filesystem changes made inside a container
# since it started (A=added, C=changed, D=deleted)
docker diff <container-id>
```

---

## 23. Project Shortcuts (Makefile)

| Command       | Equivalent                     |
|---------------|--------------------------------|
| `make up`     | `docker compose up -d`         |
| `make down`   | `docker compose down`          |
| `make build`  | `docker compose build`         |
| `make logs`   | `docker compose logs -f`       |
| `make health` | `curl localhost/api/v1/health` |

---

## Quick Decision Guide

```
Starting the app?               → docker compose up -d
Something broken? Check logs:   → docker compose logs -f <svc>
Debug inside container:         → docker compose exec <svc> bash
Need a fresh container (no Compose):
                                → docker run -it <image> bash
Database empty or needs reset:  → docker compose down -v && up --build
Image changes not applying:     → docker compose build --no-cache <svc>
Container stuck, won't stop:    → docker kill <container-id>
Reclaim disk space:             → docker system df → docker system prune -a
Compose file not behaving?      → docker compose config
Extract file from container:    → docker cp <id>:/path ./local
Push image to registry:         → docker login → docker push <repo>:<tag>
```

---

## ⚠️ Destructive Commands — Summary

| Command                     | Risk                               |
|-----------------------------|------------------------------------|
| `docker compose down -v`    | Deletes all Compose volume data    |
| `docker volume rm <vol>`    | Deletes one specific volume        |
| `docker volume prune`       | Deletes all unused volumes         |
| `docker system prune -a -v` | Deletes everything                 |
| `docker rm -f <id>`         | Force-removes a running container  |
| `docker kill <id>`          | Terminates container immediately   |
| `redis-cli flushall`        | Wipes Redis cache completely       |
| `docker commit <id> <img>`  | Snapshots container (not for prod) |