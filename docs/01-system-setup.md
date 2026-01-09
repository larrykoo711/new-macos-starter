# 01. System Setup

> macOS 系统初始化配置

**图例**: 🆓 免费开源 | 💰 付费 | 🔄 Freemium | 📦 Homebrew 可安装

---

## Prerequisites

- macOS Sequoia 15+ (推荐)
- Apple Silicon (M1/M2/M3/M4) 或 Intel Mac
- Admin 权限

## First Boot Checklist

### 1. System Update

```bash
# 检查系统更新
softwareupdate --list

# 安装所有更新
softwareupdate --install --all
```

### 2. Xcode Command Line Tools

> 🆓 **免费** | Apple 提供

开发必须的命令行工具，包含 Git、Make、编译器等。

```bash
# 安装命令行工具 (必须)
xcode-select --install

# 验证安装
xcode-select -p
# 输出: /Library/Developer/CommandLineTools
```

### 3. Rosetta 2 (Apple Silicon Only)

> 🆓 **免费** | Apple 提供

用于在 Apple Silicon Mac 上运行 x86 应用。

```bash
# 安装 Rosetta 2 用于运行 x86 应用
softwareupdate --install-rosetta --agree-to-license
```

### 4. 系统信息确认

```bash
# 查看系统版本
sw_vers

# 查看硬件信息
system_profiler SPHardwareDataType

# 查看架构
uname -m
# arm64 = Apple Silicon
# x86_64 = Intel
```

---

## Security Settings

### 1. FileVault (磁盘加密)

> 🆓 **免费** | macOS 内置

```
System Settings → Privacy & Security → FileVault → Turn On
```

### 2. Firewall

> 🆓 **免费** | macOS 内置

```bash
# 启用防火墙
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# 查看状态
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
```

### 3. Gatekeeper

> 🆓 **免费** | macOS 内置

```bash
# 查看当前设置
spctl --status

# 允许 App Store 和已识别开发者的应用 (推荐)
sudo spctl --master-enable
```

---

## Terminal Access

### Full Disk Access

为终端应用授予完全磁盘访问权限：

```
System Settings → Privacy & Security → Full Disk Access
→ 添加 Terminal.app 或 iTerm.app
```

### Developer Mode

```bash
# 启用开发者模式
sudo DevToolsSecurity -enable
```

---

## Network Configuration

### 网络代理 (中国用户)

在安装开发工具前，建议先配置网络代理以确保顺利访问 GitHub 等资源。

常用代理工具：

| 工具 | 说明 | 定价 | 获取方式 |
|------|------|------|----------|
| **网络代理工具** | 科学上网 | 🔄 按需选择 | 自行配置 |

**代理配置验证：**

```bash
# 测试 GitHub 连接
curl -s --connect-timeout 5 https://github.com > /dev/null 2>&1 && echo "✅ GitHub: accessible" || echo "❌ GitHub: not accessible"

# 测试 Google 连接
curl -s --connect-timeout 5 https://www.google.com > /dev/null 2>&1 && echo "✅ Google: accessible" || echo "❌ Google: not accessible"
```

**设置终端代理：**

```bash
# 临时设置 (本次会话)
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"
export all_proxy="socks5://127.0.0.1:7890"

# 验证代理
curl -s -XGET "http://ip-api.com/json" | jq
```

### DNS (推荐配置)

```
System Settings → Network → [Your Network] → Details → DNS
```

推荐 DNS 服务器：
- Cloudflare: `1.1.1.1`, `1.0.0.1`
- Google: `8.8.8.8`, `8.8.4.4`

### Hostname

```bash
# 设置主机名
sudo scutil --set ComputerName "YourMacBook"
sudo scutil --set HostName "yourmacbook"
sudo scutil --set LocalHostName "yourmacbook"

# 刷新
dscacheutil -flushcache
```

---

## 快速检查脚本

```bash
#!/bin/bash
# system-check.sh

echo "=== macOS System Check ==="

echo ""
echo "📋 System Info:"
sw_vers

echo ""
echo "🔧 Architecture:"
uname -m

echo ""
echo "🛠️ Xcode CLI Tools:"
xcode-select -p 2>/dev/null && echo "✅ Installed" || echo "❌ Not installed"

echo ""
echo "🌐 Network Connectivity:"
curl -s --connect-timeout 5 https://github.com > /dev/null 2>&1 && echo "✅ GitHub: accessible" || echo "❌ GitHub: not accessible"
curl -s --connect-timeout 5 https://raw.githubusercontent.com > /dev/null 2>&1 && echo "✅ Homebrew: accessible" || echo "❌ Homebrew: not accessible"

echo ""
echo "🔒 Security:"
/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate 2>/dev/null | grep -q "enabled" && echo "✅ Firewall: enabled" || echo "⚠️ Firewall: disabled"
fdesetup status 2>/dev/null | grep -q "On" && echo "✅ FileVault: enabled" || echo "⚠️ FileVault: disabled"

echo ""
echo "=== Check Complete ==="
```

## Next Steps

完成系统初始化后，继续 [02. Homebrew](02-homebrew.md) 安装包管理器。
