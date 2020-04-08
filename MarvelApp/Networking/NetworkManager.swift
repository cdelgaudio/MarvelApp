//
//  NetworkManager.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

enum NetworkError: Error {
  case parsing(description: String)
  case network(description: String)
  case request
  
  var message: String {
    switch self {
    case .network(let description):
      return description
    default:
      return localizedDescription
    }
  }
}

typealias NetworkResult<D: Decodable> = Result<D, NetworkError>


protocol Networking: AnyObject {
  func getMovies(completion: @escaping (NetworkResult<ComicListResponse>) -> Void)
  func getImage(path: String, completion: @escaping (NetworkResult<Data>) -> Void)
}

final class NetworkManager {
  
  private let session = URLSession(configuration: .ephemeral)
  
  @discardableResult
  private func get<D: Decodable>(
    url: URL?,
    completion: @escaping (NetworkResult<D>) -> Void
  ) -> URLSessionDataTask? {
    guard let url = url else {
      completion(.failure(.request))
      return nil
    }
    
    let task = session.codableTask(with: url, completionHandler: completion)
    task.resume()
    return task
  }
  
  @discardableResult
   private func download(
     url: URL?,
     completion: @escaping (NetworkResult<Data>) -> Void
   ) -> URLSessionDownloadTask? {
     guard let url = url else {
       completion(.failure(.request))
       return nil
     }
     
     let task = session.downloadTask(with: url, completionHandler: completion)
     task.resume()
     return task
   }
}

extension NetworkManager: Networking {
  func getImage(path: String, completion: @escaping (NetworkResult<Data>) -> Void) {
    download(url: URL(string: path), completion: completion)
  }
  
  func getMovies(completion: @escaping (NetworkResult<ComicListResponse>) -> Void) {
    get(url: NetworkRequest.comics.url, completion: completion)
  }
  
}

// MARK: URLSession

private extension URLSession {
  func codableTask<D: Decodable>(
    with url: URL,
    completionHandler: @escaping (NetworkResult<D>) -> Void
  ) -> URLSessionDataTask {
    self.dataTask(with: url) { data, response, error in
      guard let data = data else {
        let errorDescription = error?.localizedDescription ?? "No Data"
        completionHandler(.failure(.network(description: errorDescription)))
        return
      }
      let decoder = JSONDecoder()
      do {
        completionHandler(.success(try decoder.decode(D.self, from: data)))
      } catch {
        if let message = try? decoder.decode(ErrorResponse.self, from: data).message {
          completionHandler(.failure(.network(description: message)))
        } else {
          let networkError = NetworkError.parsing(description: error.localizedDescription)
          completionHandler(.failure(networkError))
        }
      }
    }
  }
  
  func downloadTask(
    with url: URL,
    completionHandler: @escaping (NetworkResult<Data>) -> Void
  ) -> URLSessionDownloadTask {
    self.downloadTask(with: url) { path, response, error in
      guard let path = path else {
        let errorDescription = error?.localizedDescription ?? "No Path"
        completionHandler(.failure(.network(description: errorDescription)))
        return
      }
      do {
        completionHandler(.success(try Data(contentsOf: path)))
      } catch {
        let error = NetworkError.parsing(description: error.localizedDescription)
        completionHandler(.failure(error))
      }
    }
  }
}
