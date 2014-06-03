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

  func testExample() {
    Agent.get("http://google.com")
    Agent.post("http://google.com", data: [ "Key": "Value" ])
  }

}
