//
//  AppUserManager.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 11/02/2022.
//

import Foundation
import UIKit

class AppUserManager {

    /// Data - Shared Instance
    static let shared = AppUserManager()
    
       static let userDefaultsAccessToken = "UserDefaultsAccessToken"
    static let userDefaultsEmail = "UserDefaultsAccessToken"
    static let userDefaultsPassword = "UserDefaultsAccessToken"
    
    // set if user is new or old
    static var isUserNew = false
    
    
    /// Data - User
    /// The Current Authenticated User
    /// Accessor will handle actions when modified
    /// Login api has alot of other data with user so keeping everything for now.
    /// Refactor that later on...
    var user: RegisterDataClass! {
        didSet {
            // Notify Change
            NotificationCenter.default.post(name: Notification.Name.CurrentUserDidChange, object: user)
        }
    }
    
    var isUserLoggedIn: Bool {
        return accessToken != nil
    }
    
    var isUserLoggedOut: Bool {
        return isUserLoggedIn == false
    }
    
    /// Data - Access Token
    /// Access Token used for authenticating
    /// against the backend
    var accessToken: String? {
        didSet {
            // If not nil, persist & identify
            if (self.accessToken != nil) {
                // Persist
                UserDefaults.standard.set(self.accessToken, forKey: AppUserManager.userDefaultsAccessToken)
            }
                // If nil, remove and unidentify
            else {
                // Destroy persisted data
                UserDefaults.standard.removeObject(forKey: AppUserManager.userDefaultsAccessToken)
            }
        }
    }
    
    /// Data - isAuthenticated
    /// Whether the user is authenticated or not
    var isAuthenticated: Bool {
        return (self.user != nil)
    }
    
    /// Initializer
    /// Setups the information as needs be
    init() {
        // Load the user access token from defaults if exists
        let userAccessToken = UserDefaults.standard.value(forKey: AppUserManager.userDefaultsAccessToken) as? String
        if (userAccessToken != nil) {
            // Set as access token
            self.accessToken = userAccessToken
        }
        // Otherwise destroy the info and assume unauthenticated
        else {
            UserDefaults.standard.removeObject(forKey: AppUserManager.userDefaultsAccessToken)
        }
    }
}
