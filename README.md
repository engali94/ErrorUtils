


  

<p align="center">

<a href="https://developer.apple.com/swift/">

<img src="https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat" alt="Swift 5.0">

</a>

<a href="http://cocoapods.org/pods/ErrorUtils">

<img src="https://img.shields.io/cocoapods/v/ErrorUtils.svg?style=flat" alt="Version">

</a>

<a href="http://cocoapods.org/pods/ErrorUtils">

<img src="https://img.shields.io/cocoapods/p/ErrorUtils.svg?style=flat" alt="Platform">

</a>

<a href="https://github.com/Carthage/Carthage">

<img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage Compatible">

</a>

<a href="https://github.com/apple/swift-package-manager">

<img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">

</a>

</p>

  

# ErrorUtils

  

<p align="center">

🥱 Less do ... try ... catch clutter.

</p>

  

## Features

  

- [x]  ⛔️ No more long nested do...try...catch blocks.
- [x]  🆗 Validate input easily.
- [x]  🏷 Categorize errors.
- [x]  🎁 Unwrap optinals in more intuitive way.
  

## Usage

## 1. Throwable
old way:
```swift
func parse(url: String) throws -> String {
    guard let url = URL(string: url) else {
        throw ParserError.invalidURL
    }

    do {
        return try String(contentsOf: url)
    } catch {
        throw ParserError.invalidWebpage
    }
}
```

The new way:

```swift
func parse(url: String) throws -> String {
    guard let url = URL(string: url) else {
        throw ParserError.invalidURL
    }
    return try execute(String(contentsOf: url),
                       orThrow: Error.invalidWebpage)
}
```
  
`execute` method has three overloads:

``` swift
execute( _: ,orThrow:)
```

```swift
execute( _: ,errorTransform:)
```

```swift
execute( _: ,orCaptureError:)
```

## 2. Input Validator
It is common to find yourself doing this:

```swift
func signup(user: User) {
    guard user.username.count >= 3 else {
        errorLabel.text = "Username must have at least 3 characters"
        return
    }

    guard user.password.count >= 7 else {
        errorLabel.text = "Password must have at least 7 characters"
        return
    }

    // Additional validation like email ...etc
    ...
    authService.signup(user: user) { result in
        ...
    }
}
```

The validation logic can end up growing much quicker than we might expect so `Validator` to rescue.

we can simply add our custom validation logic by extending `Validator` like follows:

```swift
extension Validator where Value == String {
    static var password: Validator {
        return Validator { string in
            try validate(
                string.count >= 7,
                errorMessage: "Password must contain min 7 characters"
            )
            // you can add more logig here...
            try validate(
                string.uppercased() != string,
                errorMessage: "Password must contain a lowercased character"
            )
        }
    }
    
    static var username: Validator {
        return Validator { string in
            try validate(string.count >= 3, errorMessage: "Username must have at least 3 characters")
        }
    }
}

```

Then we can simplify our signup method using the brand new valiator
```swift
func signup(user: User) throws {
 
    try validate(user.username, using: .username)
    try validate(user.password, using: .password)
    
    authService.signup(user: user) { result in
        ...
    }
}
```

now call the function 

```swift
try! execute(signup(user: user)) { 
    self.errorLabel.text = $0.localizedDescription
 }
```

## 3. CategorizedError
Any `Error` type conforms to this protocol has to implement `category` property of type `ErrorCategory`

example:

```swift
enum NetworkError: Error {
    case noInternetConnection
    case decodingFailure
    case notAuthorized
  }
  
extension NetworkError: CategorizedError {
    var category: ErrorCategory {
        switch self {
        case .noInternetConnection:
            return .retryable
        case .decodingFailure:
            return .notRetryable
        case .notAuthorized:
            return .requiresLogin
        }
    }
}
``` 

now we can easily for example show or hide a retry button  according to the error type.

```swift
func handle(error: Error) {
    // do other stuff
    switch error.resolveCategory() {
    case .retryable:
        break
    case .notRetryable:
        retryButton.isHidden = true
    case .requiresLogin:
        performLogin()
    }
}
```

## 4.  Unwrap optinals
ex: 
```swift
var path: String?
...
func save() throws {
  let path = path.orThrow(Error.invalidPath)
}
```



## Installation

  

### CocoaPods

  

`ErrorUtils` is available through [CocoaPods](http://cocoapods.org). To install

it, simply add the following line to your Podfile:

  

```bash

pod 'ErrorUtils'

```

  

### Carthage

  

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

  

To integrate ErrorUtils into your Xcode project using Carthage, specify it in your `Cartfile`:

  

```bash

github "engali94/ErrorUtils"

```

  

Run `carthage update` to build the framework and drag the built `ErrorUtils.framework` into your Xcode project.

  

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase” and add the Framework path as mentioned in [Carthage Getting started Step 4, 5 and 6](https://github.com/Carthage/Carthage/blob/master/README.md#if-youre-building-for-ios-tvos-or-watchos)

  

### Swift Package Manager

  

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

  

```swift

dependencies: [

.package(url: "https://github.com/engali94/ErrorUtils.git", from: "1.0.0")

]

```

  

Alternatively navigate to your Xcode project, select `Swift Packages` and click the `+` icon to search for `ErrorUtils`.

  

### Manually

  

If you prefer not to use any of the aforementioned dependency managers, you can integrate `ErrorUtils` into your project manually. Simply drag the `Sources` Folder into your Xcode project.

 
 

## Contributing

Contributions are very welcome 🙌



## Credit
Most of the work done here is inspired by [Swiftbysundell](swiftbysundell.com) articles.

## License

  
ErrorUtils is released under the MIT license. See [LICENSE](https://github.com/engali94/ErrorUtils/blob/master/LICENSE) for more information.  
