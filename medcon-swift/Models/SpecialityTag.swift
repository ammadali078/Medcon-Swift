//
//  SpecialityTag.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 16/03/2022.
//

import Foundation

protocol SpecialityType {
    var titleString: String { get }
    var iconName: String { get }
    var bannerName: String { get }
    var bannerTitleString: String { get }
    var titleBackgroundColor: UIColor { get }
}

enum SpecialityTag: Int {
    case Miscellaneous = 101
    case Pain = 102
    case CNS = 103
    case Gastroenterology = 104
    case General = 105
    case Pediatrics = 106
    case Respiratory = 107
    case WomenMenHealth = 108
    case LOGOUT = 109
    case ContactUs = 110
//    case Drugs = 111
}

enum SpecialityTag2 : Int {
    case Miscellaneous = 101
    case Pain = 102
    case CNS = 103
    case Gastroenterology = 104
    case General = 105
    case Pediatrics = 106
    case Respiratory = 107
    case WomenMenHealth = 108
    case LOGOUT = 109
    case ContactUs = 110
//    case Drugs = 111
}

extension SpecialityTag: SpecialityType {
    var titleBackgroundColor: UIColor {
        switch self {
        case .Miscellaneous:
            return AppDefaultTheme.shared.getColor(withName: .AppGeneralHealthThemePrimaryColor)
        case .Pain:
            return AppDefaultTheme.shared.getColor(withName: .AppPainThemePrimaryColor)
        case .CNS:
            return AppDefaultTheme.shared.getColor(withName: .AppCnsThemePrimaryColor)
        case .Gastroenterology:
            return AppDefaultTheme.shared.getColor(withName: .AppGastroThemePrimaryColor)
        case .General:
            return AppDefaultTheme.shared.getColor(withName: .AppGeneralHealthThemePrimaryColor)
        case .Pediatrics:
            return AppDefaultTheme.shared.getColor(withName: .AppPediatricThemePrimaryColor)
        case .Respiratory:
            return AppDefaultTheme.shared.getColor(withName: .AppRespiratoryThemePrimaryColor)
        case .WomenMenHealth, .LOGOUT, .ContactUs:
            return AppDefaultTheme.shared.getColor(withName: .AppMenWomenThemePrimaryColor)
        }
    }
    
    
    
    var bannerTitleString: String {
        switch self {
        case .Miscellaneous:
            return "RUNNING STOMACH IS NEVER AFRAID OF THE DARK"
        case .Pain:
            return "RELIEVING PAIN. RESTORING FUNCTION. RENEWING HOPE"
        case .CNS:
            return "NERVOUS SYSTEM, THE FIRST STAGE OF ENLIGHTENMENT PROCESS"
        case .Gastroenterology:
            return "RUNNING STOMACH IS NEVER AFRAID OF THE DARK"
        case .General:
            return "GENERAL HEALTHCARE"
        case .Pediatrics:
            return "HEAL A CHILD, CHANGE THE WORLD"
        case .Respiratory:
            return "NEVER TAKE A BREATH FOR GRANTED"
        case .WomenMenHealth, .LOGOUT, .ContactUs:
            return "THE GREATEST WEALTH IS HEALTH"
        }
    }
    
    var titleString2: String {
        switch self {
        case .Miscellaneous:
            return "Miscellaneous"
        case .Pain:
            return "PAIN"
        case .CNS:
            return "CNS"
        case .Gastroenterology:
            return "GASTROENTEROLOGY"
        case .General:
            return "GENERAL HEALTH"
        case .Pediatrics:
            return "PEDIATRICS"
        case .Respiratory:
            return "RESPIRATORY"
        case .WomenMenHealth, .LOGOUT, .ContactUs:
            return "MEN & WOMEN HEALTH"
        }
    }
    
    var titleString: String {
        switch self {
        case .Miscellaneous:
            return "Miscellaneous"
        case .Pain:
            return "PAIN"
        case .CNS:
            return "CNS "
        case .Gastroenterology:
            return "GASTROENTEROLOGY"
        case .General:
            return "GENERAL HEALTHCARE"
        case .Pediatrics:
            return "PEDIATRICS"
        case .Respiratory:
            return "RESPIRATORY"
        case .WomenMenHealth, .LOGOUT, .ContactUs:
            return "WOMEN & MEN HEALTH"
        }
    }
    
    var GetID: Int {
        switch self {
        case .Miscellaneous:
            return 22
        case .Pain:
            return 9
        case .CNS:
            return 2
        case .Gastroenterology:
            return 3
        case .General:
            return 4
        case .Pediatrics:
            return 5
        case .Respiratory:
            return 6
        case .WomenMenHealth, .LOGOUT, .ContactUs:
            return 7
        }
    }
    
    var iconName: String {
        switch self {
        case .Miscellaneous:
            return "gastro-icon"
        case .Pain:
            return "pain-icon"
        case .CNS:
            return "cns-icon"
        case .Gastroenterology:
            return "gastro-icon"
        case .General:
            return "general-icon"
        case .Pediatrics:
            return "pediatric-icon"
        case .Respiratory:
            return "respiratory-icon"
        case .WomenMenHealth, .LOGOUT, .ContactUs:
            return "women-icon"
        }
    }
    
    var bannerName: String {
        switch self {
        case .Miscellaneous:
            return "banner-home"
        case .Pain:
            return "pain-banner"
        case .CNS:
            return "cns-banner"
        case .Gastroenterology:
            return "banner-home"
        case .General:
            return "general-banner"
        case .Pediatrics:
            return "pediatric-banner"
        case .Respiratory:
            return "respiratory-banner"
        case .WomenMenHealth, .LOGOUT, .ContactUs:
            return "women-banner"
        }
    }
}
