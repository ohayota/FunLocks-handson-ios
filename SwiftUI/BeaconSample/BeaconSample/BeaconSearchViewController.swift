//
//  BeaconSearchView.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/12.
//
//
import UIKit
import SwiftUI
import CoreLocation

struct BeaconSearchViewController: UIViewControllerRepresentable {
    
//    var controllers: [UIViewController]
//    @Binding var currentPage: Int

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> BeaconSearchViewController {
        let beaconSearchViewController = BeaconSearchViewController()
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

        return beaconSearchViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
//        pageViewController.setViewControllers(
//            [controllers[currentPage]], direction: .forward, animated: true)
    }

    class Coordinator: NSObject, CLLocationManagerDelegate {
        var parent: BeaconSearchViewController
        
        // CoreLocation
        var locationManager : CLLocationManager!
        var beaconRegion : CLBeaconRegion!
        
        init(_ beaconSearchViewController: BeaconSearchViewController) {
            self.parent = beaconSearchViewController
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            let status = CLLocationManager.authorizationStatus()
            // 位置情報の認証が許可されていない場合は認証ダイアログを表示
            if (status != CLAuthorizationStatus.authorizedWhenInUse) {
                locationManager.requestWhenInUseAuthorization()
            }
            // 受信対象のビーコンのUUIDを設定
            let uuid: UUID? = UUID(uuidString: beaconData[0].info.uuid)
            // ビーコン領域の初期化
            beaconRegion = CLBeaconRegion(uuid: uuid!, identifier: "BeaconApp")
        }
        
        // 位置情報の認証ステータス変更
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           
            if (status == .authorizedWhenInUse) {
                // ビーコン領域の観測を開始
                self.locationManager.startMonitoring(for: self.beaconRegion)
            }
        }

        // ビーコン領域の観測を開始
        func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
            // ビーコン領域のステータスを取得
            self.locationManager.requestState(for: self.beaconRegion)
        }
       
        // ビーコン領域のステータスを取得
        func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for inRegion: CLRegion) {

            switch (state) {
            case .inside: // ビーコン領域内
                // ビーコンの測定を開始
                self.locationManager.startRangingBeacons(satisfying: self.beaconRegion.beaconIdentityConstraint)
                break
            case .outside: // ビーコン領域外
                break

            case .unknown: // 不明
                break

            }
        }
           
        // ビーコン領域に入った時
        func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
            // ビーコンの位置測定を開始
            self.locationManager.startRangingBeacons(satisfying: self.beaconRegion.beaconIdentityConstraint)
           
        }

        // ビーコン領域から出た時
        func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
            // ビーコンの位置測定を停止
            self.locationManager.stopRangingBeacons(satisfying: self.beaconRegion.beaconIdentityConstraint)
        }
       
        // ビーコンの位置測定
        func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
            for beacon in beacons {
                print("uuid:\(beacon.uuid)")
                print("major:\(beacon.major)")
                print("minor:\(beacon.minor)")
                if (beacon.proximity == CLProximity.immediate) {
                    print("proximity:immediate")
                }
                if (beacon.proximity == CLProximity.near) {
                    print("proximity:near")
                }
                if (beacon.proximity == CLProximity.far) {
                    print("proximity:Far")
                }
                if (beacon.proximity == CLProximity.unknown) {
                    print("proximity:unknown")
                }
                print("accuracy:\(beacon.accuracy)")
                print("rssi:\(beacon.rssi)")
                print("timestamp:\(beacon.timestamp)")
            }
        }
    }
}

struct BeaconSearchViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
