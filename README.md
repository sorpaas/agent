# Agent

Minimalistic Swift HTTP request agent for iOS and OS X.

## Introduction

This is a tiny framework that gives you nice a API for crafting HTTP requests.

## Usage

Throughout this documentation ```req``` is used as an instance of Agent.

### HTTP Verbs

The Agent API is simple and easy to use. Simply use ```Agent.<verb>(url)``` and
you're good to go.

### Overloading

It's possible to perform an entire request with a single call. Supply the
required parameters when first creating the request. There are usually multiple
degrees of overloading.

```swift
let done = { (error: NSError?, response: NSHTTPURLResponse?, data: AnyObject?) -> () in
  // react to the result of your request
};
Agent.post("http://example.com", headers: [ "Header": "Value" ],
  data: [ "Key": "Value" ], done: done)
```

It's possible to omit most overloaded parameters such as ```headers```.

### Method Chaining

Every Agent method returns the Agent itself, therefore it is possible to write
more expressive code.

```swift
Agent.post("http://example.com")
  .send([ "Key": "Value" ])
  .end({ (error: NSError?, response: NSHTTPURLResponse?, data: AnyObject?) -> () in
    // react to the result of your request
  }
)
```

### Response Closure

One of the features that makes Agent is the response closure, instead of
setting up a delegate for every HTTP request you have to make. You can simply
react to the response in a closure.

In Agent, the response is of the type ```(NSError?, NSHTTPURLResponse?, AnyObject?)```.
A response closure that reads JSON is easily created as seen below.

```swift
let done = { (error: NSError?, response: NSHTTPURLResponse?, data: AnyObject?) -> () in
  let json = data! as Dictionary<String, String>
  println(json["Key"]!)
}
```

### Verbs

#### ```GET(url: String)```

```swift
let req = Agent.get("http://example.com")
req.end({ (error: NSError?, response: NSHTTPURLResponse?, data: AnyObject?) -> () in
  // react to the result of your request
})
```

#### ```POST(url: String)```

```swift
let req = Agent.post("http://example.com")
req.send([ "Key": "Value" ])
req.end({ (error: NSError?, response: NSHTTPURLResponse?, data: AnyObject?) -> () in
  // react to the result of your request
})
```

#### ```PUT(url: String)```

```swift
let req = Agent.put("http://example.com")
req.send([ "Key": "Value" ])
req.end({ (error: NSError?, response: NSHTTPURLResponse?, data: AnyObject?) -> () in
  // react to the result of your request
})
```

#### ```DELETE(url: String)```

```swift
let req = Agent.delete("http://example.com")
req.end({ (error: NSError?, response: NSHTTPURLResponse?, data: AnyObject?) -> () in
  // react to the result of your request
})
```

### Methods

#### ```send(data: Dictionary<String, AnyObject>) -> Agent```

Will JSON serialize any ```data``` and send it along as the HTTP body. Also
implicitly sets the ```Content-Type``` header to ```application/json```.

#### ```set(header: String, value: String) -> Agent```

Sets the HTTP ```header``` to ```value```.

#### ```end(done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent```

Will start the request and call ```done``` when it's complete.

- If there was an error then ```$0``` will be an ```NSErrror``` that you can inspect for
more information.
- If the request was successful then ```$1``` will be an ```NSHTTPURLResponse```.
- If the response had any data, ```$2``` will be an ```AnyObject``` that you can
type cast to either an ```Array``` or ```Dictionary```.

### NSMutableURLRequest

You can always access the underlying ```NSMutableURLRequest```
using ```req.request!```, please notice that it is an optional.

## Contributing

We're happy to receive any pull requests. Right now we're working hard on a
number of features as seen below.

- Complete asynchronous tests
- Plugins
- Specialized agents (to handle default headers and such)

Any issue is appreciated.

## License

MIT
