//
//  FilterView.swift
//  ProgressiveBlur
//
//  Created by usagimaru on 2023/12/19.
//

import Cocoa

class FilterView: NSView {
	
	var blurRadius: CGFloat = 50
	var padding: CGFloat = 0
	
	func prepare() {
		wantsLayer = true
		layerUsesCoreImageFilters = true
		layerContentsRedrawPolicy = .onSetNeedsDisplay
		layer?.backgroundColor = NSColor.clear.cgColor
		
		setVariableBlur(blurRadius)
		//setGaussianBlur(blurRadius)
	}
	
	private func verticalGradient(size: CGSize) -> CIImage? {
		guard let ctx = CGContext(data: nil,
								  width: Int(round(size.width)),
								  height: Int(round(size.height)),
								  bitsPerComponent: 8,
								  bytesPerRow: 0,
								  space: CGColorSpaceCreateDeviceGray(),
								  bitmapInfo: CGImageAlphaInfo.none.rawValue)
		else { return nil }
		
		/*
		 The effect range seems to depend on the bounds of the window, even if the size of the NSView is changed.
		 */
		
		let colors: [NSColor] = [
			.black,
			.black,
			.black,
			.white,
		]
		let cgcolors = colors.map { $0.cgColor } as CFArray
		
		guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceGray(),
										colors: cgcolors,
										locations: nil)
		else { return nil }
		
		ctx.drawLinearGradient(gradient,
							   start: CGPoint(x: 0, y: -padding),
							   end: CGPoint(x: 0, y: size.height + padding),
							   options: []) //[.drawsBeforeStartLocation, .drawsAfterEndLocation])
		
		guard let image = ctx.makeImage()
		else { return nil }
		
		return CIImage(cgImage: image)
	}
	
	private func setVariableBlur(_ radius: CGFloat) {
		if let filter = CIFilter(name: "CIMaskedVariableBlur") {
			let maskImage = verticalGradient(size: self.bounds.size)
			filter.setDefaults()
			filter.setValue(maskImage, forKey: "inputMask")
			filter.setValue(radius, forKey: kCIInputRadiusKey)
			layer?.backgroundFilters = [filter]
		}
	}
	
	private func setGaussianBlur(_ radius: CGFloat) {
		if let filter = CIFilter(name: "CIGaussianBlur") {
			filter.setDefaults()
			filter.setValue(radius, forKey: kCIInputRadiusKey)
			layer?.backgroundFilters = [filter]
		}
	}
	
}
