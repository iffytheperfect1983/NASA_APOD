//
//  APODViewModel.swift
//  NASA_APOD
//
//  Created by Phanit Pollavith on 7/16/26.
//

import Foundation
import Combine

@MainActor
final class APODViewModel: ObservableObject {
  
  @Published var apod: Apod?
  @Published var isLoading = false
  @Published var errorMessage: String?
  
  private let service = NASAService()
  
  func loadAPOD() async {
    isLoading = true
    errorMessage = nil
    
    do {
      apod = try await service.fetchAPOD()
    } catch let error as NetworkError {
      switch error {
      case .invalidURL: errorMessage = "Invalid URL"
      case .invalidResponse: errorMessage = "Invalid response"
      case .decodingFailure: errorMessage = "Failed to decode response"
      }
    } catch {
      errorMessage = "Couldn't load today's picture.. Please try again.."
    }
    
    isLoading = false
  }
  
}
