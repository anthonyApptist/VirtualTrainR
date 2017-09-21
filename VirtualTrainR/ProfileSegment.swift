//
//  ProfileVC.swift
//  VirtualTrainr
//
//  Created by Mark Meritt on 2017-06-20.
//  Copyright © 2017 Apptist. All rights reserved.
//

import UIKit
import CoreLocation

/*
 * Create sections count based on array of saved in memory
 * set data model
 */

protocol SubScrollDelegate {
    func tableViewScrollViewDidScroll(_ scrollView: UIScrollView)
}

class ProfileSegment: UITableViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var locationText: UILabel!
    @IBOutlet var nameText: UILabel!
    
    // location manager
//    let locationManager = CLLocationManager()
    
    // load profile
    var loadProfile: VTLoadProfile?
 
    // models
    var client: Client?
    var trainer: Trainer?
    
    // delegate
    var scrollDelegate: SubScrollDelegate!
    
    // book delegate for discover trainer
    var startBooking: SelectedTrainerToBook?
    
    // resized image from image picker
    var resizedImg: UIImage?
    
    // section titles (training interests is activities)
    let clientSections = ["About Me", "Location", "Switch to Trainer", "Sign Out"]
    let trainerSections = ["About Me", "Certifications", "Switch to Client", "Sign Out"]
    let discoverTrainerSections = ["About Me", "Certifications", "Book"]
    let discoverClientSections = ["About Me", "Locations"]
    
    // MARK: - Override ScrollViewDidScroll
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollDelegate.tableViewScrollViewDidScroll(scrollView)
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register Cells
        self.tableView.register(EditTableCell.self, forCellReuseIdentifier: "EditTableCell")
        self.tableView.register(ProfileTableCell.self, forCellReuseIdentifier: "ProfileTableCell")
        self.tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeader")
        
        self.tableView.allowsSelection = true
        self.tableView.separatorStyle = .none
        
        // profile image view add target
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageViewTapped))
        tapGesture.numberOfTapsRequired = 1
        profileImg.addGestureRecognizer(tapGesture)
        
        /*
        // location manager 
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        // condition for setting image view interactionable
        if loadProfile?.type == .client || loadProfile?.type == .trainer {
            profileImg.isUserInteractionEnabled = true
            self.loadProfile?.getUserInfo()
        }
        
        // condition for setting a dismiss button
        if loadProfile?.type == .discoverClient || loadProfile?.type == .discoverTrainer {
            // add close button if discovering
            let closeBtn = UIButton(type: .system)
            closeBtn.setImage(#imageLiteral(resourceName: "cancel_button.png"), for: .normal)
            closeBtn.addTarget(self, action: #selector(self.closeBtnFunction), for: .touchUpInside)
            self.view.addSubview(closeBtn)
            closeBtn.translatesAutoresizingMaskIntoConstraints = false
            closeBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
            closeBtn.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
            closeBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.10).isActive = true
            closeBtn.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.10).isActive = true
            
            // reload table view with client or trainer model
            self.loadProfile?.getUserInfo()
        }
    }
    
    // MARK: - Layout Subviews
    override func viewDidLayoutSubviews() {
        profileImg.makeRound()
    }
 
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.loadProfile?.type == UserType.client {
            return clientSections.count
        }
        if self.loadProfile?.type == UserType.trainer {
            return trainerSections.count
        }
        if self.loadProfile?.type == UserType.discoverTrainer {
            return discoverTrainerSections.count
        }
        if self.loadProfile?.type == UserType.discoverClient {
            return discoverClientSections.count
        }
        else {
            return 0
        }
    }
    
    
    // MARK: - Number of Row in Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
        return 1
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { // bio cell
            return 200.0
        }
        if indexPath.section == 1 { // edit cell
            return 100.0
        }
        else {
            return 80
        }
    }
    
    // MARK: - Cell for Row (Display Info)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { // bio
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableCell", for: indexPath) as! EditTableCell
            if loadProfile?.type == UserType.client || loadProfile?.type == UserType.discoverClient {
                cell.bioLbl.text = self.client?.aboutMe
            }
            if loadProfile?.type == UserType.trainer || loadProfile?.type == UserType.discoverTrainer {
                cell.bioLbl.text = self.trainer?.aboutMe
            }
            return cell
        }
        if indexPath.section == 1 { // location or certification
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableCell", for: indexPath) as! EditTableCell
            if loadProfile?.type == UserType.client || loadProfile?.type == UserType.discoverClient {
                cell.bioLbl.text = self.client?.location
            }
            if loadProfile?.type == UserType.trainer || loadProfile?.type == UserType.discoverTrainer {
                cell.bioLbl.text = self.trainer?.certification
            }
            return cell
        }
        if indexPath.section == 2 { // switch or book if discover trainer
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableCell", for: indexPath) as! ProfileTableCell
            switch (loadProfile?.type)! {
            case .client:
                cell.titleLabel.text = "Switch to Trainer"
                break
            case .trainer:
                cell.titleLabel.text = "Switch to Client"
                break
            case .discoverTrainer:
                cell.titleLabel.text = "Book"
                break
            default:
                break
            }
            return cell
        }
        if indexPath.section == 3 { // sign out
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableCell", for: indexPath) as! ProfileTableCell
            cell.titleLabel.text = "Sign out"
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - TableView Header
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeader") as! ProfileTableHeaderView
        headerView.setNeedsDisplay()
        switch section {
        case 0:
            headerView.titleView?.titleLabel?.text = "About Me"
            return headerView
        case 1:
            if self.loadProfile?.type == UserType.client || self.loadProfile?.type == UserType.discoverClient {
                headerView.titleView?.titleLabel?.text = clientSections[section]
                return headerView
            }
            if self.loadProfile?.type == UserType.trainer || self.loadProfile?.type == UserType.discoverTrainer {
                headerView.titleView?.titleLabel?.text = trainerSections[section]
                return headerView
            }
            break
        case 2:
            if self.loadProfile?.type == UserType.client {
                headerView.titleView?.titleLabel?.text = clientSections[section]
                return headerView
            }
            if self.loadProfile?.type == UserType.trainer {
                headerView.titleView?.titleLabel?.text = trainerSections[section]
                return headerView
            }
            if self.loadProfile?.type == UserType.discoverTrainer {
                headerView.titleView?.titleLabel?.text = discoverTrainerSections[section]
                return headerView
            }
            break
        case 3:
            if self.loadProfile?.type == UserType.client || self.loadProfile?.type == UserType.trainer {
                headerView.titleView?.titleLabel?.text = clientSections[section]
                return headerView
            }
            break
        default:
            return nil
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
    }
    
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.loadProfile?.type == UserType.client {
            return clientSections[section]
        }
        if self.loadProfile?.type == UserType.trainer {
            return trainerSections[section]
        }
        if self.loadProfile?.type == UserType.discoverTrainer {
            return discoverTrainerSections[section]
        }
        if self.loadProfile?.type == UserType.discoverClient {
            return discoverClientSections[section]
        }
        else {
            return ""
        }
    }
     */
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            // open edit bio edit page
            let editBioVC = EditProfileVC()
            editBioVC.editTitle = EditingViewTitle.bio
            
            // set saved value
            if loadProfile?.type == UserType.client {
                editBioVC.initialText = self.client?.aboutMe
                editBioVC.userType = UserType.client
            }
            if loadProfile?.type == UserType.trainer {
                editBioVC.initialText = self.trainer?.aboutMe
                editBioVC.userType = UserType.trainer
            }
            self.tabBarController?.present(editBioVC, animated: true, completion: nil)
        }
        if indexPath.section == 1 {
            // open edit locations or certifications
            if loadProfile?.type == UserType.client {
                let editLocationVC = EditProfileVC()
                editLocationVC.editTitle = EditingViewTitle.location
                editLocationVC.initialText = self.client?.location
                editLocationVC.userType = UserType.client
                self.tabBarController?.present(editLocationVC, animated: true, completion: nil)
            }
            if loadProfile?.type == UserType.trainer {
                let editCertVC = EditProfileVC()
                editCertVC.editTitle = EditingViewTitle.certification
                editCertVC.initialText = self.trainer?.certification
                editCertVC.userType = UserType.trainer
                self.tabBarController?.present(editCertVC, animated: true, completion: nil)
            }
        }
        if indexPath.section == 2 { // switch portal or book
            if loadProfile?.type == UserType.client {
                let dashboard = self.tabBarController as! Dashboard
                dashboard.switchToTrainerPortal()
            }
            if loadProfile?.type == UserType.trainer {
                let dashboard = self.tabBarController as! Dashboard
                dashboard.switchToClientPortal()
            }
            if loadProfile?.type == UserType.discoverTrainer {
                // dismiss and present schedule time and date
                self.startBooking?.didSelectedBook()
            }
        }
        if indexPath.section == 3 {
            // sign out
            AuthService.instance.performSignOut()
            UIApplication.shared.keyWindow?.rootViewController = EntryScreen()
        }
    }
        
    // MARK: - Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = manager.location
        manager.stopUpdatingLocation()
        
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(currentLocation!) { (placemark, error) in
            let placemark = placemark?.first
            let mutableString = NSMutableAttributedString()
            
            self.locationText.attributedText = mutableString
            
            if error != nil {
                
            }
            else {
                UserDefaults.standard.set(placemark?.thoroughfare, forKey: "CurrentLocation")
                
                let location = placemark?.thoroughfare
                
                self.locationText.text = location
            }
            // Update location field
            print(mutableString)
        }
    }
    
    // MARK: - Close Btn Function
    func closeBtnFunction() {
        self.parent?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Photo Library
    func bringUpPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        self.tabBarController?.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePicker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // chosen image
        let pickedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self.resizedImg = self.resizeImage(image: pickedImage, targetSize: profileImg.frame.size)
        profileImg.image = self.resizedImg
        
        let resizedData: Data = UIImageJPEGRepresentation(resizedImg!, 0.9)!
        
        // determine the portal for profile view
        if self.loadProfile?.type == UserType.client {
            StorageService.instance.storeProfileImage(inAccount: Portals.client, imageData: resizedData)
        }
        if self.loadProfile?.type == UserType.trainer {
            StorageService.instance.storeProfileImage(inAccount: Portals.trainer, imageData: resizedData)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Image View Tapped
    func imageViewTapped() {
        print("tapped")
        // present image picker
        self.bringUpPhotoLibrary()
    }
    
    // MARK: - Update UI
    func update() {
        if loadProfile?.type == .client || loadProfile?.type == .discoverClient {
            self.nameText.text = self.client?.fullName
            self.locationText.text = self.client?.basicInfo?.gender
            if let profilePhoto = self.client?.basicInfo?.profilePicture {
                self.profileImg.image = self.urlStringToImage(urlString: profilePhoto)
            }
        }
        if loadProfile?.type == .trainer || loadProfile?.type == .discoverTrainer {
            self.nameText.text = self.trainer?.fullName
            self.locationText.text = self.trainer?.basicInfo?.gender
            if let profilePhoto = self.trainer?.basicInfo?.profilePicture {
                self.profileImg.image = self.urlStringToImage(urlString: profilePhoto)
            }
        }
    }
}

extension ProfileSegment: LoadProfileStatus {
    // MARK: - Load Profile Status Delegate
    func didFinishLoadingProfile(_ user: User) {
        if loadProfile?.type == .client {
            let client = user as! Client
            self.client = client
            self.tableView.reloadData()
            self.update()
        }
        if loadProfile?.type == .trainer {
            let trainer = user as! Trainer
            self.trainer = trainer
            self.tableView.reloadData()
            self.update()
        }
    }
    
    func updateSetModel() {
        self.update()
        self.tableView.reloadData() // reload data for setted model from parent
    }
}
