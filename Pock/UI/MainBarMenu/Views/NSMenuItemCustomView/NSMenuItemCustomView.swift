//
//  NSMenuItemCustomView.swift
//  Pock
//
//  Created by Pierluigi Galdi on 05/02/21.
//  Copyright © 2021 Pierluigi Galdi. All rights reserved.
//

import Cocoa
import Magnet

@IBDesignable
internal class NSMenuItemCustomView: NSView {

	@IBOutlet internal private(set) weak var view: NSView!
	@IBOutlet internal private(set) weak var mainLabel: NSTextField!
	@IBOutlet internal private(set) weak var keyModifier: NSTextField!
	@IBOutlet internal private(set) weak var keyChar: NSTextField!

	internal weak var item: NSMenuItem?

	convenience init(item: NSMenuItem, height: CGFloat = 23) {
		self.init(frame: .zero)
		self.item = item
		self.item?._setViewHandlesEvents(false)
		self.translatesAutoresizingMaskIntoConstraints = false
		self.heightAnchor.constraint(equalToConstant: height).isActive = true
		let frameworkBundle = Bundle(for: NSMenuItemCustomView.self)
		guard frameworkBundle.loadNibNamed("\(type(of: self))", owner: self, topLevelObjects: nil) else {
			fatalError("Can't find nib for name: `\(type(of: self))`")
		}
		addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		view.topAnchor.constraint(equalTo: topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		layoutSubtreeIfNeeded()
	}

	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
		mainLabel.textColor = .labelColor
		keyModifier.textColor = item?.isHighlighted == true ? .labelColor : .tertiaryLabelColor
		keyChar.textColor = item?.isHighlighted == true ? .labelColor : .tertiaryLabelColor
	}

	override func viewDidMoveToWindow() {
		super.viewDidMoveToWindow()
		mainLabel.stringValue = item?.title ?? ""
		keyModifier.stringValue = item?.keyEquivalentModifierMask.keyEquivalentStrings().joined() ?? ""
		keyChar.stringValue = item?.keyEquivalent.uppercased() ?? ""
	}
}
