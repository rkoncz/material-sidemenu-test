//
//  SideMenuViewController.swift
//  MaterialSideMenu
//
//  Created by Richard Koncz on 17/04/16.
//  Copyright © 2016 Richard Koncz. All rights reserved.
//

import UIKit
import Material

private struct Item {
	var text: String
	var imageName: String
}

class SideMenuViewController: UIViewController {
	/// A tableView used to display navigation items.
	private let tableView: UITableView = UITableView()

	/// A list of all the navigation items.
	private var items: Array<Item> = Array<Item>()

	override func viewDidLoad() {
		super.viewDidLoad()
		prepareView()
		prepareCells()
		prepareTableView()
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

		/*
		 The dimensions of the view will not be updated by the side navigation
		 until the view appears, so loading a dyanimc width is better done here.
		 The user will not see this, as it is hidden, by the drawer being closed
		 when launching the app. There are other strategies to mitigate from this.
		 This is one approach that works nicely here.
		 */
		prepareProfileView()
	}

	/// General preparation statements.
	private func prepareView() {
		view.backgroundColor = MaterialColor.grey.darken1
	}

	/// Prepares the items that are displayed within the tableView.
	private func prepareCells() {
		items.append(Item(text: "Main screen", imageName: "ic_today"))
		items.append(Item(text: "Menu point 1", imageName: "ic_today"))
		items.append(Item(text: "Menu point 2", imageName: "ic_inbox"))
	}

	/// Prepares profile view.
	private func prepareProfileView() {
		let backgroundView: MaterialView = MaterialView()
		backgroundView.image = UIImage(named: "MaterialBackground")

		let profileView: MaterialView = MaterialView()
		profileView.image = UIImage(named: "Profile9")?.resize(toWidth: 72)
		profileView.backgroundColor = MaterialColor.clear
		profileView.shape = .Circle
		profileView.borderColor = MaterialColor.white
		profileView.borderWidth = 3
		view.addSubview(profileView)

		let nameLabel: UILabel = UILabel()
		nameLabel.text = "Test app"
		nameLabel.textColor = MaterialColor.white
		nameLabel.font = RobotoFont.mediumWithSize(18)
		view.addSubview(nameLabel)

		profileView.translatesAutoresizingMaskIntoConstraints = false

		MaterialLayout.alignFromTopLeft(view, child: profileView, top: 30, left: (view.bounds.width - 72) / 2)
		MaterialLayout.size(view, child: profileView, width: 72, height: 72)

		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		MaterialLayout.alignFromTop(view, child: nameLabel, top: 130)
		MaterialLayout.alignToParentHorizontally(view, child: nameLabel, left: 20, right: 20)
	}

	/// Prepares the tableView.
	private func prepareTableView() {
		tableView.registerClass(MaterialTableViewCell.self, forCellReuseIdentifier: "MaterialTableViewCell")
		tableView.backgroundColor = MaterialColor.clear
		tableView.dataSource = self
		tableView.delegate = self
		tableView.separatorStyle = .None

		// Use MaterialLayout to easily align the tableView.
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		MaterialLayout.alignToParent(view, child: tableView, top: 170)
	}
}

/// TableViewDataSource methods.
extension SideMenuViewController: UITableViewDataSource {
	/// Determines the number of rows in the tableView.
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count;
	}

	/// Prepares the cells within the tableView.
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: MaterialTableViewCell = tableView.dequeueReusableCellWithIdentifier("MaterialTableViewCell", forIndexPath: indexPath) as! MaterialTableViewCell

		let item: Item = items[indexPath.row]

		cell.textLabel!.text = item.text
		cell.textLabel!.textColor = MaterialColor.grey.lighten2
		cell.textLabel!.font = RobotoFont.medium
		cell.imageView!.image = UIImage(named: item.imageName)?.imageWithRenderingMode(.AlwaysTemplate)
		cell.imageView!.tintColor = MaterialColor.grey.lighten2
		cell.backgroundColor = MaterialColor.clear

		return cell
	}
}

/// UITableViewDelegate methods.
extension SideMenuViewController: UITableViewDelegate {
	/// Sets the tableView cell height.
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 64
	}

	/// Select item at row in tableView.
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let item: Item = items[indexPath.row]

		switch item.text {
		case "Main screen":
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! NavigationController
            sideNavigationController?.transitionFromRootViewController(navigationController)
            sideNavigationController?.closeLeftView()
		case "Menu point 1":
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = storyboard.instantiateViewControllerWithIdentifier("Menu1NavigationController") as! NavigationController
            sideNavigationController?.transitionFromRootViewController(navigationController)
            sideNavigationController?.closeLeftView()
        case "Menu point 2":
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = storyboard.instantiateViewControllerWithIdentifier("Menu2NavigationController") as! NavigationController
            sideNavigationController?.transitionFromRootViewController(navigationController)
            sideNavigationController?.closeLeftView()
		default: break
		}
	}
}
