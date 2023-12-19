//
//  FilterView.swift
//  ProgressiveBlur
//
//  Created by usagimaru on 2023/12/19.
//

import Cocoa
import CoreImage

class FilterView: NSView {
	
	func prepare() {
		wantsLayer = true
		layerUsesCoreImageFilters = true
		layerContentsRedrawPolicy = .onSetNeedsDisplay
		layer?.backgroundColor = NSColor.clear.cgColor
		
		setVariableBlur(60)
		//setGaussianBlur()
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
		
		let colors = [NSColor.black.cgColor, NSColor.white.cgColor] as CFArray
		guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceGray(),
										colors: colors,
										locations: nil)
		else { return nil }
		
		ctx.drawLinearGradient(gradient,
							   start: .zero,
							   end: CGPoint(x: 0, y: size.height),
							   options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
		
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
