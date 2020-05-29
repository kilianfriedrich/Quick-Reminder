//
//  ReminderView.swift
//  Quick Reminder :)
//
//  Created by Kilian Friedrich on 26.04.20.
//  Copyright © 2020 Kilian Friedrich. All rights reserved.
//

import SwiftUI

struct ReminderView: View {
    
    @Binding var txt: String
    var onSubmission: (String, @escaping () -> Void) -> Void
    @State var showS = false
    
    var body: some View {
        
        // Animate button appearance with help of this binding
        let txtBinding: Binding<String> = Binding<String>(
            get: { self.txt },
            set: { let newStr = $0; withAnimation { self.txt = newStr } })
        
        return VStack() {
            
            Spacer()
            
            Text("Quick Reminder")
                .font(.title)
            Text(showS ? "A reminder is in your notification center" : "by Kilian Friedrich")
                .font(.subheadline)
                .foregroundColor(showS ? .green : .primary)
            
            ZStack() {
                Spacer()
            }
            
            VStack {
                
                ZStack {
                    if(txt.isEmpty) {
                        Text("Remind me of...")
                            .padding(txt.isEmpty ? .all : [.top, .leading, .trailing])
                            .foregroundColor(.gray)
                            .transition(AnyTransition.offset(y: -18.0)
                                .combined(with: .opacity))
                    }
                    TextField("", text: txtBinding)
                        .padding(txt.isEmpty ? .all : [.top, .leading, .trailing])
                        .multilineTextAlignment(.center)
                }
                
                if !txt.isEmpty {
                    Button(action: {
                        self.onSubmission(self.txt) {
                            withAnimation { self.txt = ""; self.showS = true }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                withAnimation { self.showS = false }
                            }
                        }
                    }) {
                        Text("Remind me!")
                            .padding([.leading, .bottom, .trailing])
                    }
                    .transition(AnyTransition.offset()
                    .combined(with: .opacity))
                }
                
            }
            .frame(height: 0.0)
            
            Spacer()
            Spacer()
            Spacer()
            
        }
        
    }
}

