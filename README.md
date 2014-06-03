# Agent

Minimalistic Swift HTTP request agent for iOS and OS X.

## Introduction

This is a tiny framework that gives you nice a API for crafting an HTTP request.

## Usage

### ```GET```

```swift
Agent.get("http://google.com", { (error: NSError?, response: NSURLResponse) -> () in
  println(response)
})
```

```swift
let req = Agent.get("http://apple.com")
req.end({ (error: NSError?, response: NSURLResponse) -> () in
  println(response)
})
```

