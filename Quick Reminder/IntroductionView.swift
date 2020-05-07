//
//  IntroductionView.swift
//  Quick Reminder
//
//  Created by Kilian Friedrich on 27.04.20.
//  Copyright © 2020 Kilian Friedrich. All rights reserved.
//

import SwiftUI

let center = UNUserNotificationCenter.current()

struct IntroductionView: View {
    
    var onClick: () -> Void
    
    var body: some View {
        VStack() {
            VStack(alignment: .leading) {
                Text("That didn't work!")
                    .font(.largeTitle)
                    .padding()
                Text("This app needs the permission to send you notifications to remind you.")
                    .padding()
                Text("Go to Settings > Notifications > Quick Reminder and enable notifications to continue.")
                .padding()
            }
            Button(action: {
                self.onClick()
            }) {
                Text("Got it!")
                    .padding()
            }
        }
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView {}
    }
}
