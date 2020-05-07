//
//  NotificationChecker.swift
//  Quick Reminder
//
//  Created by Kilian Friedrich on 07.05.20.
//  Copyright © 2020 Kilian Friedrich. All rights reserved.
//

import SwiftUI

let nCenter = UNUserNotificationCenter.current()

func ifNotificationsDenied(then: @escaping () -> Void, andElse: @escaping () -> Void) {
    nCenter.getNotificationSettings { settings in
        if(settings.authorizationStatus == .denied) {
            then()
        } else {
            andElse()
        }
    }
}

func ifNotificationsUndetermined(then: @escaping () -> Void, andElse: @escaping () -> Void) {
    nCenter.getNotificationSettings { settings in
        if(settings.authorizationStatus == .notDetermined) {
            then()
        } else {
            andElse()
        }
    }
}

func getProvisionalAuthorization(callback: @escaping (Bool) -> Void) {
    nCenter.requestAuthorization(options: [.provisional, .alert, .sound]) { granted, error in
        callback(granted)
    }
}
