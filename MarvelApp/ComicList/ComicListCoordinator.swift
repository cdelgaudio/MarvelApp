//
//  ComicListCoordinator.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class ComicListCoordinator: Coordinator {
  
  private let network = NetworkManager()
  
  private let cache = CacheManager()
  
  override func start() {
    let state: Binder<ComicListViewModel.State>  = Binder(.failed(message: ""))
    let viewModel = ComicListViewModel(
      state: state,
      coordinator: self,
      network: network,
      cache: cache
    )
    let viewController = ComicListViewController(
      viewModel: viewModel,
      state: ImmutableBinder(binder: state)
    )
    navigation.pushViewController(viewController, animated: false)
  }
}

extension ComicListCoordinator: ComicListCoordinating {
  func routeToDetails(comic: Comic) {
    child = ComicDetailCoordinator(navigation: navigation, comic: comic, network: network, cache: cache)
  }
}
