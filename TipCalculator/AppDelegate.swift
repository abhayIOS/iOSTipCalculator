//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Abhay on 9/13/15.
//  Copyright © 2015 Abhay. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        let size : CGSize = UIScreen.mainScreen().bounds.size;
        
        var storyBoard : UIStoryboard;
        var initialVC : UIViewController;
        
        if (size.height == 480) {
            
            storyBoard = UIStoryboard(name:"Main4S", bundle:nil);
        
        } else {
           
            storyBoard = UIStoryboard(name:"Main", bundle:nil);
        }
        
        initialVC = storyBoard.instantiateInitialViewController()!;
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        self.window?.rootViewController = initialVC;
        
        self.window?.makeKeyAndVisible();
        
        return true
    }

}

