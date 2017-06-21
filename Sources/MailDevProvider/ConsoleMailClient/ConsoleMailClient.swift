import Console
import SMTP
import Vapor

/**
    A development-only MailClient which does not send emails; rather, it
    logs them to the console for debugging purposes.
*/
public final class ConsoleMailClient: MailProtocol {

    let console = Terminal(arguments: [])
    let style = ConsoleStyle.custom(.yellow)

    public init() {}

    public func send(_ emails: [Email]) throws {
        emails.forEach { email in
            console.output("SEND EMAIL", style: style, newLine: true)
            console.output("From: \(email.from)", style: style, newLine: true)
            console.output("To:", style: style, newLine: true)
            email.to.forEach {
                console.output(" - \($0)", style: style, newLine: true)
            }
            console.output("Subject: \(email.subject)", style: style, newLine: true)
            console.output("Body: \(email.body.content)", style: style, newLine: true)
            if email.attachments.count > 0 {
                console.output("Attachments:", style: style, newLine: true)
                email.attachments.forEach {
                    console.output(" - \($0.emailAttachment.filename)", style: style, newLine: true)
                }
            }

        }
    }

}

extension ConsoleMailClient: EmptyInitializable {}

extension ConsoleMailClient: ConfigInitializable {
    public convenience init(config: Config) throws {
        self.init()
    }
}
