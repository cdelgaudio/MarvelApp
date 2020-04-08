//
//  Binder.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

protocol Bindable: AnyObject {
  associatedtype T
  
  func bind(
    fire: Bool,
    on queue: DispatchQueue?,
    observer: @escaping (T) -> Void
  ) -> Disposable
}

extension Bindable {
  func bind(
    fire: Bool = false,
    on queue: DispatchQueue? = nil,
    observer: @escaping (T) -> Void
  ) -> Disposable {
    bind(fire: fire, on: queue, observer: observer)
  }
}

final class Binder<Observed>: Bindable {
  typealias T = Observed
  
  var value: Observed {
    didSet { observers.array.forEach { $0.callback(value) } }
  }
  
  private var observers = SafeArray(array: [Observer<Observed>]())
  
  init(_ value: Observed) {
    self.value = value
  }
  
  func bind(
    fire: Bool = false,
    on queue: DispatchQueue? = nil,
    observer: @escaping (Observed) -> Void
  ) -> Disposable {
    let callback: (Observed) -> Void
    if let queue = queue {
      callback = { value in
        queue.async {
          observer(value)
        }
      }
    } else {
      callback = observer
    }
    
    let observer = Observer(callback: callback) { [weak self] in
      self?.dispose($0)
    }
    
    observers.array.append(observer)
    
    if fire {
      callback(value)
    }
    
    return observer
  }
  
  private func dispose(_ identifier: UUID) {
    observers.array = observers.array.filter { $0.identifier != identifier }
  }
}

final class ImmutableBinder<Observed>: Bindable {
  typealias T = Observed
  
  var value: Observed { binder.value }
  
  private let binder: Binder<Observed>
  
  init(binder: Binder<Observed>) {
    self.binder = binder
  }
  
  func bind(
    fire: Bool,
    on queue: DispatchQueue?,
    observer: @escaping (ImmutableBinder<Observed>.T) -> Void
  ) -> Disposable {
    return binder.bind(fire: fire, on: queue, observer: observer)
  }
}
