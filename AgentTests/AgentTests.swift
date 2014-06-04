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
    Agent.get("http://headers.jsontest.com", done: { (error: NSError?, response: NSHTTPURLResponse?, _) -> () in
      XCTAssertNil(error)
      XCTAssertEqual(response!.statusCode, 200)
      wait = false
    })
    waitFor(&wait)
  }

  func testGetShouldSucceedWithJSON () {
    var wait: Bool = true
    let done = { (error: NSError?, response: NSHTTPURLResponse?, data: AnyObject?) -> () in
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
    Agent.get("http://nope.christofferhallas.com",
        done: { (error: NSError?, response: NSHTTPURLResponse?, _) -> () in
      XCTAssertNotNil(error)
      wait = false
    })
    waitFor(&wait)
  }

  func testPostShouldFail () {
    var wait: Bool = true
    Agent.post("http://nope.christofferhallas.com",
      done: { (error: NSError?, response: NSHTTPURLResponse?, _) -> () in
        XCTAssertNotNil(error)
        wait = false
      })
    waitFor(&wait)
  }

  func testPutShouldFail () {
    var wait: Bool = true
    Agent.put("http://nope.christofferhallas.com",
      done: { (error: NSError?, response: NSHTTPURLResponse?, _) -> () in
        XCTAssertNotNil(error)
        wait = false
      })
    waitFor(&wait)
  }

  func testDeleteShouldFail () {
    var wait: Bool = true
    Agent.delete("http://nope.christofferhallas.com",
      done: { (error: NSError?, response: NSHTTPURLResponse?, _) -> () in
        XCTAssertNotNil(error)
        wait = false
      })
    waitFor(&wait)
  }

}
