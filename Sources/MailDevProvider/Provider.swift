import Vapor

public final class Provider: Vapor.Provider {
    public static let repositoryName = "mail-dev-provider"

    public init(config: Config) throws { }

    public func boot(_ config: Config) throws {
        config.addConfigurable(mail: ConsoleMailClient.init, name: "console")
        config.addConfigurable(mail: InMemoryMailClient.init, name: "in-memory")
    }

    public func boot(_ drop: Droplet) throws { }
    public func beforeRun(_ drop: Droplet) {}
}
