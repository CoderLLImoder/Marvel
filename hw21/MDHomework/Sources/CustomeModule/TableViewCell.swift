//
//  TableViewCell.swift
//  MDHomework
//
//  Created by Илья Капёрский on 06.11.2023.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {

    static let id = "CustomCell"
    
    private enum CustomConstants: CGFloat {
        case padding15 = 15
        case padding20 = 20
        case padding25 = 25
        case imgHeight50 = 60
        case radius5 = 5
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var character: Character? {
        didSet {
            label.text = character?.name
            guard let url = URL(string: "\((character?.thumbnail?.path)!).\((character?.thumbnail?.thumbnailExtension)!)") else {
                print ("Bad url")
                return
            }
            
            iconView.kf.setImage(with: url) { [weak self] result in
                switch result
                {
                case .success(let img):
                    self?.iconView.image = img.image.resizeImage(50, 50)
                case .failure(let error):
                    self?.iconView.image = UIImage(systemName: "house")
                    print(error)
                }
            }
            
        }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.layer.cornerRadius = CustomConstants.radius5.rawValue
        iconView.clipsToBounds = true
        iconView.contentMode = .scaleAspectFit
        return iconView
    }()

    private func setupHierarchy() {
        contentView.addSubview(iconView)
        contentView.addSubview(label)
    }
    
    private func setupLayout() {
        
        iconView.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        iconView.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            iconView.heightAnchor.constraint(equalToConstant: CustomConstants.imgHeight50.rawValue),
            iconView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            label.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: CustomConstants.padding15.rawValue),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
}

extension UIImage {
    func resizeImage(_ width: Int, _ height: Int)-> UIImage?{
        let newSize = CGSize(width: width, height: height) // Новый размер изображения
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
