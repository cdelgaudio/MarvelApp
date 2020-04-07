//
//  RootCoordinator.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class RootCoordinator: Coordinator {
  
  override func start() {
    child = ComicListCoordinator(navigation: navigation)
  }
}
