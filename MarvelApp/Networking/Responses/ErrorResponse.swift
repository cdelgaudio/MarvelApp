//
//  ErrorResponse.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
  var code: String
  var message: String
}
