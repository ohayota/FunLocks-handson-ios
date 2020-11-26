//
//  ViewController.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/12.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var proximityLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var majorMinorLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var rssiAccuracyLabel: UILabel!
    
    var locationManager: CLLocationManager!
    var selectedBeacon: Beacon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        uuidLabel.text = selectedBeacon!.info.uuid
        majorMinorLabel.text = "\(selectedBeacon!.info.major) / \(selectedBeacon!.info.minor)"
        
        updateStatus(proximity: CLProximity.unknown, rssi: nil, accuracy: nil)
    }
    
    // MARK: - 信号検知を開始する
    func startScanning() {
        let uuid = UUID(uuidString: selectedBeacon!.info.uuid)!
        let major = CLBeaconMajorValue(selectedBeacon!.info.major)
        let minor = CLBeaconMinorValue(selectedBeacon!.info.minor)
        
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: CLBeaconIdentityConstraint(uuid: uuid, major: major, minor: minor), identifier: "MyBeacon")
        
//        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: "MyBeacon")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
    }
    
    // MARK: - ビーコンとの近さによって値や背景色を変える
    func updateStatus(proximity: CLProximity, rssi: Int?, accuracy: CLLocationAccuracy?) {
        UIView.animate(withDuration: 0.8) {
            switch proximity {
            case .far:
                self.view.backgroundColor = #colorLiteral(red: 0.1621580884, green: 0.2816633245, blue: 0.4011685605, alpha: 1)
                self.proximityLabel.text = "FAR"
                self.rssiAccuracyLabel.text = "\(rssi!) / \(floor(Double(accuracy!)*100)/100)(m)"
            case .near:
                self.view.backgroundColor = #colorLiteral(red: 0.2883472712, green: 0.2883472712, blue: 0.1165541044, alpha: 1)
                self.proximityLabel.text = "NEAR"
                self.rssiAccuracyLabel.text = "\(rssi!) / \(floor(Double(accuracy!)*100)/100)(m)"
            case .immediate:
                self.view.backgroundColor = #colorLiteral(red: 0.3962918134, green: 0.1601868372, blue: 0.1641219201, alpha: 1)
                self.proximityLabel.text = "IMMEDIATE"
                self.rssiAccuracyLabel.text = "\(rssi!) / \(floor(Double(accuracy!)*100)/100)(m)"
            default:
                self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                self.proximityLabel.text = "UNKNOWN"
                self.rssiAccuracyLabel.text = "- / -"
            }
        }
    }

}

extension SearchViewController: CLLocationManagerDelegate {
    
    // MARK: - 位置情報取得が許可されているかを取得する
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    // MARK: - 信号を拾ったビーコンの情報を取得する
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        for beacon in beacons {
            if beacon.uuid.uuidString == selectedBeacon!.info.uuid {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "ja_JP")
                dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                timestampLabel.text = dateFormatter.string(from: beacon.timestamp)
                updateStatus(proximity: beacon.proximity, rssi: beacon.rssi, accuracy: beacon.accuracy)
                return // 1個でも一致したら他のビーコンは確認不要なため，関数から脱出する
            }
        }
        updateStatus(proximity: .unknown, rssi: nil, accuracy: nil)
    }
    
}
