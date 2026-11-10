cask "networkmonitor" do
  version "1.29.0"
  sha256 "ec5689fe46f32d47378a5d9f5168558b7e3a93248194db3798396589ef8582a3"

  url "https://github.com/kevinabouhanna/NetworkMonitor/releases/download/v#{version}/NetworkMonitor.dmg"
  name "NetworkMonitor"
  desc "Menu bar network speed, per-app data usage and firewall"
  homepage "https://kevinabouhanna.github.io/NetworkMonitor/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "NetworkMonitor.app"

  # Quit first, then put back what Hotspot mode changed (its helper's changes
  # too), from the app's own record, while the app that reads it is still there,
  # as Scripts/uninstall.sh does. The launchctl label is the LaunchAgent that
  # versions before the SMAppService login item installed.
  uninstall launchctl: "com.kevinabouhanna.NetworkMonitor",
            quit:      "com.kevinabouhanna.NetworkMonitor",
            script:    {
              executable:   "/bin/sh",
              args:         [
                "-c",
                '[ -x "$0" ] && "$0" --revert-metering; exit 0',
                "#{appdir}/NetworkMonitor.app/Contents/MacOS/NetworkMonitor",
              ],
              must_succeed: false,
            }

  # Withdraws the login item and the helper's registration, which only the app
  # can do. Here rather than in `uninstall`, so a reinstall keeps them.
  zap script: {
        executable:   "/bin/sh",
        args:         [
          "-c",
          '[ -x "$0" ] && "$0" --unregister-login-item; exit 0',
          "#{appdir}/NetworkMonitor.app/Contents/MacOS/NetworkMonitor",
        ],
        must_succeed: false,
      },
      trash:  [
        "~/Library/Application Support/NetworkMonitor",
        "~/Library/Caches/com.kevinabouhanna.NetworkMonitor",
        "~/Library/HTTPStorages/com.kevinabouhanna.NetworkMonitor",
        "~/Library/HTTPStorages/com.kevinabouhanna.NetworkMonitor.binarycookies",
        "~/Library/Preferences/com.kevinabouhanna.NetworkMonitor.plist",
      ]

  caveats <<~EOS
    To remove NetworkMonitor completely, choose Uninstall NetworkMonitor… in its
    menu (right-click the menu bar readout) before `brew uninstall`. It removes the
    content filter (a system extension macOS may finish removing at the next
    restart) and the Hotspot mode helper, and puts back every setting they changed.
  EOS
end
