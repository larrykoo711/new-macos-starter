# 中国网络环境完整指南

中国大陆网络访问 GitHub、Homebrew、npm、Docker Hub 等海外服务时常见超时或下载缓慢。
本章把仓库内零散的代理/镜像配置串成一份可执行清单。

---

## 一、代理客户端

推荐 **Clash Verge Rev**（开源 GUI，基于 Clash.Meta 内核）。

```bash
brew install --cask clash-verge-rev
```

启动后默认监听 **HTTP/HTTPS 7890** 与 **SOCKS5 7890**（或 7891）。下面所有
配置假设端口为 7890。

> 也可用 ClashX、Mihomo、Surge、V2RayN 等。改端口的话用环境变量覆盖：
> ```bash
> export PROXY_PORT=7891   # 写到 ~/.zshrc.local 持久化
> ```

---

## 二、Shell 代理

`configs/shell/.zshrc` v0.2 提供两个语义化函数：

```bash
proxy           # 通用启用：HTTP/HTTPS/SOCKS5 全部走 127.0.0.1:$PROXY_PORT
proxy_off       # 关闭

clash           # Clash 用户的语义别名（等价 proxy）
clash_off       # 等价 proxy_off
```

终端启动时自动开启代理（中国网络环境推荐）：

```bash
# 在 ~/.zshrc 末尾或 ~/.zshrc.local 中加一行
proxy
```

Git 走代理（一次性持久化）：

```bash
git_proxy        # git config --global http.proxy
git_proxy_off    # 取消
```

---

## 三、Homebrew 加速

### 方案 1：清华源（最稳定）

```bash
# 修改 brew shellenv 之前先设置环境变量（写入 ~/.zprofile）
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"

# 重新初始化已有仓库
brew update
```

### 方案 2：直接走代理（更通用）

代理已开启时，brew 会自动继承 `https_proxy`，不用额外配置。

---

## 四、npm / pnpm 镜像

`configs/npm/.npmrc` 默认走 `npmjs.org`。中国用户取消注释下面两行：

```ini
registry=https://registry.npmmirror.com/
disturl=https://npmmirror.com/dist
```

部分二进制包（sharp、electron、puppeteer）需要单独镜像 — 模板尾部已给注释，按需取消。

---

## 五、Go module 代理

```bash
# 写入 ~/.zshrc 或 ~/.zshrc.local
export GOPROXY=https://goproxy.cn,direct
export GOSUMDB=sum.golang.google.cn   # 可选，加速校验
```

---

## 六、Docker / OrbStack 镜像加速

OrbStack 在 Settings → Docker → Registry mirrors 添加：

- `https://docker.mirrors.ustc.edu.cn`
- `https://hub-mirror.c.163.com`

或编辑 `~/.docker/daemon.json`：

```json
{
  "registry-mirrors": [
    "https://docker.mirrors.ustc.edu.cn",
    "https://hub-mirror.c.163.com"
  ]
}
```

---

## 七、Python pip 镜像

```bash
# 临时
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple <package>

# 持久化（写入 ~/.pip/pip.conf）
mkdir -p ~/.pip
cat > ~/.pip/pip.conf <<'EOF'
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = pypi.tuna.tsinghua.edu.cn
EOF
```

uv 自动遵循 `pip.conf`，无需额外配置。

---

## 八、GitHub 加速

代理开启时 git clone 即可走代理。也可用：

- **GitHub Proxy**：`https://ghproxy.com/` 前缀（仅 raw 文件）
- **fastgit**：替换 `github.com` → `hub.fastgit.org`
- **gitclone**：`git clone https://gitclone.com/github.com/<user>/<repo>`

---

## 九、一键开关脚本（可选）

把以下函数加到 `~/.zshrc.local`，一条命令切换全部代理：

```bash
function on_china_mode() {
    proxy
    git_proxy
    export GOPROXY=https://goproxy.cn,direct
    export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
    echo "China-mirror mode ON"
}

function off_china_mode() {
    proxy_off
    git_proxy_off
    unset GOPROXY HOMEBREW_API_DOMAIN
    echo "China-mirror mode OFF"
}
```

---

## 验证清单

```bash
# 代理生效
curl -s https://api.github.com/zen   # 应该秒回，看到一句禅语

# Homebrew 镜像
brew config | grep -i domain          # 看到 tsinghua

# npm 镜像
npm config get registry               # 看到 npmmirror.com

# Go module
go env GOPROXY                        # 看到 goproxy.cn

# Docker 镜像
docker info | grep -i mirror          # 看到 ustc.edu.cn
```

---

## 相关文档

- [03-shell.md](03-shell.md) — proxy/clash 函数源码
- [02-homebrew.md](02-homebrew.md) — Homebrew 详细配置
- [05-dev-environment.md](05-dev-environment.md) — npm/Go/Python 开发环境
