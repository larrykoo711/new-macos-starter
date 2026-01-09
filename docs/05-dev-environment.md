# 05. Development Environment

> 开发环境配置 - Git, Node.js, Python, Go, Container

**图例**: 🆓 免费开源 | 💰 付费 | 🔄 Freemium | 📦 Homebrew 可安装

---

## Git

### Installation

| 工具 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **git** | 版本控制系统 | 🆓 开源免费 | 📦 `brew install git` |
| **gh** | GitHub CLI | 🆓 开源免费 | 📦 `brew install gh` |
| **delta** | 更好的 git diff | 🆓 开源免费 | 📦 `brew install delta` |

```bash
brew install git gh delta
```

### Global Configuration

```bash
# 用户信息
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# 默认分支
git config --global init.defaultBranch main

# 编辑器
git config --global core.editor "code --wait"

# Pull 策略
git config --global pull.rebase true

# 自动设置远程跟踪
git config --global push.autoSetupRemote true
```

### ~/.gitconfig

```ini
[user]
    name = Your Name
    email = your.email@example.com

[init]
    defaultBranch = main

[core]
    editor = code --wait
    autocrlf = input
    excludesfile = ~/.gitignore_global
    pager = delta

[push]
    autoSetupRemote = true
    default = current

[pull]
    rebase = true

[fetch]
    prune = true

[rebase]
    autoStash = true

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = zebra

[alias]
    st = status -sb
    lg = log --oneline --graph --decorate
    co = checkout
    cob = checkout -b
    cm = commit -m
    df = diff
    ds = diff --staged
    unstage = reset HEAD --
    undo = reset --soft HEAD~1

[credential]
    helper = osxkeychain

[delta]
    navigate = true
    side-by-side = true
    line-numbers = true
```

### SSH Keys

```bash
# 生成 SSH Key (Ed25519)
ssh-keygen -t ed25519 -C "your.email@example.com"

# 添加到 SSH Agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# 复制公钥到 GitHub
gh ssh-key add ~/.ssh/id_ed25519.pub
```

### ~/.ssh/config

```
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    AddKeysToAgent yes
    UseKeychain yes
```

---

## Node.js

### 工具总览

| 工具 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **fnm** | 快速 Node 版本管理器 | 🆓 开源免费 | 📦 `brew install fnm` |
| **pnpm** | 高效包管理器 | 🆓 开源免费 | `corepack enable` |

### fnm (Fast Node Manager)

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/Schniz/fnm)

```bash
brew install fnm

# 添加到 ~/.zshrc
echo 'eval "$(fnm env --use-on-cd)"' >> ~/.zshrc
```

### Usage

```bash
# 安装 Node.js
fnm install 22        # 安装 v22
fnm install --lts     # 安装 LTS

# 切换版本
fnm use 22
fnm default 22

# 列出版本
fnm list
fnm list-remote
```

### pnpm

> 🆓 **开源免费** | [官网](https://pnpm.io)

```bash
# 启用 corepack
corepack enable
corepack prepare pnpm@latest --activate

# 验证
pnpm -v
```

### ~/.npmrc

```ini
# 镜像源 (中国用户)
registry=https://registry.npmmirror.com

# pnpm 配置
shamefully-hoist=true
auto-install-peers=true
```

### Global Packages

```bash
pnpm add -g typescript ts-node
pnpm add -g vercel
pnpm add -g wrangler
```

### Project Setup

```bash
# 项目根目录创建 .nvmrc
echo "22" > .nvmrc

# fnm 自动切换版本 (需要 --use-on-cd)
```

---

## Python

### 工具总览

| 工具 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **uv** | Rust 构建的 Python 工具链 | 🆓 开源免费 | 📦 `brew install uv` |
| **ruff** | 极速 Python Linter | 🆓 开源免费 | `uv add --dev ruff` |

### uv (Python 全环境管理)

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/astral-sh/uv)

uv 是 Rust 构建的极速 Python 工具链，可管理 Python 版本和依赖。

```bash
brew install uv
```

**不建议**直接安装 `python@3.x`，让 uv 管理所有 Python 环境。

### Python 版本管理

```bash
# 安装 Python 版本
uv python install 3.12
uv python install 3.13

# 列出已安装版本
uv python list

# 设置项目 Python 版本
uv python pin 3.12
```

### Usage

```bash
# 初始化项目
uv init my-project

# 添加依赖
uv add requests
uv add --dev pytest ruff

# 同步依赖
uv sync

# 运行脚本
uv run python script.py
uv run pytest
```

### pyproject.toml

```toml
[project]
name = "my-project"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = [
    "httpx>=0.27.0",
    "pydantic>=2.0.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=8.0.0",
    "ruff>=0.4.0",
    "mypy>=1.10.0",
]

[tool.ruff]
line-length = 88
target-version = "py312"

[tool.ruff.lint]
select = ["E", "W", "F", "I", "B", "C4", "UP"]

[tool.mypy]
python_version = "3.12"
strict = true
```

### Ruff (Linter)

> 🆓 **开源免费** | [GitHub](https://github.com/astral-sh/ruff)

```bash
uv add --dev ruff

# 检查
ruff check .

# 自动修复
ruff check --fix .

# 格式化
ruff format .
```

---

## Go

### 工具总览

| 工具 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **goenv** | Go 版本管理器 | 🆓 开源免费 | 📦 `brew install goenv` |
| **go** | Go 语言 | 🆓 开源免费 | 📦 `brew install go` |
| **golangci-lint** | Go 代码检查 | 🆓 开源免费 | 📦 `brew install golangci-lint` |
| **air** | 热重载工具 | 🆓 开源免费 | `go install` |

### goenv (版本管理)

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/go-nv/goenv)

```bash
brew install goenv
brew install go

# 添加到 ~/.zshrc
echo 'eval "$(goenv init -)"' >> ~/.zshrc
echo 'export GOPATH="$HOME/go"' >> ~/.zshrc
echo 'export PATH="$GOPATH/bin:$PATH"' >> ~/.zshrc
```

### Usage

```bash
# 安装 Go 版本
goenv install 1.23.9
goenv global 1.23.9

# 初始化项目
go mod init github.com/username/project

# 常用命令
go run .
go build -o bin/app .
go test ./...
go mod tidy
```

### 环境变量

```bash
# ~/.zshrc
export GOPATH="$HOME/go"
export GOROOT="$(go env GOROOT)"
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
export GO111MODULE=on
export GOPROXY="https://goproxy.cn,direct"  # 中国用户
```

### golangci-lint

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/golangci/golangci-lint)

```bash
brew install golangci-lint

# 运行
golangci-lint run
golangci-lint run --fix
```

### Air (Hot Reload)

> 🆓 **开源免费** | [GitHub](https://github.com/air-verse/air)

```bash
go install github.com/air-verse/air@latest

# 初始化
air init

# 运行
air
```

---

## Container & Kubernetes

### 工具总览

| 工具 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **OrbStack** | 轻量级 Docker/K8s | 🔄 个人免费/Pro $8/月 | 📦 `brew install --cask orbstack` |
| **kubectl** | K8s 命令行 | 🆓 开源免费 | 📦 `brew install kubectl` |
| **helm** | K8s 包管理器 | 🆓 开源免费 | 📦 `brew install helm` |
| **k9s** | K8s TUI | 🆓 开源免费 | 📦 `brew install k9s` |
| **kubeswitch** | Context 切换 | 🆓 开源免费 | 📦 `brew install danielfoehrkn/switch/switch` |
| **stern** | 多 Pod 日志 | 🆓 开源免费 | 📦 `brew install stern` |

### OrbStack (推荐)

> 🔄 **Freemium** (个人免费/Pro $8/月) | 📦 Homebrew | [官网](https://orbstack.dev)

OrbStack 是 Docker Desktop 的轻量级替代品，性能更好，资源占用更少。

```bash
brew install --cask orbstack
```

**特点：**
- 启动速度快 (~1秒)
- 内存占用低
- 原生支持 Docker 和 Kubernetes
- 内置 Linux 虚拟机管理

### Docker CLI

OrbStack 安装后自动配置 Docker CLI：

```bash
# 验证
docker --version
docker compose version

# 常用命令
docker ps
docker images
docker run -d --name nginx -p 8080:80 nginx
docker logs -f nginx
docker exec -it nginx /bin/bash
docker stop nginx && docker rm nginx
```

### Docker Compose

```yaml
# docker-compose.yml
services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: dev
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: valkey/valkey:8-alpine
    ports:
      - "6379:6379"

  minio:
    image: minio/minio:latest
    command: server /data --console-address ":9001"
    environment:
      MINIO_ROOT_USER: minioadmin
      MINIO_ROOT_PASSWORD: minioadmin
    ports:
      - "9000:9000"
      - "9001:9001"

volumes:
  postgres_data:
```

```bash
docker compose up -d
docker compose ps
docker compose logs -f
docker compose down
```

### Kubernetes (via OrbStack)

OrbStack 内置单节点 Kubernetes 集群：

```bash
# 在 OrbStack 设置中启用 Kubernetes
# 或命令行启用
orb config kubernetes.enabled true
```

### kubectl

> 🆓 **开源免费** | 📦 Homebrew | [官网](https://kubernetes.io/docs/tasks/tools/)

```bash
brew install kubectl

# 验证
kubectl version --client
kubectl cluster-info

# 常用命令
kubectl get pods
kubectl get services
kubectl get deployments
kubectl describe pod <name>
kubectl logs -f <pod-name>
kubectl exec -it <pod-name> -- /bin/sh
kubectl port-forward <pod-name> 8080:80
kubectl apply -f deployment.yaml
```

### Helm

> 🆓 **开源免费** | 📦 Homebrew | [官网](https://helm.sh)

```bash
brew install helm

# 添加仓库
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# 搜索
helm search repo nginx

# 安装
helm install my-nginx bitnami/nginx

# 查看
helm list
helm status my-nginx

# 卸载
helm uninstall my-nginx
```

### kubeswitch (Context 切换)

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/danielfoehrKn/kubeswitch)

```bash
brew install danielfoehrkn/switch/switch

# 添加到 ~/.zshrc
echo 'source <(switcher init zsh)' >> ~/.zshrc
echo 'alias s=switch' >> ~/.zshrc
```

使用：

```bash
# 交互式切换 context
switch
# 或简写
s

# 切换到特定 context
switch my-cluster

# 列出所有 context
switch list
```

### k9s (TUI)

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/derailed/k9s)

```bash
brew install k9s

# 运行
k9s
```

K9s 提供 Kubernetes 集群的终端 UI，支持：
- 查看 Pods、Services、Deployments 等资源
- 实时日志查看
- Shell 进入容器
- 端口转发
- 资源删除/编辑

### stern (多 Pod 日志)

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/stern/stern)

```bash
brew install stern

# 查看匹配的 Pod 日志
stern app-*
stern -n namespace app
```

---

## Cloud & Platform CLI

### 工具总览

| 工具 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **awscli** | AWS 命令行 | 🆓 免费 (AWS 收费) | 📦 `brew install awscli` |
| **google-cloud-sdk** | GCP 命令行 | 🆓 免费 (GCP 收费) | 📦 `brew install google-cloud-sdk` |
| **vercel** | Vercel CLI | 🔄 Freemium | `pnpm add -g vercel` |
| **wrangler** | Cloudflare CLI | 🔄 Freemium | `pnpm add -g wrangler` |
| **rclone** | 通用云存储 CLI | 🆓 开源免费 | 📦 `brew install rclone` |

### AWS CLI

> 🆓 **免费** (AWS 服务收费) | 📦 Homebrew | [官网](https://aws.amazon.com/cli/)

```bash
brew install awscli

# 配置
aws configure
# 输入 Access Key ID, Secret Access Key, Region

# 常用命令
aws s3 ls
aws s3 cp file.txt s3://bucket/
aws ec2 describe-instances
```

### Google Cloud SDK

> 🆓 **免费** (GCP 服务收费) | 📦 Homebrew | [官网](https://cloud.google.com/sdk)

```bash
brew install google-cloud-sdk

# 初始化
gcloud init

# 常用命令
gcloud projects list
gcloud compute instances list
gcloud auth login
```

### Vercel CLI

> 🔄 **Freemium** | [官网](https://vercel.com)

```bash
# 推荐用 pnpm 安装
pnpm add -g vercel

# 登录
vercel login

# 部署
vercel              # 预览部署
vercel --prod       # 生产部署

# 环境变量
vercel env pull     # 拉取环境变量到 .env.local
vercel env add      # 添加环境变量
```

### Cloudflare Wrangler

> 🔄 **Freemium** | [官网](https://developers.cloudflare.com/workers/)

```bash
# 推荐用 pnpm 安装
pnpm add -g wrangler

# 登录
wrangler login

# Workers
wrangler dev        # 本地开发
wrangler deploy     # 部署

# KV / R2
wrangler kv:key list --binding=MY_KV
wrangler r2 object get bucket/key
```

### rclone (通用云存储)

> 🆓 **开源免费** | 📦 Homebrew | [官网](https://rclone.org)

```bash
brew install rclone

# 配置 (交互式)
rclone config

# 常用命令
rclone ls remote:bucket
rclone copy local/path remote:bucket/path
rclone sync local/path remote:bucket/path
```

---

## Dockerfile Best Practices

### Node.js

```dockerfile
FROM node:22-alpine AS builder
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN corepack enable && pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

FROM node:22-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static
USER nextjs
EXPOSE 3000
CMD ["node", "server.js"]
```

### Go

```dockerfile
FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /app/server ./cmd/server

FROM alpine:3.19
RUN apk --no-cache add ca-certificates
RUN adduser -D appuser
COPY --from=builder /app/server /server
USER appuser
EXPOSE 8080
CMD ["/server"]
```

### Python

```dockerfile
FROM python:3.12-slim AS builder
WORKDIR /app
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

FROM python:3.12-slim
WORKDIR /app
COPY --from=builder /app/.venv ./.venv
COPY . .
ENV PATH="/app/.venv/bin:$PATH"
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

---

## Quick Reference

### 版本检查

```bash
git --version
node -v && npm -v && pnpm -v
python3 --version && uv --version
go version
docker --version
kubectl version --client
helm version
```

### 环境变量 (~/.zshrc)

```bash
# fnm
eval "$(fnm env --use-on-cd)"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Go
eval "$(goenv init -)"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Python
export PATH="$HOME/.local/bin:$PATH"

# kubeswitch
source <(switcher init zsh)
alias s=switch
```

## Next Steps

继续 [06. Editor](06-editor.md) 配置代码编辑器。
