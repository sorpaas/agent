//
//  Agent.swift
//  Agent
//
//  Created by Christoffer Hallas on 6/2/14.
//  Copyright (c) 2014 Christoffer Hallas. All rights reserved.
//

import Foundation

class Agent: NSObject, NSURLConnectionDelegate {

  var request: NSMutableURLRequest? = nil
  var connection: NSURLConnection? = nil

  // No-op default callback
  var done: (NSError?, NSURLResponse) -> () = { (_: NSError?, _: NSURLResponse) -> () in }

  init (method: String, url: String) {
    super.init()
    let _url = NSURL(string: url)
    self.request = NSMutableURLRequest(URL: _url)
    self.request!.HTTPMethod = method;
    self.connection = NSURLConnection(request: self.request, delegate: self)
  }

  class func get (url: String) -> Agent {
    return Agent(method: "GET", url: url)
  }

  class func get (url: String, done: (NSError?, NSURLResponse?) -> ()) -> Agent {
    return Agent.get(url).end(done)
  }

  class func post (url: String) -> Agent {
    return Agent(method: "POST", url: url)
  }

  class func post (url: String, data: Dictionary<String, AnyObject>) -> Agent {
    return Agent.post(url).send(data)
  }

  class func post (url: String, data: Dictionary<String, AnyObject>, done: (NSError?, NSURLResponse?) -> ()) -> Agent {
    return Agent.post(url, data: data).end(done)
  }

  class func put (url: String, data: Dictionary<String, AnyObject>) -> Agent {
    return Agent(method: "PUT", url: url).send(data)
  }

  class func put (url: String, data: Dictionary<String, AnyObject>, done: (NSError?, NSURLResponse?) -> ()) -> Agent {
    return Agent.put(url, data: data).end(done)
  }

  func send (data: Dictionary<String, AnyObject>) -> Agent {
    var error: NSError?
    var json = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions(0), error: &error)
    // TODO: handle error
    self.request!.HTTPBody = json
    return self
  }

  func end (done: (NSError?, NSURLResponse?) -> ()) -> Agent {
    self.done = done
    self.connection!.start()
    return self
  }

  func connection (connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
    self.done(nil, response)
  }

}
