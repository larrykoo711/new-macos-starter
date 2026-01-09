# 00. Troubleshooting

> 常见问题解决方案

**图例**: 🆓 免费开源 | 💰 付费 | 🔄 Freemium | 📦 Homebrew 可安装

---

## 网络问题

### Homebrew 安装失败

**症状**: `curl: (7) Failed to connect to raw.githubusercontent.com`

**原因**: 无法访问 GitHub

**解决方案**:

1. **配置代理**:
```bash
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"
export ALL_PROXY="socks5://127.0.0.1:7890"

# 重新运行安装
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. **使用镜像源** (中国用户):
```bash
# 使用清华镜像
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
```

3. **手动下载安装脚本**:
```bash
# 下载脚本
curl -O https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

# 检查内容后执行
less install.sh
bash install.sh
```

### Git Clone 超时

**症状**: `fatal: unable to access 'https://github.com/...': Failed to connect`

**解决方案**:

```bash
# 设置 Git 代理
git config --global http.proxy "http://127.0.0.1:7890"
git config --global https.proxy "http://127.0.0.1:7890"

# 或使用 SSH 替代 HTTPS
git clone git@github.com:username/repo.git
```

### 验证网络连通性

```bash
# 测试 GitHub
curl -s --connect-timeout 5 https://github.com > /dev/null && echo "OK" || echo "FAIL"

# 测试 Google
curl -s --connect-timeout 5 https://www.google.com > /dev/null && echo "OK" || echo "FAIL"

# 测试代理是否生效
curl -s http://ip-api.com/json | jq .query
```

---

## Xcode 问题

### xcode-select --install 卡住

**症状**: 安装窗口无响应或进度条不动

**解决方案**:

1. **重置并重试**:
```bash
sudo xcode-select --reset
xcode-select --install
```

2. **从 Apple Developer 下载**:
   - 访问 https://developer.apple.com/download/more/
   - 搜索 "Command Line Tools"
   - 下载对应 macOS 版本的 .dmg 文件

3. **通过 Xcode 安装**:
```bash
# 如果已安装 Xcode
xcode-select --install
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

### 许可证问题

**症状**: `Agreeing to the Xcode/iOS license requires admin privileges`

**解决方案**:
```bash
sudo xcodebuild -license accept
```

---

## Rosetta 2 问题 (Apple Silicon)

### 安装失败

**症状**: `Package Authoring Error: ...`

**解决方案**:

1. **使用 softwareupdate**:
```bash
softwareupdate --install-rosetta --agree-to-license
```

2. **手动安装**:
```bash
# 触发 Rosetta 安装
arch -x86_64 /usr/bin/true
```

3. **检查状态**:
```bash
# 检查 Rosetta 是否运行
/usr/bin/pgrep -q oahd && echo "Rosetta running" || echo "Rosetta not running"
```

---

## Shell 问题

### fnm/uv 版本切换不生效

**症状**: 切换版本后 `node -v` 仍显示旧版本

**原因**: Shell 初始化顺序问题或缓存

**解决方案**:

1. **确保在 .zshrc 中正确初始化**:
```bash
# fnm
eval "$(fnm env --use-on-cd)"

# 检查是否在 PATH 中
which node
```

2. **重新加载配置**:
```bash
source ~/.zshrc
# 或重新打开终端
```

3. **清除缓存**:
```bash
hash -r
```

### Starship 提示符不显示

**症状**: 提示符是普通的 `$` 或 `%`

**解决方案**:

1. **确保 Starship 在 .zshrc 末尾**:
```bash
# 必须在最后
eval "$(starship init zsh)"
```

2. **检查字体**:
   - 确保安装了 Nerd Font
   - 终端设置中选择 Nerd Font

3. **验证安装**:
```bash
starship --version
starship explain
```

### Oh-My-Zsh 插件不工作

**症状**: 自动补全或语法高亮不生效

**解决方案**:

1. **检查插件是否安装**:
```bash
ls ~/.oh-my-zsh/custom/plugins/
```

2. **重新安装插件**:
```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

3. **检查 .zshrc 中的 plugins 数组**:
```bash
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)
```

---

## Homebrew 问题

### brew update 失败

**症状**: `error: cannot fetch origin`

**解决方案**:

```bash
# 重置 Homebrew
brew update-reset

# 或手动更新
cd $(brew --repository)
git fetch origin
git reset --hard origin/master
```

### 包安装失败

**症状**: `Error: No available formula with the name "xxx"`

**解决方案**:

1. **更新 Homebrew**:
```bash
brew update
```

2. **搜索正确名称**:
```bash
brew search xxx
```

3. **查看包信息**:
```bash
brew info xxx
```

### Cask 应用无法打开

**症状**: "xxx is damaged and can't be opened"

**解决方案**:

```bash
# 移除隔离属性
xattr -cr /Applications/xxx.app

# 或允许任何来源的应用
sudo spctl --master-disable
```

---

## Docker/OrbStack 问题

### Docker 命令找不到

**症状**: `command not found: docker`

**解决方案**:

1. **确保 OrbStack 正在运行**

2. **检查 Docker CLI 安装**:
```bash
# OrbStack 会自动配置
orb
```

3. **手动创建符号链接**:
```bash
# 通常不需要，OrbStack 会自动处理
```

### 容器无法访问网络

**症状**: 容器内 `curl` 失败

**解决方案**:

1. **检查 DNS 配置**:
```bash
docker run --rm alpine cat /etc/resolv.conf
```

2. **使用 host 网络模式测试**:
```bash
docker run --rm --network host alpine ping -c 1 google.com
```

---

## Python/uv 问题

### Python 版本不正确

**症状**: `python3 --version` 显示系统 Python

**解决方案**:

```bash
# 使用 uv 管理的 Python
uv python list
uv python pin 3.12

# 在项目中使用
uv run python --version
```

### 依赖安装失败

**症状**: `Failed to build xxx`

**解决方案**:

1. **更新 uv**:
```bash
uv self update
```

2. **检查是否需要编译依赖**:
```bash
# 安装 Xcode CLI Tools
xcode-select --install
```

---

## Node.js/fnm 问题

### pnpm 命令找不到

**症状**: `command not found: pnpm`

**解决方案**:

```bash
# 启用 corepack
corepack enable
corepack prepare pnpm@latest --activate

# 或手动安装
npm install -g pnpm
```

### node_modules 权限问题

**症状**: `EACCES: permission denied`

**解决方案**:

```bash
# 修复权限
sudo chown -R $(whoami) ~/.npm
sudo chown -R $(whoami) ~/.pnpm-store
```

---

## 验证安装

运行验证脚本检查所有工具:

```bash
./scripts/verify.sh
```

---

## 获取帮助

如果以上方案都无法解决问题:

1. **查看 GitHub Issues**: [Issues](https://github.com/larrykoo711/new-macos-starter/issues)
2. **提交新 Issue**: 请附上:
   - macOS 版本 (`sw_vers`)
   - 架构 (`uname -m`)
   - 完整错误信息
   - 已尝试的解决方案

---

## Next Steps

返回 [README](../README.md) 或继续 [01. System Setup](01-system-setup.md)。
