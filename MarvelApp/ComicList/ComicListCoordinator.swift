//
//  ComicListCoordinator.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class ComicListCoordinator: Coordinator {
  
  override func start() {
    let viewModel = ComicListViewModel(network: NetworkManager())
    let viewController = ComicListViewController(viewModel: viewModel)
    navigation.pushViewController(viewController, animated: false)
  }
}
