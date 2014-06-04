//
//  Agent.swift
//  Agent
//
//  Created by Christoffer Hallas on 6/2/14.
//  Copyright (c) 2014 Christoffer Hallas. All rights reserved.
//

import Foundation

class Agent: NSObject {

  /**
   * Members
   */

  var request: NSMutableURLRequest? = nil
  var response: NSHTTPURLResponse? = nil
  var data: NSMutableData? = nil
  var done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> () = { (_, _, _) -> () in }

  /**
   * Initialize
   */

  init(method: String, url: String, headers: Dictionary<String, String>?) {
    let _url = NSURL(string: url)
    self.request = NSMutableURLRequest(URL: _url)
    self.request!.HTTPMethod = method;
    if (headers) {
      self.request!.allHTTPHeaderFields = headers!
    }
  }

  /**
   * GET
   */

  class func get(url: String) -> Agent {
    return Agent(method: "GET", url: url, headers: nil)
  }

  class func get(url: String, headers: Dictionary<String, String>) -> Agent {
    return Agent(method: "GET", url: url, headers: headers)
  }

  class func get(url: String, done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent {
    return Agent.get(url).end(done)
  }

  class func get(url: String, headers: Dictionary<String, String>, done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent {
    return Agent.get(url, headers: headers).end(done)
  }

  /**
   * POST
   */

  class func post(url: String) -> Agent {
    return Agent(method: "POST", url: url, headers: nil)
  }

  class func post(url: String, headers: Dictionary<String, String>) -> Agent {
    return Agent(method: "POST", url: url, headers: headers)
  }

  class func post(url: String, done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent {
    return Agent.post(url).end(done)
  }

  class func post(url: String, headers: Dictionary<String, String>, data: Dictionary<String, AnyObject>) -> Agent {
    return Agent.post(url, headers: headers).send(data)
  }

  class func post(url: String, data: Dictionary<String, AnyObject>) -> Agent {
    return Agent.post(url).send(data)
  }

  class func post(url: String, data: Dictionary<String, AnyObject>, done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent {
    return Agent.post(url, data: data).send(data).end(done)
  }

  class func post(url: String, headers: Dictionary<String, String>, data: Dictionary<String, AnyObject>, done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent {
    return Agent.post(url, headers: headers, data: data).send(data).end(done)
  }

  /**
   * PUT
   */

  class func put(url: String) -> Agent {
    return Agent(method: "PUT", url: url, headers: nil)
  }

  class func put(url: String, headers: Dictionary<String, String>) -> Agent {
    return Agent(method: "PUT", url: url, headers: headers)
  }

  class func put(url: String, done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent {
    return Agent.put(url).end(done)
  }

  class func put(url: String, headers: Dictionary<String, String>, data: Dictionary<String, AnyObject>) -> Agent {
      return Agent.put(url, headers: headers).send(data)
  }

  class func put(url: String, data: Dictionary<String, AnyObject>) -> Agent {
    return Agent.put(url).send(data)
  }

  class func put(url: String, data: Dictionary<String, AnyObject>, done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent {
    return Agent.put(url, data: data).send(data).end(done)
  }

  class func put(url: String, headers: Dictionary<String, String>, data: Dictionary<String, AnyObject>, done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent {
    return Agent.put(url, headers: headers, data: data).send(data).end(done)
  }

  /**
   * DELETE
   */

  class func delete(url: String) -> Agent {
    return Agent(method: "DELETE", url: url, headers: nil)
  }

  class func delete(url: String, headers: Dictionary<String, String>) -> Agent {
    return Agent(method: "DELETE", url: url, headers: headers)
  }

  class func delete(url: String, done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent {
    return Agent.delete(url).end(done)
  }

  class func delete(url: String, headers: Dictionary<String, String>, done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent {
    return Agent.delete(url, headers: headers).end(done)
  }

  /**
   * Methods
   */

  func send(data: Dictionary<String, AnyObject>) -> Agent {
    var error: NSError?
    var json = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions(0), error: &error)
    // TODO: handle error
    self.set("Content-Type", value: "application/json")
    self.request!.HTTPBody = json
    return self
  }

  func set(header: String, value: String) -> Agent {
    self.request!.setValue(value, forHTTPHeaderField: header)
    return self
  }

  func end(done: (NSError?, NSHTTPURLResponse?, AnyObject?) -> ()) -> Agent {
    self.done = done
    self.data = NSMutableData()
    let connection = NSURLConnection(request: self.request, delegate: self, startImmediately: true)
    return self
  }

  /**
   * Delegate
   */

  func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
    self.data!.appendData(data)
  }

  func connection(connection: NSURLConnection!, didReceiveResponse response: NSHTTPURLResponse!) {
    self.response = response
  }
  
  func connectionDidFinishLoading(connection: NSURLConnection!) {
    var error: NSError?
    var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error)
    // TODO: handle error
    self.done(nil, self.response, json)
  }
  
  func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
    self.done(error, nil, nil)
  }

}
