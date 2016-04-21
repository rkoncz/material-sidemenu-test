//
//  ViewController.swift
//  MaterialSideMenu
//
//  Created by Richard Koncz on 17/04/16.
//  Copyright © 2016 Richard Koncz. All rights reserved.
//

import UIKit
import Material

class ViewController: UIViewController {

    /// NavigationBar title label.
    private var titleLabel: UILabel!
    
    /// NavigationBar menu button.
    private var menuButton: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareView()
  		prepareTitleLabel()
        prepareMenuButton()
        prepareNavigationItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the navigationBar style.
        navigationController?.navigationBar.statusBarStyle = .LightContent
        
        // Enable the SideNavigation.
        sideNavigationController?.enabled = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Show the menuView.
        menuViewController?.menuView.animate(MaterialAnimation.animationGroup([
            MaterialAnimation.rotate(rotation: 3),
            MaterialAnimation.translateY(0)
            ]))
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // Disable the SideNavigation.
        
        // Hide the menuView.
        menuViewController?.menuView.animate(MaterialAnimation.animationGroup([
            MaterialAnimation.rotate(rotation: 3),
            MaterialAnimation.translateY(150)
            ]))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// General preparation statements.
    private func prepareView() {
        view.backgroundColor = MaterialColor.yellow.accent1
    }

    /// Prepares the titleLabel.
    private func prepareTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Test"
        titleLabel.textAlignment = .Left
        titleLabel.textColor = MaterialColor.white
    }
    
    /// Prepares the menuButton.
    private func prepareMenuButton() {
        let image: UIImage? = MaterialIcon.cm.menu
        menuButton = FlatButton()
        menuButton.pulseScale = false
        menuButton.pulseColor = MaterialColor.white
        menuButton.setImage(image, forState: .Normal)
        menuButton.setImage(image, forState: .Highlighted)
        menuButton.addTarget(self, action: #selector(handleMenuButton), forControlEvents: .TouchUpInside)
    }
    
    /// Handles the menuButton.
    internal func handleMenuButton() {
        sideNavigationController?.openLeftView()
    }
    
    /// Prepares the navigationItem.
    private func prepareNavigationItem() {
        navigationItem.titleLabel = titleLabel
        navigationItem.leftControls = [menuButton]
    }
}

