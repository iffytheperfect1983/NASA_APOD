//
//  Apod.swift
//  NASA_APOD
//
//  Created by Phanit Pollavith on 7/16/26.
//

import Foundation

// MARK: - Apod
struct Apod: Codable {
  let copyright, date, explanation: String
  let hdurl: String
  let mediaType, serviceVersion, title: String
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case copyright, date, explanation, hdurl
    case mediaType = "media_type"
    case serviceVersion = "service_version"
    case title, url
  }
}
