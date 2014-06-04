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
      NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1))
    }
  }

  func testGetShouldSucceed () {
    var wait: Bool = true
    Agent.get("http://headers.jsontest.com",
      done: { (error: NSError?, response: NSHTTPURLResponse?, _) -> () in
      if (error) {
        return
      }
      XCTAssertEqual(response!.statusCode, 200)
      wait = false
    })
    waitFor(&wait)
  }

  func testGetShouldSucceedWith404 () {
    var wait: Bool = true
    Agent.get("http://example.com/non-existing-path",
        done: { (error: NSError?, response: NSHTTPURLResponse?, _) -> () in
      if (error) {
        return
      }
      XCTAssertEqual(response!.statusCode, 404)
      wait = false
    })
    waitFor(&wait)
  }

  func testGetShouldFail () {
    var wait: Bool = true
    Agent.get("http://nope.christofferhallas.com",
        done: { (error: NSError?, response: NSHTTPURLResponse?, _) -> () in
      XCTAssertNotNil(error)
      wait = false
    })
    waitFor(&wait)
  }

}
