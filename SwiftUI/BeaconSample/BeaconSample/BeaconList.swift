//
//  BeaconList.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/11.
//

import SwiftUI
import CoreLocation

struct BeaconList: View {
//    @State var locationManager = CLLocationManager()
//    @State var beaconRegion = CLBeaconRegion()

    // 位置情報の認証ステータスを取得
//    self.locationManagerDidChangeAuthorization(locationManager)
    
//    // 位置情報の認証が許可されていない場合は認証ダイアログを表示
//    if (status != CLAuthorizationStatus.authorizedWhenInUse) {
//        locationManager.requestWhenInUseAuthorization()
//    }
    
    var body: some View {
        List(beaconData) { beacon in
            NavigationLink(destination: BeaconDetail(beacon: beacon)) {
                BeaconRow(beacon: beacon)
            }
        }
    }
}

struct BeaconList_Previews: PreviewProvider {
    static var previews: some View {
        BeaconList()
    }
}
