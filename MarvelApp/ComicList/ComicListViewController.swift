//
//  ComicListViewController.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

class ComicListViewController: UIViewController {
  
  private let viewModel: ComicListViewModel
  
  // MARK: Init
  
  init(viewModel: ComicListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    makeView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.start()
  }
  
  // MARK: View

  private func makeView() {
    title = "Comic List"
    view.backgroundColor = .white
  }
}

