//
//  ComicListResponse.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

// MARK: - ComicListResponse
struct ComicListResponse: Codable {
  let code: Int
  let status: String
  let data: DataClass
  
  // MARK: - DataClass
  struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Comic]
  }

  // MARK: - Result
  struct Comic: Codable {
    let id: Int
    let title: String
    let issueNumber: Int
    let prices: [Price]
    let thumbnail: Thumbnail
    let creators: Creators
  }

  // MARK: - Characters
  struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [Series]
    let returned: Int
  }

  // MARK: - Series
  struct Series: Codable {
    let resourceURI: String
    let name: String
  }

  // MARK: - Creators
  struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
  }

  // MARK: - CreatorsItem
  struct CreatorsItem: Codable {
    let resourceURI: String
    let name: String
    let role: Role
  }

  enum Role: String, Codable {
    case colorist = "colorist"
    case editor = "editor"
    case inker = "inker"
    case letterer = "letterer"
    case penciler = "penciler"
    case penciller = "penciller"
    case pencillerCover = "penciller (cover)"
    case writer = "writer"
  }


  // MARK: - Thumbnail
  struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
      case path
      case thumbnailExtension
    }
  }

  // MARK: - Price
  struct Price: Codable {
    let type: PriceType
    let price: Double
  }

  enum PriceType: String, Codable {
    case printPrice = "printPrice"
  }
}

