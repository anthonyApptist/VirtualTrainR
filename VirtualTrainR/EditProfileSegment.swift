//
//  EditProfileSegment.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-23.
//  Copyright © 2017 Apptist. All rights reserved.
//

import UIKit

/*
private let reuseIdentifier = "EditButtonCell"

var selectedItems = [String]()

class EditProfileSegment: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let nextBtn = UIButton()
    
    let itemBtnNotification = Notification.Name("ItemBtnPressed")
    let closeBtnNotification = Notification.Name("CloseBtnPressed")
    
    var tag: Int!
    var itemCount: Int!
    
    var noneSelected = true
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = collectionView!.frame.width / 2
        let height = collectionView!.frame.height / 10
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        layout.headerReferenceSize = CGSize(width: width, height: height)
        
        // collection view
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(EditButtonCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        nextBtn.setImage(#imageLiteral(resourceName: "right_arrow_green_bt"), for: .normal)
        self.view.addSubview(nextBtn)
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo:  self.view.bottomAnchor, constant: -20).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor, constant: -20).isActive = true
        nextBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        nextBtn.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        /*
        switch tag {
        case 0:
            itemCount = trainingInterests.count
        case 1:
            itemCount = fitnessGoals.count
        case 2:
            itemCount = trainingFrequencies.count
        case 3:
            itemCount = dayFields.count
        case 4:
            itemCount = timeFields.count
        case 5:
            itemCount = travelFields.count
        default:
            break
        }
        NotificationCenter.default.addObserver(self, selector: #selector(showNextBtn), name: itemBtnNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeView), name: closeBtnNotification, object: nil)
        */
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 1, height: 50)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EditButtonCell
    
        /*
        switch tag {
        case 0:
            cell.itemBtn1.titleLbl.text = trainingInterests[indexPath.row]
        case 1:
            cell.itemBtn1.titleLbl.text = fitnessGoals[indexPath.row]
        case 2:
            cell.itemBtn1.titleLbl.text = trainingFrequencies[indexPath.row]
        case 3:
            cell.itemBtn1.titleLbl.text = dayFields[indexPath.row]
        case 4:
            cell.itemBtn1.titleLbl.text = timeFields[indexPath.row]
        case 5:
            cell.itemBtn1.titleLbl.text = travelFields[indexPath.row]
        default:
            break
        }
        // Configure the cell
        */
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

            
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        
        headerView.backgroundColor = UIColor.lightGray
        /*
        switch tag {
        case 0:
            headerView.titleLbl.text = editSegmentTitles[0]
        case 1:
            headerView.titleLbl.text = editSegmentTitles[1]
        case 2:
            headerView.titleLbl.text = editSegmentTitles[2]
        case 3:
            headerView.titleLbl.text = editSegmentTitles[3]
        case 4:
            headerView.titleLbl.text = editSegmentTitles[4]
        case 5:
            headerView.titleLbl.text = editSegmentTitles[5]
        default:
            break
        }
        */
        return headerView
    }
    
    func showNextBtn(_ notification: Notification) {
        for index in 0...itemCount {
                noneSelected = false
        }
        
        if noneSelected {
            nextBtn.isHidden = true
        } else {
            nextBtn.isHidden = false
        }
    }
    
    func closeView(_ notification: Notification) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func nextBtnPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}

class EditButtonCell: UICollectionViewCell {
    
    let itemBtn1 = SelectedItemButton()
    
    let itemBtnNotification = Notification.Name("ItemBtnPressed")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(itemBtn1)
        itemBtn1.translatesAutoresizingMaskIntoConstraints = false
        itemBtn1.titleLbl.text = "Button"
        itemBtn1.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        itemBtn1.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        itemBtn1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        itemBtn1.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        itemBtn1.addTarget(self, action: #selector(itemBtnPressed), for: .touchUpInside)
    }
    
    func itemBtnPressed(sender: SelectedItemButton) {
        if !self.isSelected {
            selectedItems.append(sender.titleLbl.text!)
        }
         NotificationCenter.default.post(name: itemBtnNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HeaderView: UICollectionReusableView {
    
    var titleLbl: VTLabel!
    var exitBtn: VTButton!
    
    let closeBtnNotification = Notification.Name("CloseBtnPressed")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lightGray
        
        self.exitBtn = VTButton()
        self.addSubview(exitBtn)
        exitBtn.setImage(#imageLiteral(resourceName: "cancel_button.png"), for: .normal)
        exitBtn.translatesAutoresizingMaskIntoConstraints = false
        exitBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        exitBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        exitBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        exitBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        exitBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        
        self.titleLbl = VTLabel()
        self.addSubview(titleLbl)
        titleLbl.text = "Title"
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.leadingAnchor.constraint(equalTo: exitBtn.trailingAnchor, constant: 20).isActive = true
        titleLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        titleLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
    }
    
    func closeBtnPressed() {
        NotificationCenter.default.post(name: closeBtnNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/
