//
//  ComicListViewModel.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation


final class ComicListViewModel {
  
  private let networking: Networking
  
  init(networking: Networking) {
    self.networking = networking
  }
  
  func start() {
    print("Start")
  }
  
}
