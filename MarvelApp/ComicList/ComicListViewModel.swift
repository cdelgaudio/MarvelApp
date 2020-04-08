//
//  ComicListViewModel.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation


final class ComicListViewModel {
  
  private let network: Networking
  
  init(network: Networking) {
    self.network = network
  }
  
  func start() {
    network.getMovies { response in
      print(response)
    }
  }
  
}
