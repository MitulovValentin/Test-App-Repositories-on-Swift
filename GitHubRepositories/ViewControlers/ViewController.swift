//
//  ViewController.swift
//  GitHubRepositories
//
//  Created by HCL on 13/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var arrayRepositories = [RepositoriesModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ApiManager.shared.fetchRepositories { [weak self] (repositories) in
            self?.arrayRepositories = repositories
            self?.collectionView.reloadData()
        }
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayRepositories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepositoriesCell", for: indexPath) as? RepositoriesCollectionViewCell else {return UICollectionViewCell()}
        let item = arrayRepositories[indexPath.item]
        cell.createCell(item: item)
        cell.layer.cornerRadius = 6
                return cell
    }
}
