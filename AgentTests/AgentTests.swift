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

  func testExample () {
    let data: Dictionary<String, AnyObject> = [ "Key": "Value" ]
    Agent.get("http://google.com")
    Agent.post("http://google.com", data: data)
    Agent.post("http://google.com", data: data)
  }

}
