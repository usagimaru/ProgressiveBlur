//
//  CALayer.swift
//
//  Copyright © 2018 usagimaru.
//

import QuartzCore

extension CALayer {
	
	var origin: CGPoint {
		get {
			frame.origin
		}
		set {
			var r = frame
			r.origin = newValue
			frame = r
		}
	}
	
	var x: CGFloat {
		get {
			frame.origin.x
		}
		set {
			var r = frame
			r.origin.x = newValue
			frame = r
		}
	}
	
	var y: CGFloat {
		get {
			frame.origin.y
		}
		set {
			var r = frame
			r.origin.y = newValue
			frame = r
		}
	}
	
	var size: CGSize {
		get {
			frame.size
		}
		set {
			var r = frame
			r.size = newValue
			frame = r
		}
	}
	
	var width: CGFloat {
		get {
			frame.size.width
		}
		set {
			var r = frame
			r.size.width = newValue
			frame = r
		}
	}
	
	var height: CGFloat {
		get {
			frame.size.height
		}
		set {
			var r = frame
			r.size.height = newValue
			frame = r
		}
	}
	
	// MARK: -
	
	func setBorderColor(_ color: CGColor?, width: CGFloat = 1.0) {
		borderColor = color
		borderWidth = width
	}
	
	func setCornerRadius(_ radius: CGFloat, curve: CALayerCornerCurve = .continuous) {
		cornerRadius = radius
		cornerCurve = curve
	}
	
	func setShadow(offsetX: CGFloat = 0,
				   offsetY: CGFloat,
				   radius: CGFloat,
				   opacity: Float,
				   color: CGColor? = nil,
				   path: CGPath? = nil,
				   synchronize: Bool = true) {
		if synchronize {
			shadowOffset = CGSize(width: offsetX, height: offsetY)
			shadowRadius = radius
			shadowOpacity = opacity
			shadowColor = color
			shadowPath = path
		}
		else {
			// アピアランス更新時に影がうまく反映されないことがあるようなので、実行を遅らせてみる
			DispatchQueue.main.async { [self] in
				shadowOffset = CGSize(width: offsetX, height: offsetY)
				shadowRadius = radius
				shadowOpacity = opacity
				shadowColor = color
				shadowPath = path
			}
		}
	}
	
	func removeShadow() {
		shadowOffset = .zero
		shadowRadius = 0
		shadowOpacity = 0
		shadowColor = nil
		shadowPath = nil
	}
	
	/// CALayer用のアニメーションブロック
	class func animate(enabled: Bool, duration: TimeInterval? = nil, animations: () -> Void, completionHandler: (() -> Void)? = nil) {
		CATransaction.begin()
		CATransaction.setDisableActions(!enabled)
		CATransaction.setCompletionBlock(completionHandler)
		
		if enabled {
			CATransaction.setAnimationDuration(duration ?? CATransaction.animationDuration())
		} else {
			CATransaction.setAnimationDuration(0)
		}
		
		animations()
		
		CATransaction.commit()
	}
	
	/// アニメーション無効化ブロック
	class func disableAnimations(_ animationHandler: () -> Void, completionHandler: (() -> Void)? = nil) {
		animate(enabled: false, animations: animationHandler, completionHandler: completionHandler)
	}
	
	/// 一部の暗黙的アニメーションを無効化
	func disableSpecificImplicitAnimations() {
		let actions = [
			"anchorPoint": NSNull(),
			"anchorPointZ": NSNull(),
			"masksToBounds": NSNull(),
			"bounds": NSNull(),
			"sublayers": NSNull(),
			"position": NSNull(),
			"transform": NSNull(),
			"onOrderIn": NSNull(),
			"onOrderout": NSNull(),
			// "transition" : NSNull(),
		]
		
		self.actions = actions
	}
	
	/// 暗黙的アニメーションを無効化
	func disableImplicitAnimations() {
		let actions = [
			"anchorPoint": NSNull(),
			"anchorPointZ": NSNull(),
			"masksToBounds": NSNull(),
			"contents": NSNull(),
			"contentsScale": NSNull(),
			"contentsCenter": NSNull(),
			"cornerRadius": NSNull(),
			"borderWidth": NSNull(),
			"borderColor": NSNull(),
			"opacity": NSNull(),
			"shadowColor": NSNull(),
			"shadowOpacity": NSNull(),
			"shadowOffset": NSNull(),
			"shadowRadius": NSNull(),
			"shadowPath": NSNull(),
			"onOrderIn": NSNull(),
			"onOrderout": NSNull(),
		]
		
		self.actions = actions
	}
	
}
