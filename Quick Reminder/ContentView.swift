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
    
    
    
}

struct ContentView: View {
    
    @State var txt: String = ""
    
    var body: some View {
        
        let txtBinding: Binding<String> = Binding<String>(
            get: { self.txt },
            set: { let newStr = $0; withAnimation(.easeInOut) { self.txt = newStr } })
        
        return VStack() {
            
            Spacer()
            
            Text("Quick Reminder")
                .font(.title)
            Text("by Kilian Friedrich")
                .font(.subheadline)
            
            Spacer()
            
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
                    Button(action: { notification(self.txt) }) {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
