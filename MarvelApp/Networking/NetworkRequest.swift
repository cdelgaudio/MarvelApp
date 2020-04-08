//
//  NetworkRequest.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

// To respect the deadline I handled just the Get requests
enum NetworkRequest {
  case comics
  
  var url: URL? {
    switch self {
    case .comics:
      var urlComponents = URLComponents()
      urlComponents.scheme = scheme
      urlComponents.host = host
      urlComponents.path = path
      urlComponents.queryItems = params
      return urlComponents.url
    }
  }
  
  private var scheme: String? {
    switch self {
    case .comics:
      return "http"
    }
  }
  
  private var host: String {
    switch self {
    case .comics:
      return "gateway.marvel.com"
    }
  }
  
  private var path: String {
    switch self {
    case .comics:
      return "/v1/public/comics"
    }
  }
  
  private var params: [URLQueryItem]? {
    switch self {
    case .comics:
      let ts = "\(Date().timeIntervalSince1970)"
      let hash = (ts + ApiKeys.privateKey + ApiKeys.publicKey).md5
      
      return [
        .init(name: "apikey", value: ApiKeys.publicKey),
        .init(name: "ts", value: ts),
        .init(name: "hash", value: hash)
      ]
    }
  }
  
  private enum ApiKeys {
    static let publicKey = "4e695424d197597e2977983e02445b3e"
    static let privateKey = "dba786031023974c794040b19073df8b12e61aed"
  }
}
