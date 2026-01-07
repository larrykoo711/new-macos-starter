# 01. System Setup

> macOS 系统初始化配置

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

```bash
# 安装命令行工具 (必须)
xcode-select --install

# 验证安装
xcode-select -p
# 输出: /Library/Developer/CommandLineTools
```

### 3. Rosetta 2 (Apple Silicon Only)

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

## Security Settings

### 1. FileVault (磁盘加密)

```
System Settings → Privacy & Security → FileVault → Turn On
```

### 2. Firewall

```bash
# 启用防火墙
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# 查看状态
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
```

### 3. Gatekeeper

```bash
# 查看当前设置
spctl --status

# 允许 App Store 和已识别开发者的应用 (推荐)
sudo spctl --master-enable
```

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

## Network Configuration

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

## Next Steps

完成系统初始化后，继续 [02. Homebrew](02-homebrew.md) 安装包管理器。
