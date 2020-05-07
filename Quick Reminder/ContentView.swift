//
//  ContentView.swift
//  Quick Reminder
//
//  Created by Kilian Friedrich on 26.04.20.
//  Copyright © 2020 Kilian Friedrich. All rights reserved.
//

import SwiftUI

func notification(_ txt: String) {
    if txt.isEmpty { return }
    
    let content = UNMutableNotificationContent()
    content.badge = 0
    content.body = txt
    content.title = "Remember:"
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
    
    let req = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    nCenter.add(req)
    
}

struct ContentView: View {
    
    @State var reminderWorks = true;
    
    var body: some View {
        
        let reminderView = ReminderView(onSubmission: { str, callback in
            ifNotificationsUndetermined(then: {
                getProvisionalAuthorization { granted in
                    if(granted) {
                        notification(str)
                        callback()
                    } else {
                        self.reminderWorks = false;
                    }
                }
            }, andElse: {
                ifNotificationsDenied(then: {
                    self.reminderWorks = false
                }, andElse: {
                    notification(str)
                    callback()
                })
            })
        })
        
        return Group() {
            if(reminderWorks) {
                reminderView
            } else {
                IntroductionView {
                    ifNotificationsDenied(then: {}) {
                        self.reminderWorks = true
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
