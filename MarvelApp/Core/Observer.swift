//
//  Observer.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

protocol Disposable: AnyObject {
  
  var identifier: UUID { get }
  
  var dispose: (UUID) -> Void { get }
  
}

protocol Observable: AnyObject {
  associatedtype Observed
    
  var callback: (Observed) -> Void { get }
}

final class Observer<Observed>: Observable, Disposable {
  
  let identifier = UUID()
  
  let dispose: (UUID) -> Void
  
  var callback: (Observed) -> Void
  
  init(callback: @escaping (Observed) -> Void, dispose: @escaping (UUID) -> Void) {
    self.dispose = dispose
    self.callback = callback
  }
  
  deinit {
    dispose(identifier)
  }
}
