import PackageDescription

let package = Package(
    name: "MailDevProvider",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
    ]
)
