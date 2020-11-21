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
    }

}

extension BeaconListViewController: UITableViewDelegate {
    // MARK: - TableViewCellがタップされたときに呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchViewController.selectedBeacon = beaconData[indexPath.row]
        self.present(searchViewController, animated: true, completion: nil)
    }
}

extension BeaconListViewController: UITableViewDataSource {
    // MARK: - TableViewCellの生成行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beaconData.count
    }
    
    // MARK: - TableViewCellを生成して返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = beaconData[indexPath.row].name
        cell.detailTextLabel?.text = beaconData[indexPath.row].info.uuid
        return cell
    }
    
    // MARK: - TableViewCellをまとめるSectionのタイトルを返す
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Observable - 観測可能"
    }
}


