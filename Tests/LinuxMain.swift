#if os(Linux)

import XCTest
@testable import MailDevProviderTests

XCTMain([
    testCase(ConsoleMailClientTests.allTests),
    testCase(InMemoryMailClientTests.allTests),
])

#endif
