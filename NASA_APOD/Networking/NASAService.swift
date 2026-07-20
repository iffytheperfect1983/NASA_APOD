//
//  NASAService.swift
//  NASA_APOD
//
//  Created by Phanit Pollavith on 7/16/26.
//

import Foundation

enum NetworkError: Error {
  case invalidURL
  case invalidResponse
  case decodingFailure
}

final class NASAService {
  
  private let apiKey = "Pj25BSXFkqX2EO7glBO61f2EhQhybYd4vonFOUYz"
  private let baseURL = "https://api.nasa.gov/planetary/apod"
  
  func fetchAPOD() async throws -> Apod {
    
    guard var components = URLComponents(string: baseURL) else {
      throw NetworkError.invalidURL
    }
    
    components.queryItems = [
      URLQueryItem(name: "api_key", value: apiKey)
    ]
    
    guard let url = components.url else {
      throw NetworkError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      print("invalidResponse 0")
      throw NetworkError.invalidResponse
    }
    
    guard (200...299).contains(httpResponse.statusCode) else {
      print("invalidResponse... Status code not as expected.. status code is: \(httpResponse.statusCode)")
      throw NetworkError.invalidResponse
    }
    
//    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//      throw NetworkError.invalidResponse
//    }
    
    do {
      let decoder = JSONDecoder()
      return try decoder.decode(Apod.self, from: data)
    } catch {
      throw NetworkError.decodingFailure
    }
  }
}
