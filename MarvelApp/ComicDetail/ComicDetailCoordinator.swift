//
//  ComicDetailCoordinator.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class ComicDetailCoordinator: Coordinator {
  
  private let comic: Comic
  private let network: Networking
  
  init(navigation: UINavigationController, comic: Comic, network: Networking) {
    self.comic = comic
    self.network = network
    super.init(navigation: navigation)
  }
  
  override func start() {
    let state: Binder<ComicDetailViewModel.State> = Binder(.failed)
    let viewModel = ComicDetailViewModel(comic: comic, state: state, network: network)
    let viewController = ComicDetailViewController(
      viewModel: viewModel,
      state: ImmutableBinder(binder: state)
    )
    navigation.pushViewController(viewController, animated: true)
  }

}
