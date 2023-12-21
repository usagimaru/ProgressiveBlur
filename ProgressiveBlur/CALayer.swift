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
	
}
