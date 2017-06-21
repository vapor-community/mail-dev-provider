import XCTest
@testable import MailDevProvider
import SMTP
import Vapor

class ConsoleMailClientTests: XCTestCase {
    static let allTests = [
        ("testSendEmail", testSendEmail),
        ("testSendMultipleEmails", testSendMultipleEmails),
        ("testDroplet", testDroplet),
    ]

    func testSendEmail() throws {
        let mailer = ConsoleMailClient()
        let email = Email(from: "from@email.com",
                          to: "to1@email.com", "to2@email.com",
                          subject: "Email Subject",
                          body: "Hello Email")
        let attachment = EmailAttachment(filename: "dummy.data",
                                         contentType: "dummy/data",
                                         body: [1,2,3,4,5])
        email.attachments.append(attachment)
        try mailer.send(email)
    }

    func testSendMultipleEmails() throws {
        let mailer = ConsoleMailClient()
        let emails = [
            Email(from: "from@email.com", to: "to@email.com", subject: "Email1", body: "Email1 body"),
            Email(from: "from@email.com", to: "to@email.com", subject: "Email2", body: "Email2 body"),
            Email(from: "from@email.com", to: "to@email.com", subject: "Email3", body: "Email3 body"),
        ]
        try mailer.send(emails)
    }

    func testDroplet() throws {
        let config: Config = try [
            "droplet": [
                "mail": "console"
            ],
        ].makeNode(in: nil).converted()
        try config.addProvider(Provider.self)
        let drop = try Droplet(config)
        guard let _ = drop.mail as? ConsoleMailClient else {
            XCTFail("drop.mail is \(drop.mail)")
            return
        }
    }

}
