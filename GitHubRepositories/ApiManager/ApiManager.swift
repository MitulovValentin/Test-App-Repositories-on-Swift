//
//  ApiManager.swift
//  GitHubRepositories
//
//  Created by HCL on 16/11/2023.
//

import Foundation


class ApiManager {
    static let shared = ApiManager()
    private init(){}
    
    
    func getAllRepositories(completion: @escaping (FullNameModels) -> ()) {
            let allRepositoriesURL = URL(string: "https://api.github.com/repositories")
            var requestAllrepositores = URLRequest(url: allRepositoriesURL!)
            requestAllrepositores.httpMethod = "GET"
            requestAllrepositores.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
            requestAllrepositores.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: requestAllrepositores) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let myData = data {
                    do {
                        let list = try JSONDecoder().decode(FullNameModels.self, from: myData)
                            DispatchQueue.main.async {
                                completion(list)
                        }
                    } catch {
                        print("Error: ", error)
                    }
                }
            }
            task.resume()
    }
    
    func fetchRepositories(completion: @escaping ([RepositoriesModel])->() ){
        getAllRepositories { list in
            var repositories = [RepositoriesModel]()
            for object in list {
                if let urlFullNameString = object.url {
                    if let urlFullName = URL(string: urlFullNameString) {
                        var request = URLRequest(url: urlFullName)
                        request.httpMethod = "GET"
                        request.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
                        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                            DispatchQueue.main.async {
                                if let data = data, let repository = try? JSONDecoder().decode(RepositoriesModel.self, from: data) {
                                    repositories.append(repository)
                                    repositories.sort(by: {$0.id! < $1.id!})
                                    completion(repositories)
                                }
                            }
                        }
                        task.resume()
                    }
                }
            }
        }
    }

    public func loadInfo(urlString: String?, completion: @escaping (Data)->()) {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        if let data = data {
                            completion(data)
                        }
                    }
                }
                task.resume()
            }
        }
    }
}
                                               
