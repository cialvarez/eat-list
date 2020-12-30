//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 3 storyboards.
  struct storyboard {
    /// Storyboard `EatList`.
    static let eatList = _R.storyboard.eatList()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `TargetDetails`.
    static let targetDetails = _R.storyboard.targetDetails()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "EatList", bundle: ...)`
    static func eatList(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.eatList)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "TargetDetails", bundle: ...)`
    static func targetDetails(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.targetDetails)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 3 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `gradient-base`.
    static let gradientBase = Rswift.ColorResource(bundle: R.hostingBundle, name: "gradient-base")
    /// Color `gradient-secondary`.
    static let gradientSecondary = Rswift.ColorResource(bundle: R.hostingBundle, name: "gradient-secondary")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "gradient-base", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func gradientBase(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.gradientBase, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "gradient-secondary", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func gradientSecondary(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.gradientSecondary, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "gradient-base", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func gradientBase(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.gradientBase.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "gradient-secondary", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func gradientSecondary(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.gradientSecondary.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 6 images.
  struct image {
    /// Image `ArmyStar`.
    static let armyStar = Rswift.ImageResource(bundle: R.hostingBundle, name: "ArmyStar")
    /// Image `Back`.
    static let back = Rswift.ImageResource(bundle: R.hostingBundle, name: "Back")
    /// Image `ErrorIcon`.
    static let errorIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "ErrorIcon")
    /// Image `LocationUpdate`.
    static let locationUpdate = Rswift.ImageResource(bundle: R.hostingBundle, name: "LocationUpdate")
    /// Image `Pizzannotation`.
    static let pizzannotation = Rswift.ImageResource(bundle: R.hostingBundle, name: "Pizzannotation")
    /// Image `star`.
    static let star = Rswift.ImageResource(bundle: R.hostingBundle, name: "star")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ArmyStar", bundle: ..., traitCollection: ...)`
    static func armyStar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.armyStar, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Back", bundle: ..., traitCollection: ...)`
    static func back(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.back, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ErrorIcon", bundle: ..., traitCollection: ...)`
    static func errorIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.errorIcon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "LocationUpdate", bundle: ..., traitCollection: ...)`
    static func locationUpdate(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.locationUpdate, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Pizzannotation", bundle: ..., traitCollection: ...)`
    static func pizzannotation(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.pizzannotation, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "star", bundle: ..., traitCollection: ...)`
    static func star(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.star, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 8 nibs.
  struct nib {
    /// Nib `AddressDetailsTableViewCell`.
    static let addressDetailsTableViewCell = _R.nib._AddressDetailsTableViewCell()
    /// Nib `AlertView`.
    static let alertView = _R.nib._AlertView()
    /// Nib `BaseDetailsTableViewCell`.
    static let baseDetailsTableViewCell = _R.nib._BaseDetailsTableViewCell()
    /// Nib `EatListTableViewCell`.
    static let eatListTableViewCell = _R.nib._EatListTableViewCell()
    /// Nib `HighlightsTableViewCell`.
    static let highlightsTableViewCell = _R.nib._HighlightsTableViewCell()
    /// Nib `ImageHeaderTableViewCell`.
    static let imageHeaderTableViewCell = _R.nib._ImageHeaderTableViewCell()
    /// Nib `SimpleCarouselItemCell`.
    static let simpleCarouselItemCell = _R.nib._SimpleCarouselItemCell()
    /// Nib `SimpleCarouselItemView`.
    static let simpleCarouselItemView = _R.nib._SimpleCarouselItemView()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "AddressDetailsTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.addressDetailsTableViewCell) instead")
    static func addressDetailsTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.addressDetailsTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "AlertView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.alertView) instead")
    static func alertView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.alertView)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "BaseDetailsTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.baseDetailsTableViewCell) instead")
    static func baseDetailsTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.baseDetailsTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "EatListTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.eatListTableViewCell) instead")
    static func eatListTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.eatListTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "HighlightsTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.highlightsTableViewCell) instead")
    static func highlightsTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.highlightsTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "ImageHeaderTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.imageHeaderTableViewCell) instead")
    static func imageHeaderTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.imageHeaderTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SimpleCarouselItemCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.simpleCarouselItemCell) instead")
    static func simpleCarouselItemCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.simpleCarouselItemCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SimpleCarouselItemView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.simpleCarouselItemView) instead")
    static func simpleCarouselItemView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.simpleCarouselItemView)
    }
    #endif

    static func addressDetailsTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> AddressDetailsTableViewCell? {
      return R.nib.addressDetailsTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? AddressDetailsTableViewCell
    }

    static func alertView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.alertView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    static func baseDetailsTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> BaseDetailsTableViewCell? {
      return R.nib.baseDetailsTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? BaseDetailsTableViewCell
    }

    static func eatListTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> EatListTableViewCell? {
      return R.nib.eatListTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? EatListTableViewCell
    }

    static func highlightsTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> HighlightsTableViewCell? {
      return R.nib.highlightsTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? HighlightsTableViewCell
    }

    static func imageHeaderTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> ImageHeaderTableViewCell? {
      return R.nib.imageHeaderTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ImageHeaderTableViewCell
    }

    static func simpleCarouselItemCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SimpleCarouselItemCell? {
      return R.nib.simpleCarouselItemCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SimpleCarouselItemCell
    }

    static func simpleCarouselItemView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.simpleCarouselItemView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `PopularItem`.
    static let popularItem: Rswift.ReuseIdentifier<SimpleCarouselItemCell> = Rswift.ReuseIdentifier(identifier: "PopularItem")

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try nib.validate()
    #endif
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _AlertView.validate()
      try _EatListTableViewCell.validate()
    }

    struct _AddressDetailsTableViewCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "AddressDetailsTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> AddressDetailsTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? AddressDetailsTableViewCell
      }

      fileprivate init() {}
    }

    struct _AlertView: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "AlertView"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      func secondView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[1] as? UIKit.UIView
      }

      static func validate() throws {
        if UIKit.UIImage(named: "ErrorIcon", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ErrorIcon' is used in nib 'AlertView', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _BaseDetailsTableViewCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "BaseDetailsTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> BaseDetailsTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? BaseDetailsTableViewCell
      }

      fileprivate init() {}
    }

    struct _EatListTableViewCell: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "EatListTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> EatListTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? EatListTableViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "ArmyStar", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ArmyStar' is used in nib 'EatListTableViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _HighlightsTableViewCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "HighlightsTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> HighlightsTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? HighlightsTableViewCell
      }

      fileprivate init() {}
    }

    struct _ImageHeaderTableViewCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "ImageHeaderTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> ImageHeaderTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ImageHeaderTableViewCell
      }

      fileprivate init() {}
    }

    struct _SimpleCarouselItemCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = SimpleCarouselItemCell

      let bundle = R.hostingBundle
      let identifier = "PopularItem"
      let name = "SimpleCarouselItemCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SimpleCarouselItemCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SimpleCarouselItemCell
      }

      fileprivate init() {}
    }

    struct _SimpleCarouselItemView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SimpleCarouselItemView"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try eatList.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try targetDetails.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct eatList: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = EatListViewController

      let bundle = R.hostingBundle
      let name = "EatList"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct targetDetails: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = TargetDetailsViewController

      let bundle = R.hostingBundle
      let name = "TargetDetails"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
