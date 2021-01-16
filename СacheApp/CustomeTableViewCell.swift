//
//  CustomeTableViewCell.swift
//  СacheApp
//
//  Created by Yevhen Shevchenko on 16.01.2021.
//

import UIKit

class CustomeTableViewCell: UITableViewCell {
    
    @IBOutlet var photoImageView: CustomeImageView!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
//    private var content: UIListContentConfiguration!
    
    func configure(with result: Result) {
        if let picture = result.picture, let imageString = picture.medium {
            photoImageView.fetchImage(from: imageString)
        }
        
        fullNameLabel.text = result.name?.fullName
        emailLabel.text = result.email
        
        /*
        content = defaultContentConfiguration()
         
        DispatchQueue.global().async {
            guard let stringURL = result.picture!.medium else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.content.image = UIImage(data: imageData)
                self.content.text = result.name?.fullName
                self.content.secondaryText = result.email
                self.contentConfiguration = self.content
            }
        }
         */
    }
    
    /*
    override func layoutSubviews() {
        super.layoutSubviews()
        content.imageProperties.cornerRadius = frame.height / 2
    }
     */
}
