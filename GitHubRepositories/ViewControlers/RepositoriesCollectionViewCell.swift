//
//  RepositoriesCollectionViewCell.swift
//  GitHubRepositories
//
//  Created by HCL on 13/11/2023.
//

import UIKit

class RepositoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 65
            imageView.layer.borderWidth = 3
            imageView.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var nameRepasitoriesLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageImageView: UIImageView!  {
        didSet {
            languageImageView.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var forkImage: UIImageView!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var starsImage: UIImageView!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    public func createCell(item: RepositoriesModel) {
        ApiManager.shared.loadInfo(urlString: item.owner?.avatarURL) { [weak self] (data) in
            self?.imageView.image = UIImage(data: data)
        }
        ApiManager.shared.loadInfo(urlString: item.owner?.userInfo) { [weak self] (data) in
            guard let userInfo = try? JSONDecoder().decode(UserInfo.self, from: data) else {return}
                self?.nameUserLabel.text = userInfo.name
                self?.nameUserLabel.adjustsFontSizeToFitWidth = true
        }
        nameRepasitoriesLabel.text = item.nameRepositories
        descriptionText.text = item.description
        languageLabel.text = item.language
        forkLabel.text = "\(item.forksCount ?? 0)"
        starsLabel.text = "\(item.starsCount ?? 0)"
        
       colorImageLanguage()
    }
    
    private func colorImageLanguage() {
        if languageLabel.text == nil {
            stackView.isHidden = true
        } else {
            stackView.isHidden = false
        }
        switch languageLabel.text {
        case "Ruby":
            languageImageView.tintColor = UIColor(named: "Rubin")
        case "C":
            languageImageView.tintColor = UIColor(named: "C")
        case "Io":
            languageImageView.tintColor = UIColor(named: "Io")
        case "JavaScript":
            languageImageView.tintColor = UIColor(named: "JavaScript")
        case "Erlang":
            languageImageView.tintColor = UIColor(named: "Erlang")
        case "Arc":
            languageImageView.tintColor = UIColor(named: "Arc")
        case "ActionScript":
            languageImageView.tintColor = UIColor(named: "ActionScript")
        case "Emacs Lisp":
            languageImageView.tintColor = UIColor(named: "Emacs")
        case "Python":
            languageImageView.tintColor = UIColor(named: "Python")
        default:
            languageImageView.tintColor = .black
        }
    }
}
