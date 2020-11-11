//
//  ContentView.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/11.
//

import SwiftUI

struct ContentView: View {
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $isSearching) {
                    Text("Search Beacon")
                }
                .padding()
//                CircleImage(image: Image("MyImage"))
                if self.isSearching {
                    BeaconList()
                } else {
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text("iOS & Beacon Lecture")
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
