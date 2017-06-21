import XCTest
@testable import MailDevProvider
import SMTP
import Vapor

class InMemoryMailClientTests: XCTestCase {
    static let allTests = [
        ("testSendEmail", testSendEmail),
        ("testSendMultipleEmails", testSendMultipleEmails),
        ("testDroplet", testDroplet),
    ]

    func testSendEmail() throws {
        let mailer = InMemoryMailClient()
        let email = Email(from: "from@email.com",
                          to: "to1@email.com", "to2@email.com",
                          subject: "Email Subject",
                          body: "Hello Email")
        let attachment = EmailAttachment(filename: "dummy.data",
                                         contentType: "dummy/data",
                                         body: [1,2,3,4,5])
        email.attachments.append(attachment)
        try mailer.send(email)

        XCTAssert(mailer.sentEmails.count == 1)
        XCTAssert(mailer.sentEmails[0].subject == "Email Subject")
    }

    func testSendMultipleEmails() throws {
        let mailer = InMemoryMailClient()
        let emails = [
            Email(from: "from@email.com", to: "to@email.com", subject: "Email1", body: "Email1 body"),
            Email(from: "from@email.com", to: "to@email.com", subject: "Email2", body: "Email2 body"),
            Email(from: "from@email.com", to: "to@email.com", subject: "Email3", body: "Email3 body"),
        ]
        try mailer.send(emails)

        XCTAssert(mailer.sentEmails.count == 3)
        XCTAssert(mailer.sentEmails[0].subject == "Email1")
        XCTAssert(mailer.sentEmails[1].subject == "Email2")
        XCTAssert(mailer.sentEmails[2].subject == "Email3")
    }

    func testDroplet() throws {
        let config: Config = try [
            "droplet": [
                "mail": "in-memory"
            ],
        ].makeNode(in: nil).converted()
        try config.addProvider(Provider.self)
        let drop = try Droplet(config)
        guard let _ = drop.mail as? InMemoryMailClient else {
            XCTFail("drop.mail is \(drop.mail)")
            return
        }
    }

}
