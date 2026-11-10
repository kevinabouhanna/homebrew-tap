# Homebrew tap for NetworkMonitor

English · [简体中文](#简体中文)

[NetworkMonitor](https://kevinabouhanna.github.io/NetworkMonitor/) shows your live
network speed in the Mac's menu bar, which apps used your data, and is a free,
open-source firewall. Install it with [Homebrew](https://brew.sh):

```sh
brew install --cask kevinabouhanna/tap/networkmonitor
```

It runs on macOS 13 or later. Once installed, it updates itself; `brew upgrade`
leaves it alone unless you ask with `--greedy`.

**To uninstall,** choose **Uninstall NetworkMonitor…** in its menu (right-click the
menu bar readout) first: it removes the content filter and the helper, and puts back
every setting it changed. Then `brew uninstall --cask networkmonitor`.

The cask follows each [release](https://github.com/kevinabouhanna/NetworkMonitor/releases)
by itself: a daily workflow here updates its version and SHA-256.

## 简体中文

[NetworkMonitor](https://kevinabouhanna.github.io/NetworkMonitor/zh/) 在 Mac 的菜单栏中显示实时网速、哪些应用用了你的流量，也是一个免费的开源防火墙。用 [Homebrew](https://brew.sh) 安装：

```sh
brew install --cask kevinabouhanna/tap/networkmonitor
```

适用于 macOS 13 或更高版本。安装后它会自己更新；除非你加上 `--greedy`，`brew upgrade` 不会更新它。

**卸载时，**请先在它的菜单中选择 **卸载 NetworkMonitor…**（右键点按菜单栏读数）：它会移除内容过滤器和辅助程序，并恢复它更改过的每项设置。然后运行 `brew uninstall --cask networkmonitor`。

这个 cask 会自己跟上每个[版本](https://github.com/kevinabouhanna/NetworkMonitor/releases)：这里每天运行的工作流会更新它的版本号和 SHA-256。
