//
//  ComicItemViewModel.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class ComicItemViewModel {
  
  let title: String
  
  enum State {
    case failed, loading, completed(data: Data)
  }
  
  let imageState: ImmutableBinder<State>
  
  let comic: Comic
  
  private let _imageState: Binder<State>
    
  private let network: Networking
  
  private let cache: Caching
  
  init(comic: Comic, network: Networking, cache: Caching) {
    self.comic = comic
    self.network = network
    self.cache = cache
    title = comic.title
    _imageState = Binder(.failed)
    imageState = ImmutableBinder(binder: _imageState)
  }
  
  func start() {
    guard case .failed = _imageState.value else { return }
    if let data = cache.getImage(for: comic.imagePath) {
      _imageState.value = .completed(data: data)
    } else {
      downloadImage(path: comic.imagePath)
    }
  }
  
  private func downloadImage(path: String) {
    _imageState.value = .loading
    network.getImage(path: path) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self.cache.setImage(image: data, path: path)
        self._imageState.value = .completed(data: data)
      case .failure:
        self._imageState.value = .failed
      }
    }
  }
}
