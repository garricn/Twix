# Twix
Swift command line tool for replacing the first 5 lines of a Swift file with one comment line, i.e., `//`.

Turn this:

```swift
//
//  Sample.swift
//  Sample
//
//  Created by Garric G. Nahapetian on 5/13/17.
//  Copyright © 2017 SwiftCoders. All rights reserved.
//

```

Into this:

```swift
//
//  Copyright © 2017 SwiftCoders. All rights reserved.
//
````
# Installation

## On macOS

### Swift Package Manager

```
$ git clone https://github.com/garricn/Twix.git
$ cd Twix
$ swift build -c release -Xswiftc -static-stdlib
$ cp -f .build/release/Twix /usr/local/bin/twix
```

That will make `twix` available from anywhere on the command line.

# Usage

Run `twix` in any directory and it will automatically replace those lines.

# IMPORTANT

Twix will automatically and recursively edit ALL Swift files in the current directory and all sub-directories. Be sure to run it on a test file or in a directory under proper source control.
