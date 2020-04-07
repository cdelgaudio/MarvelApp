//
//  Coordinator.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

class Coordinator: NSObject {
  
  weak var parent: Coordinator?
  
  var child: Coordinator? {
    didSet {
      child?.parent = self
      child?.start()
      child?.navigation.delegate = child
    }
  }
  
  let navigation: UINavigationController
  
  init(navigation: UINavigationController) {
    self.navigation = navigation
  }
  
  // Override this
  func start() {
    fatalError("Build screen failed")
  }
}

extension Coordinator: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    guard
      let fromViewController = navigationController
        .transitionCoordinator?
        .viewController(forKey: .from),
      !navigationController.viewControllers.contains(fromViewController)
      else { return }
    parent?.navigation.delegate = parent
    parent?.child = nil
  }
}
