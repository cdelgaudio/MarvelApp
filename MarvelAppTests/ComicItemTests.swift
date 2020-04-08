//
//  ComicListTests.swift
//  MarvelAppUITests
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import XCTest
@testable import MarvelApp

class ComicItemTests: XCTestCase {

    func testNetworkFailure() {
      let comic = Comic(id: 1, title: "Test", description: nil, imagePath: "")
      let network = MockNetworking(state: .failed)
      let cache = MockCache(state: .empty)
      let viewModel = ComicItemViewModel(comic: comic, network: network, cache: cache)
      viewModel.start()
      
      switch viewModel.imageState.value {
      case .failed:
        XCTAssert(true)
      default:
        XCTAssert(false, "ComicListTests error not caught")
      }
    }

  func testNetworkLoading() {
    let comic = Comic(id: 1, title: "Test", description: nil, imagePath: "")
    let network = MockNetworking(state: .loading)
    let cache = MockCache(state: .empty)
    let viewModel = ComicItemViewModel(comic: comic, network: network, cache: cache)
    viewModel.start()
    
    switch viewModel.imageState.value {
    case .loading:
      XCTAssert(true)
    default:
      XCTAssert(false, "ComicListTests loading not caught")
    }
  }

  func testNetworkSuccess() {
    let comic = Comic(id: 1, title: "Test", description: nil, imagePath: "")
    let network = MockNetworking(state: .completed(response: Data()))
    let cache = MockCache(state: .empty)
    let viewModel = ComicItemViewModel(comic: comic, network: network, cache: cache)
    viewModel.start()
    
    switch viewModel.imageState.value {
    case .completed:
      XCTAssert(true)
    default:
      XCTAssert(false, "ComicListTests loading not caught")
    }
  }
  
  func testCacheSuccess() {
    let comic = Comic(id: 1, title: "Test", description: nil, imagePath: "")
    let network = MockNetworking(state: .failed)
    let cache = MockCache(state: .filled(data: Data()))
    let viewModel = ComicItemViewModel(comic: comic, network: network, cache: cache)
    viewModel.start()
    
    switch viewModel.imageState.value {
    case .completed:
      XCTAssert(true)
    default:
      XCTAssert(false, "ComicListTests loading not caught")
    }
  }
  
  func testCacheFailure() {
    let comic = Comic(id: 1, title: "Test", description: nil, imagePath: "")
    let network = MockNetworking(state: .failed)
    let cache = MockCache(state: .empty)
    let viewModel = ComicItemViewModel(comic: comic, network: network, cache: cache)
    viewModel.start()
    
    switch viewModel.imageState.value {
    case .failed:
      XCTAssert(true)
    default:
      XCTAssert(false, "ComicListTests loading not caught")
    }
  }
}
