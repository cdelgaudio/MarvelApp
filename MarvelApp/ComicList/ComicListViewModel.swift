//
//  ComicListViewModel.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

protocol ComicListCoordinating: AnyObject {
  func routeToDetails(comic: Comic)
}

final class ComicListViewModel {
  
  enum State {
    case failed(message: String), loading, completed(comicList: [ComicItemViewModel])
  }
  
  private let network: Networking
  
  private let cache: Caching
  
  private let state: Binder<State>
  
  private weak var coordinator: ComicListCoordinating?
  
  init(state: Binder<State>, coordinator: ComicListCoordinating?, network: Networking, cache: Caching) {
    self.network = network
    self.cache = cache
    self.state = state
    self.coordinator = coordinator
  }
  
  func start() {
    state.value = .loading
    network.getMovies { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let response):
        let comicList = ComicWorker.format(response: response).map{
          ComicItemViewModel(comic: $0, network: self.network, cache: self.cache)
        }
        self.state.value = .completed(comicList: comicList)
      case .failure(let error):
        self.state.value = .failed(message: error.message)
      }
    }
  }
  
  func goToDetails(index: Int) {
    guard case let .completed(comicList) = state.value else { return }
    coordinator?.routeToDetails(comic: comicList[index].comic)
  }
  
}
