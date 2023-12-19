//
//  ViewController.swift
//  ProgressiveBlur
//
//  Created by usagimaru on 2023/12/19.
//

import Cocoa

class ViewController: NSViewController {
	
	@IBOutlet var baseView: BaseView!
	@IBOutlet var backdropBar: FilterView!
	@IBOutlet var rectangle: NSView!
	
	private var filterView: FilterView {
		view as! FilterView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		baseView.wantsLayer = true
		baseView.layer?.backgroundColor = NSColor.clear.cgColor
		
		rectangle.wantsLayer = true
		rectangle.layer?.backgroundColor = NSColor.black.cgColor
		
		Notify.receive(NSWindow.didResizeNotification) { notification in
			if notification.object as? NSWindow == self.view.window {
				self.backdropBar.prepare()
			}
		}
		backdropBar.prepare()
	}
	
	override func viewWillAppear() {
		super.viewWillAppear()
	}

}

