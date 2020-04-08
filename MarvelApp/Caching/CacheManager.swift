//
//  CacheManager.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

protocol Caching: AnyObject {
  func getImage(for path: String?) -> Data?
  func setImage(image: Data, path: String?)
}

final class CacheManager: Caching {
  
  private let cache = NSCache<AnyObject, NSData>()
  
  func getImage(for path: String?) -> Data? {
    cache.object(forKey: path as AnyObject) as Data?
  }
  
  func setImage(image: Data, path: String?) {
    cache.setObject(image as NSData, forKey: path as AnyObject)
  }
  
}
