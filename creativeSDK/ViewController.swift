//
//  ViewController.swift
//  creativeSDK
//
//  Created by SKIXY-MACBOOK on 05/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import AdobeCreativeSDKCore
import AdobeCreativeSDKImage

class ViewController: UIViewController,AdobeUXImageEditorViewControllerDelegate {
	
	@IBOutlet weak var imageVIew: UIImageView!
	// TODO: Please update the ClientId and Secret to the values provided by creativesdk.com
	fileprivate let kCreativeSDKClientId = "6dadb592a209442f9db44920ca45f86a"
	fileprivate let kCreativeSDKClientSecret = "c11fa3fe-4e55-4cc5-9a27-3fe792c45dbd"
	fileprivate let kCreativeSDKRedirectURLString = "ams+4572f58a319441c5b5ab4cc2ad230c5b22d3e5d5://adobeid/6dadb592a209442f9db44920ca45f86a"
	
	@IBAction func openEditor(_ sender: Any) {
		self.photoEditorStart(image: #imageLiteral(resourceName: "test"))
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		let test = NetworkController()
		AdobeUXAuthManager.shared().setAuthenticationParametersWithClientID(kCreativeSDKClientId, withClientSecret: kCreativeSDKClientSecret)
		AdobeUXAuthManager.shared().redirectURL = NSURL(string: kCreativeSDKRedirectURLString)! as URL!
		

	}
	
	override func viewWillAppear(_ animated: Bool) {
	}
	
	func photoEditorStart(image: UIImage!) {
		DispatchQueue.main.async {
			AdobeImageEditorCustomization.setToolOrder([
				kAdobeImageEditorCrop,        /* Enhance */
				kAdobeImageEditorOrientation,
				kAdobeImageEditorEffects,
				kAdobeImageEditorColorAdjust,    /* Effects */
				kAdobeImageEditorSharpness
				])
			
			let adobeViewCtr = AdobeUXImageEditorViewController(image: image)
			adobeViewCtr.delegate = self as?  AdobeUXImageEditorViewControllerDelegate
			self.present(adobeViewCtr, animated: true) { () -> Void in
			}
		}
	}
	
	func photoEditor(_ editor: AdobeUXImageEditorViewController, finishedWith image: UIImage?)
	{
		self.dismiss(animated: true, completion: nil)
		imageVIew.image = image
	}
	
	func photoEditorCanceled(_ editor: AdobeUXImageEditorViewController)
	{
		
	}


}

