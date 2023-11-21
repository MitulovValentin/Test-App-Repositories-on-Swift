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
                print("Hello 1")
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let myData = data {
                    print("Hello 2")
                    print(String(data: myData, encoding: .utf8))
                    do {
                        print("Hello 3")

                        let list = try JSONDecoder().decode(FullNameModels.self, from: myData)
                        print(list)
                            DispatchQueue.main.async {
                                completion(list)
                                print("Hello 4")
                        }
                    } catch {
                        print("Error: ", error)
                    }
                    
                }
            }
            task.resume()
    }
    
    func fetchRepositories(completion: @escaping ([RepositoriesModel])->() ){
        print("Step 1")
        getAllRepositories { list in
            print("Step 2")
            var repositories = [RepositoriesModel]()
            for object in list {
                print("Step 3")
                if let urlFullNameString = object.url {
                    print("Step 4")
                    if let urlFullName = URL(string: urlFullNameString) {
                        print("Step 5")
                        var request = URLRequest(url: urlFullName)
                        request.httpMethod = "GET"
                        request.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
                        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                            print("Step 6")
                            DispatchQueue.main.async {
                                print("Step 7")
                                if let data = data, let repository = try? JSONDecoder().decode(RepositoriesModel.self, from: data) {
                                    repositories.append(repository)
                                    repositories.sort(by: {$0.id! < $1.id!})
                                    print(repositories)
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
                                               
