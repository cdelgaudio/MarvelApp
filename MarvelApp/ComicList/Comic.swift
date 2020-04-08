//
//  Comic.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 08/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

// I find it useful to separate the network from the features

struct Comic {
  let id: Int
  let title: String
  let description: String?
  let imagePath: String
}

enum ComicWorker {
  static func format(response: ComicListResponse) -> [Comic] {
    response.data.results.map{
      let imagePath = $0.thumbnail.path + ($0.thumbnail.thumbnailExtension ?? ".jpg")
      return Comic(id: $0.id, title: $0.title, description: $0.description, imagePath: imagePath)
    }
  }
}
