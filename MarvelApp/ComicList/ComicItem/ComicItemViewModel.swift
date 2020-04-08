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
    case failed, loading, completed(imageData: Data)
  }
  
  let imageState: ImmutableBinder<State>
  
  let comic: Comic
  
  private let _imageState: Binder<State>
    
  private let network: Networking
  
  init(comic: Comic, network: Networking) {
    self.comic = comic
    self.network = network
    title = comic.title
    _imageState = Binder(.failed)
    imageState = ImmutableBinder(binder: _imageState)
  }
  
  func start() {
    guard case .failed = _imageState.value else { return }
    _imageState.value = .loading
    network.getImage(path: comic.imagePath) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self._imageState.value = .completed(imageData: data)
      case .failure:
        self._imageState.value = .failed
      }
    }
  }
}
