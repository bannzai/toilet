//
//  ContentView.swift
//  Toilet
//
//  Created by Yudai.Hirose on 2020/12/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: fire, label: {
                Text("🚽")
                    .font(.largeTitle)
            })
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                currentNotificationPermitStatus(closure: requestAuthorizationIfNotPermit(settings:))
            }
        })
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
