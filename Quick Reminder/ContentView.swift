//
//  ContentView.swift
//  Quick Reminder
//
//  Created by Kilian Friedrich on 26.04.20.
//  Copyright © 2020 Kilian Friedrich. All rights reserved.
//

import SwiftUI

// Sends a local notification
func notification(_ txt: String) {
    // Don't send empty notifications
    if txt.isEmpty { return }
    
    // A simple notification body with "Remember: [content]"
    let content = UNMutableNotificationContent()
    content.badge = 0
    content.body = txt
    content.title = "Remember:"
    
    // Send it after 0.01 seconds as 0 seconds are not supported
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
    
    // Create formal request and send it
    let req = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    nCenter.add(req)
    
} // END notification(_: String)

// The entry view which changes between the ReminderView and the ErrorView
struct ContentView: View {
    
    @State var reminderWorks = true  // Sets whether ReminderView or ErrorView should be shown
    @State var content = ""  // Stores the ReminderView's text content
    
    var body: some View {
        
        let reminderView = ReminderView(txt: $content, onSubmission: { str, callback in
            
            ifNotificationsUndetermined(then: { // if notification rights are undetermined
                
                getProvisionalAuthorization { granted in
                    if(granted) { // if provisional authorization is granted
                        
                        notification(str)
                        callback()
                        
                    } else { // if provisional authorization is not granted
                        
                        self.reminderWorks = false;
                        
                    } // END else
                } // END getProvisionalAuthorization
                
            }, andElse: { // if notification rights are already determined
                
                ifNotificationsDenied(then: {
                    
                    self.reminderWorks = false
                    
                }, andElse: { // if no notification rights
                    
                    notification(str)
                    callback()
                    
                }) // END andElse
                
            }) // END andElse
            
        } // END onSubmission lambda
        ) // END ReminderView.init(txt: String, onSubmission: lambda)
        
        return Group() {
            if(reminderWorks) {
                
                reminderView
                
            } else {
                
                ErrorView {  // what happens when user tries to close the view:
                    ifNotificationsDenied(then: {}) { // else:
                        notification(self.content) // Send notification
                        self.reminderWorks = true // show ReminderView
                    }
                } // END ErrorView
                
            } // END else
        } // END Group
        
    }
}
