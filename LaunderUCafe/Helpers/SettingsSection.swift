//
//  SettingsSection.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 2/8/21.
//

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    
    case Account
    case Support
    case Delete
    
    
    var description: String{
        switch self{
        case .Account: return "My Account"
        case .Support: return "Help & Support"
        case .Delete: return "Delete Account"
        }
    }
}


enum AccountOption: Int, CaseIterable, CustomStringConvertible{
    
    case editProfile
    case notification
    case logout
    
    var description: String{
        switch self{
        case .editProfile: return "Edit Profile"
        case .notification: return "Notifications"
        case .logout: return "Log Out"
        }
    }
}

enum SupportOption: Int, CaseIterable, CustomStringConvertible{
    
    case contactUs
    case iosTeam
    
    var description: String{
        switch self{
        case .contactUs: return "Contact Us"
        case .iosTeam: return "iOS Team"
        }
    }
}

enum DeleteOption: Int, CaseIterable, CustomStringConvertible{
    
    case deleteAccount
    
    var description: String{
        switch self{
        case .deleteAccount: return "Delete Account"
        }
    }
}


