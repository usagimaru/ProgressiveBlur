//
//  Notify.swift
//
//  Created by usagimaru on 2023/02/09.
//

import Foundation

class Notify {
	
	/// オブザーバオブジェクト型
	typealias ObservationObject = NSObjectProtocol
	/// オブザーバID型
	typealias ObserverID = UUID
	
	/// オブザーバを格納する辞書
	private var observers = [ObserverID : ObservationObject]()
	
	/// オブザーバを登録 (Closure)
	@discardableResult
	func receive(_ name: Notification.Name,
				 sender: Any?,
				 queue: OperationQueue? = .main,
				 perform: @escaping (_ notification: Notification) -> Void) -> ObserverID {
		let observer = NotificationCenter.default.addObserver(forName: name, object: sender, queue: queue) { (notification) in
			perform(notification)
		}
		let id = ObserverID()
		observers[id] = observer
		
		return id
	}
	
	/// オブザーバを削除
	func removeObserver(with id: ObserverID) {
		if let observer = observers[id] {
			NotificationCenter.default.removeObserver(observer)
		}
		observers.removeValue(forKey: id)
	}
	
	/// すべてのオブザーバを削除
	func removeAllObservers() {
		observers.keys.forEach { id in
			removeObserver(with: id)
		}
	}
	
}

extension Notify {
	
	/// 通知を送信
	class func post(_ name: Notification.Name,
					sender: Any?,
					userInfo: [AnyHashable : Any]? = nil) {
		NotificationCenter.default.post(name: name, object: sender, userInfo: userInfo)
	}
	
	/// オブザーバを登録 (Closure)
	@discardableResult
	class func receive(_ name: Notification.Name,
					   sender: Any?,
					   queue: OperationQueue? = .main,
					   perform: @escaping (_ notification: Notification) -> Void) -> ObservationObject {
		NotificationCenter.default.addObserver(forName: name, object: sender, queue: queue) { (notification) in
			perform(notification)
		}
	}
	
	/// オブザーバを登録 (Selector)
	class func receive(_ name: Notification.Name,
					   sender: Any?,
					   observer: Any,
					   selector: Selector) {
		NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: sender)
	}
	
	/// オブザーバ削除
	class func remove(_ observer: Any,
					  name: Notification.Name,
					  sender: Any?) {
		NotificationCenter.default.removeObserver(observer, name: name, object: sender)
	}
	
	/// オブザーバ削除
	class func remove(_ observer: ObservationObject) {
		NotificationCenter.default.removeObserver(observer)
	}
	
}

extension Notification {
	
	/// userInfo辞書から値を取り出す
	func userInfoObject<T>(for key: String) -> T? {
		userInfo?[key] as? T
	}
	
}
