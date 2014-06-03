# Agent

Minimalistic Swift HTTP request agent for iOS and OS X.

## Introduction

This is a tiny framework that gives you nice a API for crafting an HTTP request.

## Usage

Throughout this documentation ```req``` is used as an instance of Agent.

### HTTP Verbs

The Agent API is simple and easy to use. Simply use ```Agent.<verb>(url)``` and
you're good to go.

### Overloading

It is possible to perform an entire request with a single call. Supply the
required parameters when first creating the request. There are usually multiple
degrees of overloading.

```swift
Agent.post("http://example.com", headers: [ "Header": "Value" ], data: [ "Key": "Value" ], done: { (error: NSError?, response: NSURLResponse?) -> () in
  if (error) {
    return
  }
  println(response!)
})
```

It's possible to omit must overloaded parameters such as ```headers```.

### Method Chaining

Every Agent method returns the Agent itself, therefor it is possible to write
more expressive code.

```swift
Agent.post("http://example.com").send([ "Key": "Value" ]).end({ (error: NSError?, response: NSURLResponse?) -> () in
  if (error) {
    return
  }
  println(response!)
})
```

### Verbs

#### ```GET(url: String)```

```swift
let req = Agent.get("http://example.com")
req.end({ (error: NSError?, response: NSURLResponse?) -> () in
  if (error) {
    return
  }
  println(response!)
})
```

#### ```POST(url: String)```

```swift
let req = Agent.post("http://example.com")
req.send([ "Key": "Value" ])
req.end({ (error: NSError?, response: NSURLResponse?) -> () in
  if (error) {
    return
  }
  println(response!)
})
```

#### ```PUT(url: String)```

```swift
let req = Agent.put("http://example.com")
req.send([ "Key": "Value" ])
req.end({ (error: NSError?, response: NSURLResponse?) -> () in
  if (error) {
    return
  }
  println(response!)
})
```

#### ```DELETE(url: String)```

```swift
let req = Agent.delete("http://example.com")
req.end({ (error: NSError?, response: NSURLResponse?) -> () in
  if (error) {
    return
  }
  println(response!)
})
```

### Methods

#### ```send(data: Dictionary<String, AnyObject>) -> Agent```

Will JSON serialize any ```data``` and send it along as the HTTP body. Also
implicitly sets the ```Content-Type``` header to ```application/json```.

#### ```set(header: String, value: String) -> Agent```

Sets the HTTP ```header``` to ```value```.

#### ```end(done: (NSError?, NSURLResponse?) -> ()) -> Agent```

Will start the request and call ```done``` when it's complete.

If there was an error then ```$0``` will be an ```NSErrror``` that you can inspect for
more information.

If the request was successful then ```$1``` will be an ```NSURLResponse```.

### NSMutableURLRequest

You can always access the underlying ```NSMutableURLRequest```
using ```req.request!```, please notice that it is an optional.

## Contributing

We're happy to receive any pull requests. Right now we're working hard on a
number of features as seen below.

- Complete asynchronous tests
- Reading response data
- Plugins
- Specialized agents (to handle default headers and such)

Any issue is appreciated.

## License

(The MIT License)

Copyright (c) 2014 Christoffer Hallas &lt;christoffer.hallas@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
