//
//  ApplePayVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 10/4/2017.
//  Copyright © 2017 Apptist. All rights reserved.
//

import Foundation
import PassKit
import Stripe

class ApplePayVC: UIViewController {
    
    // View Properties
    var cancelBtn: UIButton?
    var titleLbl: UILabel?
    
    var applePayButton: UIButton!
    let applePayImage = #imageLiteral(resourceName: "ApplePayButton.png") // ApplePayButton.png
    
    // supported payment networks
    let SupportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
    let kVTMerchantID = "merchant.com.com.VirtualTrainr"
    
    // model
    var session: Session?
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // cancel btn
        cancelBtn = UIButton(type: .system)
        cancelBtn?.addTarget(self, action: #selector(cancelBtnFunction), for: .touchUpInside)
        cancelBtn?.contentMode = .scaleAspectFit
        cancelBtn?.setTitle("X", for: .normal)
        cancelBtn?.setTitleColor(UIColor.gray, for: .normal)
        self.view.addSubview(cancelBtn!)
        cancelBtn?.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        cancelBtn?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        cancelBtn?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        cancelBtn?.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        
        // title label
        titleLbl = UILabel()
        titleLbl?.text = "Apple Pay the newly accepted session \n(or press X to go back)"
        titleLbl?.allowsDefaultTighteningForTruncation = true
        titleLbl?.font = self.createFontWithSize(fontName: standardFont, size: 17.0)
        titleLbl?.textColor = UIColor.lightGray
        titleLbl?.adjustsFontSizeToFitWidth = true
        titleLbl?.textAlignment = .center
        self.view.addSubview(titleLbl!)
        titleLbl?.translatesAutoresizingMaskIntoConstraints = false
        titleLbl?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLbl?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -self.view.frame.height/4).isActive = true
        titleLbl?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.77).isActive = true
        titleLbl?.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        
        // apple pay button
        applePayButton = UIButton()
        applePayButton.contentMode = .scaleAspectFit
        applePayButton.setBackgroundImage(applePayImage, for: .normal)
        applePayButton.addTarget(self, action: #selector(self.applePayBtnFunction), for: .touchUpInside)
        applePayButton.isHidden = !PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: SupportedPaymentNetworks)
        self.view.addSubview(applePayButton)
        applePayButton.translatesAutoresizingMaskIntoConstraints = false
        applePayButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        applePayButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        applePayButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.50).isActive = true
        applePayButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    // MARK: - Cancel Btn Function
    func cancelBtnFunction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        cancelBtn?.makeRound()
        cancelBtn?.layer.borderWidth = 1.0
        cancelBtn?.layer.borderColor = UIColor.gray.cgColor
    }
    
    // MARK: - Apple Pay Function
    func applePayBtnFunction() {
        
        let request = PKPaymentRequest()
        
        request.merchantIdentifier = kVTMerchantID
        request.supportedNetworks = SupportedPaymentNetworks
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.countryCode = "CA"
        request.currencyCode = "CAD"
        
        var summaryItems = [PKPaymentSummaryItem]()
        
        // session details
        let trainerName = session?.trainerName
        let startTime = session?.startTime!
        let date = session?.date!
        let paymentItem1String = "1 hour session starting: \n\(startTime!) on \(date!)"
        
        let paymentItem1 = PKPaymentSummaryItem(label: paymentItem1String, amount: 45)
        let paymentItem2 = PKPaymentSummaryItem(label: "HST Tax", amount: NSDecimalNumber(value: 45*0.13))
        let paymentItem3 = PKPaymentSummaryItem(label: trainerName!, amount: 50.85)
        
        summaryItems.append(paymentItem1)
        summaryItems.append(paymentItem2)
        summaryItems.append(paymentItem3)
        
        request.paymentSummaryItems = summaryItems
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayController.delegate = self
        
        self.present(applePayController, animated: true, completion: nil)
    }

}

// Apple Pay Delegate
extension ApplePayVC: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Swift.Void) {
        
        // stripe create token
        STPAPIClient.shared().createToken(with: payment) { (token, error) in
            if error != nil {
                print(error?.localizedDescription)
                completion(.failure)
                return
            }
            
            // processed with token
            print(token?.tokenId)
            print("done")

            // save session to database
            DataService.instance.saveApplePayToken(self.session!, token: (token?.tokenId)!)
            
            // write token to database and authorize in node.js file
            completion(.success)
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: {
            self.dismiss(animated: true, completion: {
                
            })
        })
    }
}
