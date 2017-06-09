import PackageDescription

let package = Package(
    name: "MailDev",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
    ]
)
