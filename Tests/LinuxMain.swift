#if os(Linux)

import XCTest
@testable import MailDevTests

XCTMain([
    testCase(ConsoleMailClientTests.allTests),
    testCase(InMemoryMailClientTests.allTests),
])

#endif
