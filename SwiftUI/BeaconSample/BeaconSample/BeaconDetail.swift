//
//  BeaconDetail.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/11.
//

import SwiftUI
import CoreLocation

struct BeaconDetail: View {
    var beacon: Beacon
    
    var body: some View {
        VStack {
            CircleImage(image: Image(beacon.imageName))
            Spacer()
            VStack(alignment: .leading) {
                Text("beacon: Beacon")
                    .font(.title)
                HStack() {
                    Text("id: Int")
                        .font(.subheadline)
                    Spacer()
                    Text("\(beacon.id)")
                        .font(.subheadline)
                }
                HStack() {
                    Text("name: String")
                        .font(.subheadline)
                    Spacer()
                    Text("\(beacon.name)")
                        .font(.subheadline)
                }
                HStack() {
                    Text("imageName: String")
                        .font(.subheadline)
                    Spacer()
                    Text("\(beacon.imageName)")
                        .font(.subheadline)
                }
            }
            .padding()
            VStack(alignment: .leading) {
                Text("info: CLBeacon")
                    .font(.title)
                HStack() {
                    Text("uuid: String")
                        .font(.subheadline)
                    Spacer()
                    Text("\(beacon.info.uuid)")
                        .font(.subheadline)
                }
                HStack() {
                    Text("major: Int")
                        .font(.subheadline)
                    Spacer()
                    Text("\(beacon.info.major)")
                        .font(.subheadline)
                }
                HStack() {
                    Text("minor: Int")
                        .font(.subheadline)
                    Spacer()
                    Text("\(beacon.info.minor)")
                        .font(.subheadline)
                }
            }
            .padding()
        }
        .navigationBarTitle(Text(beacon.name), displayMode: .inline)
    }
}

struct BeaconDetail_Previews: PreviewProvider {
    static var previews: some View {
        BeaconDetail(beacon: beaconData[0])
    }
}
