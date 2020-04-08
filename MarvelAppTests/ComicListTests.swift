//
//  ComicListTests.swift
//  MarvelAppUITests
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import XCTest
@testable import MarvelApp

class ComicListTests: XCTestCase {

    func testNetworkFailure() {
      let state: Binder<ComicListViewModel.State> = Binder(.failed(message: ""))
      let network = MockNetworking(state: .failed)
      let cache = MockCache(state: .empty)
      let viewModel = ComicListViewModel(state: state, coordinator: nil, network: network, cache: cache)
      viewModel.start()
      
      switch state.value {
      case .failed(let message):
        XCTAssert(message == "Test Error", "ComicListTests message not caught")
      default:
        XCTAssert(false, "ComicListTests error not caught")
      }
    }

  func testNetworkLoading() {
    let state: Binder<ComicListViewModel.State> = Binder(.failed(message: ""))
    let network = MockNetworking(state: .loading)
    let cache = MockCache(state: .empty)
    let viewModel = ComicListViewModel(state: state, coordinator: nil, network: network, cache: cache)
    viewModel.start()
    
    switch state.value {
    case .loading:
      XCTAssert(true)
    default:
      XCTAssert(false, "ComicListTests loading not caught")
    }
  }
  
  func testNetworkSuccessEmpty() {
    let response = ComicListResponse(
      code: 1,
      status: "OK",
      data: .init(offset: 0, limit: 0, total: 0, count: 0, results: [])
    )
    let state: Binder<ComicListViewModel.State> = Binder(.failed(message: ""))
    let network = MockNetworking(state: .completed(response: response))
    let cache = MockCache(state: .empty)
    let viewModel = ComicListViewModel(state: state, coordinator: nil, network: network, cache: cache)
    viewModel.start()
    
    switch state.value {
    case .completed(let comicList):
      XCTAssert(comicList.isEmpty, "ComicListTests array not empty")
    default:
      XCTAssert(false, "ComicListTests success not caught")
    }
  }
  
  func testNetworkSuccess() {
    let response = ComicListResponse(
      code: 1,
      status: "OK",
      data: .init(offset: 0, limit: 0, total: 0, count: 0, results: [.init(id: 1, title: "Test", description: nil, issueNumber: 1, prices: [], thumbnail: .init(path: "", thumbnailExtension: nil), creators: .init(available: 1, collectionURI: "", items: [], returned: 1))])
    )
    let state: Binder<ComicListViewModel.State> = Binder(.failed(message: ""))
    let network = MockNetworking(state: .completed(response: response))
    let cache = MockCache(state: .empty)
    let viewModel = ComicListViewModel(state: state, coordinator: nil, network: network, cache: cache)
    viewModel.start()
    
    switch state.value {
    case .completed(let comicList):
      XCTAssert(comicList.first?.title == "Test", "ComicListTests array not empty")
    default:
      XCTAssert(false, "ComicListTests success not caught")
    }
  }
  
  func testRouteToDetails() {
    let response = ComicListResponse(
      code: 1,
      status: "OK",
      data: .init(offset: 0, limit: 0, total: 0, count: 0, results: [.init(id: 1, title: "Test", description: nil, issueNumber: 1, prices: [], thumbnail: .init(path: "", thumbnailExtension: nil), creators: .init(available: 1, collectionURI: "", items: [], returned: 1))])
    )
    let state: Binder<ComicListViewModel.State> = Binder(.failed(message: ""))
    let navigation = UINavigationController()
    let coordinator = ComicListCoordinator(navigation: navigation)
    let network = MockNetworking(state: .completed(response: response))
    let cache = MockCache(state: .empty)
    let viewModel = ComicListViewModel(state: state, coordinator: coordinator, network: network, cache: cache)
    viewModel.start()
    let childrenCount = navigation.children.count
    viewModel.goToDetails(index: 0)
    XCTAssert(navigation.children.count == childrenCount + 1, "ComicListTests routing failed")
  }
}
