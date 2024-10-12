//
//  AppDelegate+.swift
//
//  Created by ykkd on 2024/01/25.
//  Copyright © 2024 and factory,inc. All rights reserved.
//

import AppEnvironment
import Foundation

// MARK: - Projectfile specfic
extension AppDelegate {

    func injectAppEnvironment() {
        #if DEBUG
        AppEnvironment.inject(.productionDebug)
        #elseif RELEASE
        AppEnvironment.inject(.productionRelease)
        #else
        AppEnvironment.inject(.productionRelease)
        #endif
    }
}
