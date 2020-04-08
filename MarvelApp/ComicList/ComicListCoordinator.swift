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
    let state: Binder<ComicListViewModel.State>  = Binder(.failed(message: ""))
    let viewModel = ComicListViewModel(network: NetworkManager(), state: state)
    let viewController = ComicListViewController(
      viewModel: viewModel,
      state: ImmutableBinder(binder: state)
    )
    navigation.pushViewController(viewController, animated: false)
  }
}
