//
//  ImageTableViewCell.swift
//  CavistaAssignment
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh Patel. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class ImageTableViewCell: UITableViewCell {
    
    var dataViewModel: HomeDataViewModel? {
        didSet {
            if let id = dataViewModel?.id {
                idLabel.text = "Id: " + id
            } else {
                idLabel.text = ""
            }

            if let date = dataViewModel?.date {
                dateLabel.text = "Date: " + date
            } else {
                dateLabel.text = ""
            }
            
            if let imageUrlString = dataViewModel?.data, let url = URL(string: imageUrlString) {
                cellImage.sd_setImage(with: url, placeholderImage: nil, options: .lowPriority, context: nil)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add views on cell
        addSubview(cellImage)
        addSubview(idLabel)
        addSubview(dateLabel)
        
        cellImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        idLabel.snp.makeConstraints { make in
            make.leading.equalTo(cellImage.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(cellImage.snp.trailing).offset(10)
            make.top.equalTo(idLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cellImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let idLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
