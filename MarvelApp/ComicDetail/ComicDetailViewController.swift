//
//  ComicDetailViewController.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

class ComicDetailViewController: UIViewController {
  
  private let viewModel: ComicDetailViewModel
  
  private let state: ImmutableBinder<ComicDetailViewModel.State>
  
  private var disposeBag: [Disposable] = []
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.autoPinDimensions(CGSize(width: 300, height: 300))
    return imageView
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.text = viewModel.comic.title
    label.font = label.font.withSize(25)
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var descriptionTextView: UITextView = {
    let textView = UITextView(frame: .zero)
    textView.isScrollEnabled = false
    textView.text = viewModel.comic.description
    textView.font = textView.font?.withSize(18)
    return textView
  }()
  
  init(viewModel: ComicDetailViewModel, state: ImmutableBinder<ComicDetailViewModel.State>) {
    self.viewModel = viewModel
    self.state = state
    super.init(nibName: nil, bundle: nil)
    makeView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    makeBindings()
    viewModel.start()
  }
  
  private func makeView() {
    title = "Comic Details"
    view.backgroundColor = .white
    let stack = UIStackView(arrangedSubviews: [
      titleLabel,
      imageView,
      descriptionTextView,
      .flexibleSpacer()
    ])
    stack.axis = .vertical
    stack.alignment = .center
    stack.spacing = 10
    view.addSubview(stack)
    stack.autoPinToSuperview(margin: 20, safe: true)
  }
  
  private func makeBindings() {
    let disposable = state.bind(on: .main) { [weak self] state in
      guard let self = self else { return }
      switch state {
      case .failed:
        self.imageView.image = nil
      case .loading:
        self.imageView.image = nil
      case .completed(let data):
        self.imageView.image = UIImage(data: data)
      }
    }
    disposeBag.append(disposable)
  }
}
