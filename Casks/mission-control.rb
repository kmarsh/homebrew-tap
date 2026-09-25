cask "mission-control" do
  version "0.3.0"
  sha256 "6d6a578087220ff9715148f6b00075f25bace4600d0fa2575ff60dd25ad200ec"

  url "https://f000.backblazeb2.com/file/missioncontrol-public/releases/mission_control_mac/Mission-Control-#{version}.dmg",
      verified: "f000.backblazeb2.com/file/missioncontrol-public/"
  name "Mission Control"
  desc "Menu bar launcher and time tracker for Mission Control projects"
  homepage "https://missioncontrol.dev/"

  livecheck do
    skip "Updated by the app's release script."
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Mission Control.app"

  # Releases are ad-hoc signed, not notarized, so Gatekeeper would block the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Mission Control.app"]
  end

  uninstall quit: "dev.missioncontrol.mac"

  zap trash: "~/Library/Preferences/dev.missioncontrol.mac.plist"
end
