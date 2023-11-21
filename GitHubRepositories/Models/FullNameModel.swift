//
//  FullNameModel.swift
//  GitHubRepositories
//
//  Created by HCL on 16/11/2023.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fullNameModels = try? JSONDecoder().decode(FullNameModels.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fullNameModels = try? JSONDecoder().decode(FullNameModels.self, from: jsonData)

import Foundation

// MARK: - FullNameModel
struct FullNameModel: Codable {
    let url: String?

    enum CodingKeys: String, CodingKey {
        case url
    }
}

typealias FullNameModels = [FullNameModel]



