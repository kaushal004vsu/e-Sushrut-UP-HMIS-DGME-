//
//  Bundle\.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 22/07/22.
//

import Foundation
extension Bundle {
    // Name of the app - title under the icon.
    var displayName: String? {
            return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
                object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
