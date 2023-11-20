//
//  DetailViewController.swift
//  MDHomework
//
//  Created by Илья Капёрский on 21.10.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private enum CustomConstraints: CGFloat {
        case radius5 = 5
        case padding10 = 10
        case padding20 = 20
        case padding40 = 40
        case padding240 = 240
    }
    
    var character: Character? {
        didSet {
            label.text = """
        Name: \(character?.name ?? "Неизвестно")
        Description: \(character?.description ?? "Неизвестно")
        """
            guard let url = URL(string: "\((character?.thumbnail?.path)!).\((character?.thumbnail?.thumbnailExtension)!)") else {
                print ("Bad url")
                return
            }
            
            iconView.kf.setImage(with: url)
        }
    }
    
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.layer.cornerRadius = CustomConstraints.radius5.rawValue
        iconView.clipsToBounds = true
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleToFill
        return iconView
    }()
    
    private lazy var rect: UIView = {
        let rect = UIView()
        rect.layer.cornerRadius = 10
        rect.backgroundColor = .yellow
        rect.clipsToBounds = true
        rect.translatesAutoresizingMaskIntoConstraints = false
        return rect
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewSettings()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        view.addSubview(iconView)
        view.addSubview(rect)
        rect.addSubview(label)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            iconView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CustomConstraints.padding20.rawValue),
            iconView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            iconView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -CustomConstraints.padding20.rawValue),
            iconView.heightAnchor.constraint(equalTo: view.widthAnchor),
            
            rect.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CustomConstraints.padding20.rawValue),
            rect.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -CustomConstraints.padding20.rawValue),
            rect.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -CustomConstraints.padding40.rawValue),
            rect.heightAnchor.constraint(equalToConstant: CustomConstraints.padding240.rawValue),
            
            label.leftAnchor.constraint(equalTo: rect.leftAnchor, constant: CustomConstraints.padding10.rawValue),
            label.topAnchor.constraint(equalTo: rect.topAnchor, constant: CustomConstraints.padding10.rawValue),
            label.bottomAnchor.constraint(equalTo: rect.bottomAnchor, constant: -CustomConstraints.padding10.rawValue),
            label.rightAnchor.constraint(equalTo: rect.rightAnchor, constant: -CustomConstraints.padding10.rawValue)
            
            ])
    }
    
    private func setupViewSettings()
    {
        view.backgroundColor = .systemCyan
        title = character?.name
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

