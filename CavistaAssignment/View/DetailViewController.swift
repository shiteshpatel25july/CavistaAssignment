//
//  DetailViewController.swift
//  CavistaAssignment
//
//  Created by Shitesh Patel on 14/08/20.
//  Copyright © 2020 Shitesh Patel. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class DetailViewController: UIViewController {

    var detailDataViewModel: HomeDataDetailViewModel? {
        didSet {
            if let id = detailDataViewModel?.id {
                idLabel.text = "Id: " + id
            } else {
                idLabel.text = ""
            }
            
            if let date = detailDataViewModel?.date {
                dateLabel.text = "Date: " + date
            } else {
                dateLabel.text = ""
            }

            if detailDataViewModel?.type == DataType.image {
                if let imageUrlString = detailDataViewModel?.data, let url = URL(string: imageUrlString) {
                    imageView.sd_setImage(with: url, placeholderImage: nil, options: .lowPriority, context: nil)
                }
            } else {
                descriptionLabel.text = detailDataViewModel?.data
            }
        }
    }

    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let idLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()

    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        label.sizeToFit()
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        setupView()
    }

    private func setupView() {
        self.view.addSubview(imageView)
        self.view.addSubview(idLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(descriptionLabel)

        //Set constraints

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(114)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            if detailDataViewModel?.type == DataType.image {
                make.height.equalTo(100)
            } else {
                make.height.equalTo(0)
            }
        }

        idLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }

        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(idLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
