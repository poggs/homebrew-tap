cask "testcontainers-cloud-desktop" do
  version "1.4.1"
  sha256 "18b0e16199eea4e3bbb1cd94e58819324708b42f8887c6affff04e62ad7a6c13"

  url "https://app.testcontainers.cloud/download/testcontainers-cloud-desktop_#{version}_darwin_universal.dmg",
      user_agent: "brew-cask"
  name "Testcontainers Cloud Client"
  desc "Client to connect testcontainers integration tests to Testcontainers Cloud"
  homepage "https://app.testcontainers.cloud/"

  livecheck do
    url "https://app.testcontainers.cloud/api/versions"
    strategy :page_match do |page|
      JSON.parse(page)["latest"]
    end
  end

  app "Testcontainers Cloud Desktop.app"

  postflight_steps do
    system_command "open",
                   args: ["#{appdir}/Testcontainers Cloud Desktop.app"]
  end

  caveats "
  ******** WARNING *******
  #{token} will no longer receive updates.

  Please use testcontainers-desktop instead for a more fully-featured desktop experience!

  Please run:

  brew uninstall #{token}
  brew install testcontainers-desktop

  ******** WARNING *******

  "

  uninstall delete: [
              "~/Library/Caches/AtomicJar/testcontainers.cloud.desktop/agent.lock",
              "~/Library/Caches/AtomicJar/testcontainers.cloud.desktop/tcc-notification.png",
            ],
            quit:   [
              "com.atomicjar.cloud.desktop",
            ]

  zap trash:  [
        "~/.config/testcontainers/services",
        "~/.config/testcontainers/cloud.properties",
        "~/Library/Application Support/testcontainers.cloud.desktop",
        "~/Library/Caches/AtomicJar",
        "~/Library/Logs/AtomicJar",
      ],
      delete: [
        "~/Library/LaunchAgents/testcontainers.cloud.desktop.plist",
      ]
end
