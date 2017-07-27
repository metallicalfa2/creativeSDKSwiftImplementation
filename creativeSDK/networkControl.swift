//
//  networkControl.swift
//  creativeSDK
//
//  Created by SKIXY-MACBOOK on 06/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class NetworkController{
	static let loginURL = "https://13.126.4.227:3000/login"
	static let contactsURL = "https://13.126.4.227:3000/contacts"
	
	func load(_ urlString: String, withCompletion completion: @escaping ([Any]?) -> Void) {
	
		let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
		let url = URL(string: urlString)!
		let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
			print(data)
			guard let data = data else {
				completion(nil)
				return
			}
			
			guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
				completion(nil)
				return
			}
			print(json)
			let result: [Any]
			switch urlString {
			case NetworkController.loginURL:
				result = [] // Transform JSON into Question values
			case NetworkController.contactsURL:
				result = [] // Transform JSON into Question values
			default:
				result = []
			}
			completion(result)
		})
		task.resume()
	}
	
	func test(){
		//
	}
}
