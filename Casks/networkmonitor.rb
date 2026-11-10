cask "networkmonitor" do
  version "1.28.2"
  sha256 "7909e36f882d4a9110467e6af1b8ebf7a870d4c27fe369cef4b74cdc9b25b2d1"

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

  # The LaunchAgent that versions before the SMAppService login item installed.
  uninstall launchctl: "com.kevinabouhanna.NetworkMonitor",
            quit:      "com.kevinabouhanna.NetworkMonitor"

  # Puts back what Hotspot mode changed without its helper, from the app's own
  # record, while the app (which can read it) is still there; as Scripts/uninstall.sh does.
  zap script: {
        executable:   "/bin/sh",
        args:         [
          "-c",
          '[ -x "$0" ] && "$0" --revert-metering || true',
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
