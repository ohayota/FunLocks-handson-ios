//
//  BeaconListViewController.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/20.
//

import UIKit

class BeaconListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var beaconList = beaconData
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension BeaconListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        secondViewController.selectedBeacon = beaconList[indexPath.row]
        self.present(secondViewController, animated: true, completion: nil)
    }
}

extension BeaconListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beaconList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = beaconList[indexPath.row].name
        cell.detailTextLabel?.text = "\(beaconList[indexPath.row].info.uuid)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Observable - 観測可能"
    }
}


