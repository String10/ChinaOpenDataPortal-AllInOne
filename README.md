# ChinaOpenDataPortal All in One

Use this command to create an `env.custom.sh`:
``` bash
echo "MAVEN_PATH=$(realpath $(which mvn))\nJAVA_PATH=$(realpath $(which java))" >> ./scripts/env.custom.sh
```

## API Server & Backend

Github Repo: cqsss/ChinaOpenDataPortal

### Script Usage

Use `scripts/start-server.sh` to start a process as API server and backend.
Append more arguments as you need like `./scripts/start-server.sh --server.port=9998`.

Environmet variables you may want to specify in `env.custom.sh`:
1. MAVEN_PATH
1. JAVA_PATH (Java 11 Recommended)
1. ADMIN_USER
1. ADMIN_PSWD

## Data Processor

Github Repos:
1. String10/ChinaOpenDataPortal-Metadata
2. String10/ChinaOpenDataPortal-IndexBuilder
