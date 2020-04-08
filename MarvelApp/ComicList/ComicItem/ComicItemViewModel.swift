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
  
  private let comic: Comic
  
  private let network: Networking
  
  init(comic: Comic, network: Networking) {
    self.comic = comic
    self.network = network
    title = comic.title
  }
  
  func start() {
    network
  }
}
