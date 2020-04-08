//
//  LoadinImageView.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class LoadingImageView: UIView {
  
  private let imageView = UIImageView()
  private let activityIndicatorView = UIActivityIndicatorView(style: .large)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    imageView.contentMode = .scaleAspectFit
    addSubview(imageView)
    imageView.autoPinToSuperview()
    addSubview(activityIndicatorView)
    activityIndicatorView.autoPinToSuperview()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func startLoading() {
    imageView.image = nil
    imageView.backgroundColor = .lightGray
    activityIndicatorView.startAnimating()
  }
  
  func stopLoading(with image: UIImage? = nil) {
    imageView.image = image
    imageView.backgroundColor = .clear
    activityIndicatorView.stopAnimating()
  }
}
