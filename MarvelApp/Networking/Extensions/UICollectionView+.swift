//
//  UICollectionView+.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

extension UICollectionView {
  func register<Cell: UICollectionViewCell>(_: Cell.Type) {
      register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
  }
  
  func dequeue<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
    dequeueReusableCell(
      withReuseIdentifier: Cell.identifier,
      for: indexPath
    ) as! Cell
  }
}

extension UICollectionViewCell {
  static let identifier = String(describing: self)
}


