//
//  AcronymDetailVC.swift
//  CoadingTest
//
//  Created by Hiren  Patel on 12/6/22.
//

import UIKit

class AcronymDetailVC: UIViewController {

    @IBOutlet weak var tblAcronymList: UITableView!
    @IBOutlet weak var lblSelectedLF: UILabel!
    
    var slectedLF: LF?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = albertsons
        lblSelectedLF.text = slectedLF?.lf
    }
}
extension AcronymDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slectedLF?.vars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcronymListCell", for: indexPath) as! AcronymListCell
        let longForData = slectedLF?.vars?[indexPath.row]
        cell.setAcronyData(longForData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
