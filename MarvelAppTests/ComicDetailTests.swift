//
//  ComicListTests.swift
//  MarvelAppUITests
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import XCTest
@testable import MarvelApp

class ComicDetailTests: XCTestCase {

    func testFailure() {
      let comic = Comic(id: 1, title: "Test", description: nil, imagePath: "")
      let state: Binder<ComicDetailViewModel.State> = Binder(.failed)
      let network = MockNetworking(state: .failed)
      let viewModel = ComicDetailViewModel(comic: comic, state: state, network: network)
      viewModel.start()
      
      switch state.value {
      case .failed:
        XCTAssert(true)
      default:
        XCTAssert(false, "ComicListTests error not caught")
      }
    }

  func testLoading() {
    let comic = Comic(id: 1, title: "Test", description: nil, imagePath: "")
    let state: Binder<ComicDetailViewModel.State> = Binder(.failed)
    let network = MockNetworking(state: .loading)
    let viewModel = ComicDetailViewModel(comic: comic, state: state, network: network)
    viewModel.start()
    
    switch state.value {
    case .loading:
      XCTAssert(true)
    default:
      XCTAssert(false, "ComicListTests loading not caught")
    }
  }

  func testSuccess() {
    let comic = Comic(id: 1, title: "Test", description: nil, imagePath: "")
    let state: Binder<ComicDetailViewModel.State> = Binder(.failed)
    let network = MockNetworking(state: .completed(response: Data()))
    let viewModel = ComicDetailViewModel(comic: comic, state: state, network: network)
    viewModel.start()
    
    switch state.value {
    case .completed:
      XCTAssert(true)
    default:
      XCTAssert(false, "ComicListTests loading not caught")
    }
  }
}
