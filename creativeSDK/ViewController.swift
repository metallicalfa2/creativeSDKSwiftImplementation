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
import Fusuma

class ViewController: UIViewController,AdobeUXImageEditorViewControllerDelegate, FusumaDelegate {
	
	@IBOutlet weak var imageVIew: UIImageView!
	// TODO: Please update the ClientId and Secret to the values provided by creativesdk.com
	fileprivate let kCreativeSDKClientId = "6dadb592a209442f9db44920ca45f86a"
	fileprivate let kCreativeSDKClientSecret = "c11fa3fe-4e55-4cc5-9a27-3fe792c45dbd"
	fileprivate let kCreativeSDKRedirectURLString = "ams+4572f58a319441c5b5ab4cc2ad230c5b22d3e5d5://adobeid/6dadb592a209442f9db44920ca45f86a"
	
	let fusuma = FusumaViewController()
	
	@IBAction func openEditor(_ sender: Any) {
		//self.photoEditorStart(image: #imageLiteral(resourceName: "test"))
		self.present(fusuma,animated: true, completion: nil)
	}
	override func viewDidLoad() {
	
		super.viewDidLoad()
		
		fusuma.delegate = self
		fusuma.cropHeightRatio = 0.6667
		fusuma.hasVideo = false
		fusuma.defaultMode = .library
		fusuma.allowMultipleSelection = false
		fusumaSavesImage = true
		fusumaCropImage = false
		fusumaBackgroundColor = UIColor.white
		fusumaTintColor = UIColor.gray
		fusumaBaseTintColor = UIColor.gray
		
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
	
	
	
	
	// MARK: FusumaDelegate Protocol
	func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
		
		switch source {
			
		case .camera:
			
			print("Image captured from Camera")
			
		case .library:
			
			print("Image selected from Camera Roll")
			
		default:
			
			print("Image selected")
		}
		//print(image)
		
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
		
		self.imageVIew.image = image
	}
	
	func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
		
		print("Number of selection images: \(images.count)")
		
		
	}
	
	func fusumaImageSelected(_ image: UIImage, source: FusumaMode, metaData: ImageMetadata) {
		
		print("Image mediatype: \(metaData.mediaType)")
		print("Source image size: \(metaData.pixelWidth)x\(metaData.pixelHeight)")
		print("Creation date: \(String(describing: metaData.creationDate))")
		print("Modification date: \(String(describing: metaData.modificationDate))")
		print("Video duration: \(metaData.duration)")
		print("Is favourite: \(metaData.isFavourite)")
		print("Is hidden: \(metaData.isHidden)")
		print("Location: \(String(describing: metaData.location))")
	}
	
	func fusumaVideoCompleted(withFileURL fileURL: URL) {
		
		print("video completed and output to file: \(fileURL)")
		//self.fileUrlLabel.text = "file output to: \(fileURL.absoluteString)"
	}
	
	func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
		
		switch source {
			
		case .camera:
			
			print("Called just after dismissed FusumaViewController using Camera")
			
		case .library:
			
			print("Called just after dismissed FusumaViewController using Camera Roll")
			
		default:
			
			print("Called just after dismissed FusumaViewController")
		}
	}
	
	func fusumaCameraRollUnauthorized() {
		
		print("Camera roll unauthorized")
		
		let alert = UIAlertController(title: "Access Requested",
		                              message: "Saving image needs to access your photo album",
		                              preferredStyle: .alert)
		
		alert.addAction(UIAlertAction(title: "Settings", style: .default) { (action) -> Void in
			
			if let url = URL(string:UIApplicationOpenSettingsURLString) {
				
				UIApplication.shared.openURL(url)
			}
		})
		
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
			
		})
		
		self.present(alert, animated: true, completion: nil)
	}
	
	func fusumaClosed() {
		
		print("Called when the FusumaViewController disappeared")
	}
	
	func fusumaWillClosed() {
		
		print("Called when the close button is pressed")
	}
	
	
}
