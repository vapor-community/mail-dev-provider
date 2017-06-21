# Mail Development Provider for Vapor

![Swift](http://img.shields.io/badge/swift-3.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-2.0-brightgreen.svg)
[![CircleCI](https://circleci.com/gh/vapor-community/mail-dev-provider.svg?style=shield)](https://circleci.com/gh/vapor-community/mail-dev-provider)

Adds two development-only backends to the Vapor web framework. These backends
do not send any mail, but are useful for development and debugging purposes.

* `InMemoryMailClient` stores emails in memory.
* `ConsoleMailClient` outputs emails to the console.

## Setup
Add the dependency to Package.swift:

```JSON
.Package(url: "https://github.com/vapor-community/mail-dev-provider.git", majorVersion: 1)
```

Register the provider with the configuration system:

```swift
import MailDevProvider

extension Config {
    /// Configure providers
    private func setupProviders() throws {
        ...
        try addProvider(MailDevProvider.Provider.self)
    }
}
```

And finally, change the Droplet's mail implementation by editing `droplet.json`:

```js
{
  // to log emails to the console
  "mail": "console",
  // to store emails in memory
  "mail": "in-memory",
}
```

## Usage

Send emails as you normally would through Vapor:

```swift
let email = Email(from: …, to: …, subject: …, body: …)
try drop.mail.send(email)
```

Emails sent by the `ConsoleMailClient` will be displayed in the console.

```swift
import SMTP

let email = Email(
    from: "from@email.com",
    to: "recipient@email.com"
    subject: "Email subject",
    body: "Hello")
try drop.mail.send(email)
// Output to console
```

Emails sent by the `InMemoryMailClient` will be stored in the client's
`sentEmails` property.

```swift
import MailDevProvider
import SMTP

let email = Email(
    from: "from@email.com",
    to: "recipient@email.com",
    subject: "Email subject",
    body: "Hello")
try drop.mail.send(email)
if let mailer = drop.mail as? InMemoryMailClient {
  print (mailer.sentEmails)
}
```
