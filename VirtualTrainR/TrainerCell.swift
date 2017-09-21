//
//  TrainerCell.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-04-18.
//  Copyright © 2017 Apptist. All rights reserved.
//

import UIKit

class TrainerCell: UITableViewCell {
    /*
    let star1 = UIImageView()
    let star2 = UIImageView()
    let star3 = UIImageView()
    let star4 = UIImageView()
    let star5 = UIImageView()
    
    let goldStar = #imageLiteral(resourceName: "full_star")
    let emptyStar = #imageLiteral(resourceName: "empty_star")
 
    let locationIcon = UIImageView()
     let mailBtn = UIImageView()
     let likeBtn = UIImageView()
    */
    
    // default image
    let trainerImage = #imageLiteral(resourceName: "profile_ic.png") // profile_ic.png
    
    // View Properties
    var trainerImageView = UIImageView()
    var nameLbl = UILabel()
    var locationLbl = UILabel()
    var bookBtn = UIButton(type: .system)
    
    // scheduling
    var schedulingDelegate: StartScheduling?
    
    // cell trainer
    var cellTrainer: Trainer?
 
    // Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // image view of trainer
        trainerImageView.layer.cornerRadius = (contentView.frame.width * 0.2)/2
        trainerImageView.layer.masksToBounds = true
        trainerImageView.clipsToBounds = true
        trainerImageView.contentMode = .scaleAspectFit
        contentView.addSubview(trainerImageView)
        trainerImageView.translatesAutoresizingMaskIntoConstraints = false
        trainerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        trainerImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        trainerImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        trainerImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        
        // name label
        nameLbl.font = UIFont(name: standardFont, size: 14)
        nameLbl.textAlignment = .left
        nameLbl.textColor = UIColor.black
        self.addSubview(nameLbl)
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.leadingAnchor.constraint(equalTo: trainerImageView.trailingAnchor, constant: 25).isActive = true
        nameLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        nameLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        nameLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        
        // location label
        locationLbl.font = UIFont(name: standardFont, size: 14)
        locationLbl.adjustsFontSizeToFitWidth = true
        locationLbl.textAlignment = .left
        locationLbl.textColor = UIColor.lightGray
        self.addSubview(locationLbl)
        locationLbl.translatesAutoresizingMaskIntoConstraints = false
        locationLbl.topAnchor.constraint(equalTo: self.nameLbl.bottomAnchor).isActive = true
        locationLbl.leadingAnchor.constraint(equalTo: trainerImageView.trailingAnchor, constant: 25).isActive = true
        locationLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.40).isActive = true
        locationLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        
        // book button
        bookBtn.titleLabel?.font = UIFont(name: standardFont, size: 14)
        bookBtn.setTitle("Select to book", for: .normal)
        bookBtn.setTitleColor(UIColor.blue, for: .normal)
        bookBtn.titleLabel?.adjustsFontSizeToFitWidth = true
//        bookBtn.addTarget(self, action: #selector(bookBtnFunction), for: .touchUpInside)
        bookBtn.isUserInteractionEnabled = false
        self.addSubview(bookBtn)
        bookBtn.translatesAutoresizingMaskIntoConstraints = false
        bookBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        bookBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bookBtn.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.20).isActive = true
        bookBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        
        /*
        locationIcon.image = #imageLiteral(resourceName: "location_gray_ic.png")
        self.addSubview(locationIcon)
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.leadingAnchor.constraint(equalTo: self.nameLbl.leadingAnchor, constant: 0).isActive = true
        locationIcon.centerYAnchor.constraint(equalTo: self.locationLbl.centerYAnchor).isActive = true
        locationIcon.widthAnchor.constraint(equalTo: self.locationLbl.widthAnchor, multiplier: 0.1).isActive = true
        locationIcon.heightAnchor.constraint(equalTo: self.locationLbl.heightAnchor, multiplier: 0.6).isActive = true
        
        star1.image = goldStar
        star1.contentMode = .scaleAspectFit
        self.addSubview(star1)
        star1.translatesAutoresizingMaskIntoConstraints = false
        star1.leadingAnchor.constraint(equalTo: self.nameLbl.leadingAnchor, constant: 0).isActive = true
        star1.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: 10).isActive = true
        star1.widthAnchor.constraint(equalTo: locationLbl.widthAnchor, multiplier: 0.2).isActive = true
        star1.heightAnchor.constraint(equalTo: locationLbl.heightAnchor, multiplier: 0.6).isActive = true
        
        star2.image = goldStar
        star2.contentMode = .scaleAspectFit
        self.addSubview(star2)
        star2.translatesAutoresizingMaskIntoConstraints = false
        star2.leadingAnchor.constraint(equalTo: self.star1.trailingAnchor, constant: 0).isActive = true
        star2.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: 10).isActive = true
        star2.widthAnchor.constraint(equalTo: locationLbl.widthAnchor, multiplier: 0.2).isActive = true
        star2.heightAnchor.constraint(equalTo: locationLbl.heightAnchor, multiplier: 0.6).isActive = true
        
        star3.image = goldStar
        star3.contentMode = .scaleAspectFit
        self.addSubview(star3)
        star3.translatesAutoresizingMaskIntoConstraints = false
        star3.leadingAnchor.constraint(equalTo: self.star2.trailingAnchor, constant: 0).isActive = true
        star3.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: 10).isActive = true
        star3.widthAnchor.constraint(equalTo: locationLbl.widthAnchor, multiplier: 0.2).isActive = true
        star3.heightAnchor.constraint(equalTo: locationLbl.heightAnchor, multiplier: 0.6).isActive = true
        
        star4.image = goldStar
        star4.contentMode = .scaleAspectFit
        self.addSubview(star4)
        star4.translatesAutoresizingMaskIntoConstraints = false
        star4.leadingAnchor.constraint(equalTo: self.star3.trailingAnchor, constant: 0).isActive = true
        star4.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: 10).isActive = true
        star4.widthAnchor.constraint(equalTo: locationLbl.widthAnchor, multiplier: 0.2).isActive = true
        star4.heightAnchor.constraint(equalTo: locationLbl.heightAnchor, multiplier: 0.6).isActive = true
        
        star5.image = emptyStar
        star5.contentMode = .scaleAspectFit
        self.addSubview(star5)
        star5.translatesAutoresizingMaskIntoConstraints = false
        star5.leadingAnchor.constraint(equalTo: self.star4.trailingAnchor, constant: 0).isActive = true
        star5.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: 10).isActive = true
        star5.widthAnchor.constraint(equalTo: locationLbl.widthAnchor, multiplier: 0.2).isActive = true
        star5.heightAnchor.constraint(equalTo: locationLbl.heightAnchor, multiplier: 0.6).isActive = true
         
        mailBtn.image = #imageLiteral(resourceName: "mail_sub_ic")
        self.addSubview(mailBtn)
        mailBtn.contentMode = .scaleAspectFit
        mailBtn.translatesAutoresizingMaskIntoConstraints = false
        mailBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        mailBtn.topAnchor.constraint(equalTo: self.nameLbl.topAnchor, constant: 0).isActive = true
        mailBtn.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
        mailBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
        
        likeBtn.image = #imageLiteral(resourceName: "favorite_ic")
        self.addSubview(likeBtn)
        likeBtn.contentMode = .scaleAspectFit
        likeBtn.translatesAutoresizingMaskIntoConstraints = false
        likeBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        likeBtn.topAnchor.constraint(equalTo: self.mailBtn.bottomAnchor, constant: 20).isActive = true
        likeBtn.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
        likeBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true
         */
    }
    
    /*
    // MARK: - Book Btn Function
    func bookBtnFunction() {
        self.schedulingDelegate?.selectedBook(trainer: self.cellTrainer!)
    }
    */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    */
}
