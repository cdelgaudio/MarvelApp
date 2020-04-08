//
//  MockCache.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class MockCache: Caching {
  
  enum State {
    case empty, filled(data: Data)
  }
  
  private let state: State
  
  init(state: State) {
    self.state = state
  }
  
  func getImage(for path: String?) -> Data? {
    switch state {
    case .empty:
      return nil
    case .filled(let data):
      return data
    }
  }
  
  func setImage(image: Data, path: String?) {}
}
