//
//  AgentTests.swift
//  AgentTests
//
//  Created by Christoffer Hallas on 6/2/14.
//  Copyright (c) 2014 Christoffer Hallas. All rights reserved.
//

import XCTest
import Agent

class AgentTests: XCTestCase {

  func waitFor (inout wait: Bool) {
    while (wait) {
      NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode,
        beforeDate: NSDate(timeIntervalSinceNow: 0.1))
    }
  }

  func testGetShouldSucceed () {
    var wait: Bool = true
    let done: Agent.Response = { (response: NSHTTPURLResponse!, _, error: NSError!) -> Void in
      XCTAssertNil(error)
      XCTAssertEqual(response!.statusCode, 200)
      wait = false
    }
    Agent.get("http://headers.jsontest.com", done: done)
    waitFor(&wait)
  }
  
  func testGetShouldSucceedWithJSON () {
    var wait: Bool = true
    let done: Agent.Response = { (response: NSHTTPURLResponse!, data: Agent.Data!, error: NSError!) -> Void in
      XCTAssertNil(error)
      XCTAssertEqual(response!.statusCode, 200)
      let json = data! as Dictionary<String, String>
      XCTAssertEqual(json["Host"]!, "headers.jsontest.com")
      wait = false
    }
    Agent.get("http://headers.jsontest.com", done: done)
    waitFor(&wait)
  }

  func testGetShouldFail () {
    var wait: Bool = true
    let done = { (_: NSHTTPURLResponse!, data: Agent.Data!, error: NSError!) -> Void in
      println(error)
      XCTAssertNotNil(error)
      wait = false
    }
    Agent.get("http://nope.example.com", done: done)
    waitFor(&wait)
  }

  func testPostShouldFail () {
    var wait: Bool = true
    let done = { (_: NSHTTPURLResponse!, data: Agent.Data!, error: NSError!) -> Void in
      println(error)
      XCTAssertNotNil(error)
      wait = false
    }
    Agent.post("http://nope.example.com", done: done)
    waitFor(&wait)
  }
  
  func testPutShouldFail () {
    var wait: Bool = true
    let done = { (_: NSHTTPURLResponse!, data: Agent.Data!, error: NSError!) -> Void in
      println(error)
      XCTAssertNotNil(error)
      wait = false
    }
    Agent.put("http://nope.example.com", done: done)
    waitFor(&wait)
  }
  
  func testDeleteShouldFail () {
    var wait: Bool = true
    let done = { (_: NSHTTPURLResponse!, data: Agent.Data!, error: NSError!) -> Void in
      println(error)
      XCTAssertNotNil(error)
      wait = false
    }
    Agent.delete("http://nope.example.com", done: done)
    waitFor(&wait)
  }
  
  func testGetSpecialAgent () {
    var wait: Bool = true
    let done = { (_: NSHTTPURLResponse!, data: Agent.Data!, error: NSError!) -> Void in
      XCTAssertNil(error)
      wait = false
    }
    let agent = Agent(baseURL: "https://api.github.com")
    agent.get("/users").end(done)
    waitFor(&wait)
  }

}
