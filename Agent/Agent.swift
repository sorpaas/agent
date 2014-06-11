//
//  Agent.swift
//  Agent
//
//  Created by Christoffer Hallas on 6/2/14.
//  Copyright (c) 2014 Christoffer Hallas. All rights reserved.
//

import Foundation

class Agent {

  typealias Headers = Dictionary<String, String>
  typealias Data = AnyObject!
  typealias Response = (NSHTTPURLResponse!, Data!, NSError!) -> Void

  /**
   * Members
   */

  var baseURL: NSURL?
  var headers: Headers?
  var request: NSMutableURLRequest?
  let queue = NSOperationQueue()

  /**
   * Initialize
   */
  
  init(baseURL: String) {
    self.baseURL = NSURL(string: baseURL)
  }
  
  convenience init(baseURL: String, headers: Headers) {
    self.init(baseURL: baseURL)
    self.headers = headers
  }

  init(method: String, URL: String) {
    self.request = NSMutableURLRequest(URL: NSURL(string: URL))
    self.request!.HTTPMethod = method;
    if (self.headers) {
      self.request!.allHTTPHeaderFields = self.headers!
    }
  }

  convenience init(method: String, URL: String, headers: Headers) {
    self.init(method: method, URL: URL)
    self.request!.allHTTPHeaderFields = headers
  }
  
  /**
   * Request
   */
  
  func request(method: String, URL: String) -> Agent {
    var _URL: NSURL
    if (self.baseURL) {
      _URL = self.baseURL!.URLByAppendingPathComponent(URL)
    } else {
      _URL = NSURL(string: URL)
    }
    self.request = NSMutableURLRequest(URL: _URL)
    self.request!.HTTPMethod = method;
    if (self.headers) {
      self.request!.allHTTPHeaderFields = self.headers!
    }
    return self
  }

  /**
   * GET
   */

  class func get(URL: String) -> Agent {
    return Agent(method: "GET", URL: URL)
  }

  class func get(URL: String, headers: Headers) -> Agent {
    return Agent(method: "GET", URL: URL, headers: headers)
  }

  class func get(URL: String, done: Response) -> Agent {
    return Agent.get(URL).end(done)
  }

  class func get(URL: String, headers: Headers, done: Response) -> Agent {
    return Agent.get(URL, headers: headers).end(done)
  }
  
  func get(URL: String) -> Agent {
    return self.request("GET", URL: URL)
  }

  /**
   * POST
   */

  class func post(URL: String) -> Agent {
    return Agent(method: "POST", URL: URL)
  }

  class func post(URL: String, headers: Headers) -> Agent {
    return Agent(method: "POST", URL: URL, headers: headers)
  }

  class func post(URL: String, done: Response) -> Agent {
    return Agent.post(URL).end(done)
  }

  class func post(URL: String, headers: Headers, data: Data) -> Agent {
    return Agent.post(URL, headers: headers).send(data)
  }

  class func post(URL: String, data: Data) -> Agent {
    return Agent.post(URL).send(data)
  }

  class func post(URL: String, data: Data, done: Response) -> Agent {
    return Agent.post(URL, data: data).send(data).end(done)
  }

  class func post(URL: String, headers: Headers, data: Data, done: Response) -> Agent {
    return Agent.post(URL, headers: headers, data: data).send(data).end(done)
  }

  /**
   * PUT
   */

  class func put(URL: String) -> Agent {
    return Agent(method: "PUT", URL: URL)
  }

  class func put(URL: String, headers: Headers) -> Agent {
    return Agent(method: "PUT", URL: URL, headers: headers)
  }

  class func put(URL: String, done: Response) -> Agent {
    return Agent.put(URL).end(done)
  }

  class func put(URL: String, headers: Headers, data: Data) -> Agent {
      return Agent.put(URL, headers: headers).send(data)
  }

  class func put(URL: String, data: Data) -> Agent {
    return Agent.put(URL).send(data)
  }

  class func put(URL: String, data: Data, done: Response) -> Agent {
    return Agent.put(URL, data: data).send(data).end(done)
  }

  class func put(URL: String, headers: Headers, data: Data, done: Response) -> Agent {
    return Agent.put(URL, headers: headers, data: data).send(data).end(done)
  }

  /**
   * DELETE
   */

  class func delete(URL: String) -> Agent {
    return Agent(method: "DELETE", URL: URL)
  }

  class func delete(URL: String, headers: Headers) -> Agent {
    return Agent(method: "DELETE", URL: URL, headers: headers)
  }

  class func delete(URL: String, done: Response) -> Agent {
    return Agent.delete(URL).end(done)
  }

  class func delete(URL: String, headers: Headers, done: Response) -> Agent {
    return Agent.delete(URL, headers: headers).end(done)
  }

  /**
   * Methods
   */

  func send(data: Data) -> Agent {
    var error: NSError?
    let json = NSJSONSerialization.dataWithJSONObject(data, options: nil, error: &error)
    self.set("Content-Type", value: "application/json")
    self.request!.HTTPBody = json
    return self
  }

  func set(header: String, value: String) -> Agent {
    self.request!.setValue(value, forHTTPHeaderField: header)
    return self
  }

  func end(done: Response) -> Agent {
    let completion = { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
      let res = response as NSHTTPURLResponse!
      if (error) {
        done(res, data, error)
        return
      }
      var error: NSError?
      var json: AnyObject!
      if (data) {
        json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error)
      }
      done(res, json, error)
    }
    NSURLConnection.sendAsynchronousRequest(self.request, queue: self.queue, completionHandler: completion)
    return self
  }

}
