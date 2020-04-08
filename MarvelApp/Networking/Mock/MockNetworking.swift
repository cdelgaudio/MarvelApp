//
//  MockNetworking.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class MockNetworking: Networking {
  
  enum State {
    case failed, loading, completed(response: Any)
  }
  
  private let state: State
  
  init(state: State) {
    self.state = state
  }
  
  func getMovies(completion: @escaping (NetworkResult<ComicListResponse>) -> Void) {
    switch state {
    case .failed:
      completion(.failure(.network(description: "Test Error")))
    case .loading:
      break
    case .completed(let response):
      completion(.success(response as! ComicListResponse))
    }
  }
  
  func getImage(path: String, completion: @escaping (NetworkResult<Data>) -> Void) {
    switch state {
    case .failed:
      completion(.failure(.network(description: "Test Error")))
    case .loading:
      break
    case .completed(let response):
      completion(.success(response as! Data))
    }
  }
  
  
}
