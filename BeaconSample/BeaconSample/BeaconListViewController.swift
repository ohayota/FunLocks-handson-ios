//
//  BeaconListViewController.swift
//  BeaconSample
//
//  Created by Yota Nakamura on 2020/11/20.
//

import UIKit

class BeaconListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension BeaconListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchViewController.selectedBeacon = beaconData[indexPath.row]
        self.present(searchViewController, animated: true, completion: nil)
    }
}

extension BeaconListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beaconData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = beaconData[indexPath.row].name
        cell.detailTextLabel?.text = beaconData[indexPath.row].info.uuid
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Observable - 観測可能"
    }
}


