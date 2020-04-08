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
  
  private let cache: Caching
    
  private let state: Binder<State>
  
  init(comic: Comic, state: Binder<State>, network: Networking, cache: Caching) {
    self.comic = comic
    self.network = network
    self.cache = cache
    self.state = state
  }
  
  func start() {
    if let data = cache.getImage(for: comic.imagePath) {
      print(data)
      state.value = .completed(data: data)
    } else {
      downloadImage(path: comic.imagePath)
    }
  }
  
  private func downloadImage(path: String) {
    state.value = .loading
    network.getImage(path: path) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self.cache.setImage(image: data, path: path)
        self.state.value = .completed(data: data)
      case .failure:
        self.state.value = .failed
      }
    }
  }
}
