//
//  EditorTabDelegate.swift
//  nine_1
//
//  Created by Harrison Durant on 12/4/16.
//  Copyright © 2016 Harrison Durant. All rights reserved.
//

import UIKit

class EditorTabDelegate: NSObject, UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(viewController.title)
    }
}
