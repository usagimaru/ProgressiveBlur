//
//  BaseView.swift
//  ProgressiveBlur
//
//  Created by usagimaru on 2023/12/19.
//

import Cocoa

class BaseView: NSView {
	
	private var trackingArea: NSTrackingArea!
	private var shape = CAShapeLayer()
	
	private func resetTrackingArea() {
		if let oldTrackingArea = self.trackingArea {
			removeTrackingArea(oldTrackingArea)
		}
		
		let options: NSTrackingArea.Options = [
			.activeInKeyWindow,
			.mouseEnteredAndExited,
			.mouseMoved,
			.inVisibleRect,
			.enabledDuringMouseDrag,
		]
		let trackingArea = NSTrackingArea(rect: .zero,
										  options: options,
										  owner: self,
										  userInfo: nil)
		addTrackingArea(trackingArea)
		self.trackingArea = trackingArea
	}
	
	override func updateTrackingAreas() {
		super.updateTrackingAreas()
		resetTrackingArea()
	}
	
	override func mouseMoved(with event: NSEvent) {
		super.mouseMoved(with: event)
		
		CALayer.disableAnimations {
			if shape.superlayer == nil {
				let size = CGFloat(60)
				shape.path = CGPath(ellipseIn: CGRect(x: -size/2, y: -size/2, width: size, height: size), transform: nil)
				shape.fillColor = NSColor.red.cgColor
				shape.anchorPoint = CGPoint(x: 0.5, y: 0.5)
				layer?.addSublayer(shape)
			}
			
			shape.position = convert(event.locationInWindow, from: nil)
		}
	}
	
	override func mouseExited(with event: NSEvent) {
		super.mouseExited(with: event)
		shape.removeFromSuperlayer()
	}
	
}
