//
//  ComicListViewModel.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation


final class ComicListViewModel {
  
  enum State {
    case failed(message: String), loading, completed(comicList: [ComicItemViewModel])
  }
  
  private let network: Networking
  
  private let state: Binder<State>
  
  init(network: Networking, state: Binder<State>) {
    self.network = network
    self.state = state
  }
  
  func start() {
    state.value = .loading
    network.getMovies { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let response):
        let comicList = ComicWorker.format(response: response).map{ ComicItemViewModel(comic: $0) }
        
        self.state.value = .completed(comicList: comicList)
      case .failure(let error):
        let message: String
        switch error {
        case .network(let description):
          message = description
        default:
          message = error.localizedDescription
        }
        self.state.value = .failed(message: message)
      }
    }
  }
  
}
