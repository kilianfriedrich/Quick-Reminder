//
//  ContentView.swift
//  Quick Reminder
//
//  Created by Kilian Friedrich on 26.04.20.
//  Copyright © 2020 Kilian Friedrich. All rights reserved.
//

import SwiftUI

func notification(_ txt: String) {
    
}

struct ContentView: View {
    
    @State var txt: String = "Test"
    
    var body: some View {
        
        let txtBinding: Binding<String> = Binding<String>(
            get: { self.txt },
            set: { let newStr = $0; withAnimation() { self.txt = newStr } })
        
        return VStack() {
            
            Spacer()
            
            Text("Quick Reminder")
                .font(.title)
            Text("by Kilian Friedrich")
                .font(.subheadline)
            
            Spacer()
            
            VStack {
                
                TextField("Remind me of...", text: txtBinding)
                    .padding(txt.isEmpty ? .all : [.top, .leading, .trailing])
                    .multilineTextAlignment(.center)
                
                if !txt.isEmpty {
                    Button(action: { notification(self.txt) }) {
                        Text("Remind me!")
                            .padding()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
