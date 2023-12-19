//
//  Notify.swift
//
//  Created by usagimaru on 2023/02/09.
//

import Foundation

class Notify {
	
	/// 送信
	class func send(_ name: Notification.Name,
					sender: Any? = nil,
					userInfo: [AnyHashable : Any]? = nil) {
		NotificationCenter.default.post(name: name, object: sender, userInfo: userInfo)
	}
	
	/// 受信 (Closure)
	class func receive(_ name: Notification.Name,
					   sender: Any? = nil,
					   queue: OperationQueue? = .main,
					   perform: @escaping (_ notification: Notification) -> Void) {
		NotificationCenter.default.addObserver(forName: name, object: sender, queue: queue) { (notification) in
			perform(notification)
		}
	}
	
	/// 受信 (Selector)
	class func receive(_ observer: Any,
					   name: Notification.Name,
					   sender: Any? = nil,
					   selector: Selector) {
		NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: sender)
	}
	
	/// オブザーバ削除
	class func remove(_ observer: Any,
					  name: Notification.Name,
					  sender: Any? = nil) {
		NotificationCenter.default.removeObserver(observer, name: name, object: sender)
	}
	
}

extension Notification {
	
	func userInfoObject(for key: String) -> Any? {
		userInfo?[key]
	}
	
}
