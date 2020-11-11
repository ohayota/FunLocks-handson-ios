//
//  ContentView.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                CircleImage(image: Image("MyImage"))
                BeaconList()
                VStack(alignment: .leading) {
                    Text("FunLocks")
                        .font(.title)
                    HStack() {
                        Text("Beacon Sample App")
                            .font(.subheadline)
                        Spacer()
                        Text("2020.11.30(Mon)")
                            .font(.subheadline)
                    }
                }
                .padding()
            }
            .navigationBarTitle(Text("BeaconSearch"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
