//
//  ComicDetailViewModel.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class ComicDetailViewModel {
  
  enum State {
    case failed, loading, completed(data: Data)
  }
    
  let comic: Comic

  private let network: Networking
    
  private let state: Binder<State>
  
  init(comic: Comic, state: Binder<State>, network: Networking) {
    self.comic = comic
    self.network = network
    self.state = state
  }
  
  func start() {
    state.value = .loading
    network.getImage(path: comic.imagePath) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self.state.value = .completed(data: data)
      case .failure:
        self.state.value = .failed
      }
    }
  }
}
