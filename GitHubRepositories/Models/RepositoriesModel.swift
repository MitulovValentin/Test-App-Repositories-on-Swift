//
//  RepositoriesModel.swift
//  GitHubRepositories
//
//  Created by HCL on 16/11/2023.
//

import Foundation


struct RepositoriesModel: Codable {
    let id: Int?
    let owner: Owners?
    let nameRepositories: String?
    let description: String?
    let language: String?
    let forksCount: Int?
    let starsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case owner = "owner"
        case nameRepositories = "name"
        case description = "description"
        case language = "language"
        case forksCount = "forks"
        case starsCount = "stargazers_count"
    }
}

struct Owners: Codable {
    let avatarURL: String?
    let userInfo: String?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case userInfo = "url"
    }
}

