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
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationBarTitle(Text(beacon.name), displayMode: .inline)
    }
}

struct BeaconDetail_Previews: PreviewProvider {
    static var previews: some View {
        BeaconDetail(beacon: beaconData[0])
    }
}
