//
//  ComicItemCell.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class ComicItemCell: UICollectionViewCell {
  
  // MARK: Properties
  
  private let titleLabel = UILabel()
  
  private let loadingImageView = LoadingImageView(frame: .zero)
  
  private var viewModel: ComicItemViewModel?
  
  private var disposeBag: [Disposable] = []
  
  // MARK: Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    makeView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag.forEach { $0.dispose($0.identifier) }
  }
  
  func configure(viewModel: ComicItemViewModel) {
    self.viewModel = viewModel
    makeBindings()
    titleLabel.text = viewModel.title
    viewModel.start()
  }
  
  // MARK: Bindings
  
  private func makeBindings() {
    guard let viewModel = viewModel else { return }
    let disposable = viewModel.imageState.bind(fire: true, on: .main) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .failed:
        self.loadingImageView.stopLoading()
      case .loading:
        self.loadingImageView.startLoading()
      case .completed(let data):
        self.loadingImageView.stopLoading(with: UIImage(data: data))
      }
    }
    disposeBag.append(disposable)
  }
  
  // MARK: View
  
  private func makeView() {
    makeImageView()
    makeTitleLabel()
  }
  
  private func makeImageView() {
    contentView.addSubview(loadingImageView)
    loadingImageView.autoPinToSuperview()
  }
  
  private func makeTitleLabel() {
    titleLabel.textColor = .white
    titleLabel.backgroundColor = .darkGray
    titleLabel.numberOfLines = 5
    titleLabel.textAlignment = .center
    contentView.addSubview(titleLabel)
    titleLabel.autoPinToSuperview(edges: [.bottom(), .left(), .right()])
  }
  
}
