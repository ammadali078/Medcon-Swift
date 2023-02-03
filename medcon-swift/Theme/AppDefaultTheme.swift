//
//  AppDefaultTheme.swift
//  medcon-swift
//
//  Created by Muhammad Yawar Sohail on 10/02/2022.
//

import Foundation
import UIKit

class AppDefaultTheme {
    
    enum RobotoFontName: String {
        case regular = "Roboto-Regular"
        case bold = "Roboto-Bold"
    }
    
    /// Signleton
    static private let obj: AppDefaultTheme = {
        return AppDefaultTheme()
    }()
    
    public static var shared: AppDefaultTheme {
        let lock = DispatchQueue(label: "AppDefaultTheme")
        return lock.sync {
            return obj
        }
    }
}

extension AppDefaultTheme {
    func getColor(withName colorName: AppDefaultTheme.ThemeColors) -> UIColor {
        switch colorName {
        case .AppLightGreenThemeColor:
            return UIColor(red: 150.0/255.0, green: 203.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        case .AppLightGrayThemeTextColor:
            return UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        case .AppLightGrayTextFieldBorder:
            return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.1)
        case .AppGastroThemePrimaryColor:
            return UIColor(red: 27.0/255.0, green: 185.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        case .AppMenWomenThemePrimaryColor:
            return UIColor(red: 215.0/255.0, green: 135.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        case .AppRespiratoryThemePrimaryColor:
            return UIColor(red: 0.0/255.0, green: 76.0/255.0, blue: 151.0/255.0, alpha: 1.0)
        case .AppPediatricThemePrimaryColor:
            return UIColor(red: 255.0/255.0, green: 105.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        case .AppPainThemePrimaryColor:
            return UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 152.0/255.0, alpha: 1.0)
        case .ButtonBlueColor:
            return UIColor(red: 98.0/255.0, green: 147.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        case .AppGeneralHealthThemePrimaryColor:
            return UIColor(red: 23.0/255.0, green: 138.0/255.0, blue: 172.0/255.0, alpha: 1.0)
        case .AppCnsThemePrimaryColor:
            return UIColor(red: 0.0/255.0, green: 156.0/255.0, blue: 222.0/255.0, alpha: 1.0)
        }
    }
}

extension AppDefaultTheme {
    func getFont(withName fontName: AppDefaultTheme.ThemeFonts) -> UIFont {
        switch fontName {
        case .AppButtonText:
            return UIFont(name: themeFontName(byType: .bold), size: 20.0)!
        case .AppPlaceHolders, .AppSmallLabel:
            return UIFont(name: themeFontName(byType: .regular), size: 10.0)!
        case .AppLinkButtonText:
            return UIFont(name: themeFontName(byType: .regular), size: 10.0)!
        case .ScreenTitleFont:
            return UIFont(name: themeFontName(byType: .bold), size: 24.0)!
        case .AppThemeGeneralFont:
            return UIFont(name: themeFontName(byType: .regular), size: 16.0)!
        case .ItemTitleFont:
            return UIFont(name: themeFontName(byType: .bold), size: 11.0)!
        case .ItemTitleFont2:
            return UIFont(name: themeFontName(byType: .bold), size: 12.0)!
        case .ItemDescriptionFont:
            return UIFont(name: themeFontName(byType: .regular), size: 12.0)!
        case .ArticleLabelFont:
            return UIFont(name: themeFontName(byType: .regular), size: 10.0)!
        }
    }
}

extension AppDefaultTheme {
    
    enum ThemeColors: String {
        case AppLightGreenThemeColor
        case AppLightGrayThemeTextColor
        case AppLightGrayTextFieldBorder
        case AppGastroThemePrimaryColor
        case AppCnsThemePrimaryColor
        case AppMenWomenThemePrimaryColor
        case AppGeneralHealthThemePrimaryColor
        case AppRespiratoryThemePrimaryColor
        case AppPediatricThemePrimaryColor
        case AppPainThemePrimaryColor
        case ButtonBlueColor
    }
    
    enum ThemeFonts: String {
        case AppButtonText
        case AppPlaceHolders
        case AppSmallLabel
        case AppLinkButtonText
        case AppThemeGeneralFont
        case ScreenTitleFont
        case ItemTitleFont
        case ItemTitleFont2
        case ItemDescriptionFont
        case ArticleLabelFont
    }
    
    enum ThemeFontTypes: String {
        case regular
        case bold
    }
    
    func themeFontName(byType type: AppDefaultTheme.ThemeFontTypes) -> String {
        switch type {
        case .bold:
            return AppDefaultTheme.RobotoFontName.bold.rawValue
        case .regular:
            return AppDefaultTheme.RobotoFontName.regular.rawValue
        }
    }
}
