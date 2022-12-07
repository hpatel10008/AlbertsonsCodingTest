//
//  AcronymListVC.swift
//  CoadingTest
//
//  Created by Hiren  Patel on 12/6/22.
//

import UIKit
import PKHUD

class AcronymListVC: UIViewController {

    @IBOutlet weak var tblAcronymList : UITableView!
   // @IBOutlet weak var progressBar : UIActivityIndicatorView!
    
    var acronymVM = AcronymViewModel()
    let sc = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = codingTest
        self.showSearchbar()
    }
    private func showSearchbar() {
        sc.searchBar.delegate = self
        if #available(iOS 13.0, *) {
            if let textfield = sc.searchBar.value(forKey: "searchTextField") as? UITextField {
                textfield.placeholder = textField_Placeholder
                if let backgroundview = textfield.subviews.first {
                    backgroundview.layer.cornerRadius = 10;
                    backgroundview.clipsToBounds = true;
                }
            }
        } else {
            sc.searchBar.tintColor = .white
            if let textfield = sc.searchBar.value(forKey: "Search Acronym here") as? UITextField {
                textfield.placeholder = textField_Placeholder
                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
        }
        sc.searchBar.layoutIfNeeded()
        sc.searchBar.layoutSubviews()
        navigationItem.searchController = sc
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func validateSpaceInTextField(searchText:String) -> Bool{
        let characterSet:NSCharacterSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        
        if searchText.contains(" ") {
            return false
        }
        if searchText.rangeOfCharacter(from: characterSet.inverted) != nil {
           return false
        }
        return true
    }
    
    func showHUD() {
        HUD.show(.progress, onView: self.tblAcronymList)
    }
    func hideHUD() {
        HUD.hide()
    }
}

extension AcronymListVC : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // make api call
        acronymVM.longFormList.removeAll()
        self.tblAcronymList.reloadData()
        
        self.showHUD()
        if validateSpaceInTextField(searchText: searchBar.text ?? "") {
            if let acronym = searchBar.text {
                acronymVM.getListForAcronym(acronym: acronym) { (success, error) in
                    self.hideHUD()
                    if(success){
                        self.tblAcronymList.reloadData()
                    }
                    else {
                        if let e = error as? NSError {
                            Utility.showErrorAlert(with: e.userInfo["message"] as? String ?? default_Error, controller: self)
                        }
                    }
                }
            }
        } else {
            self.hideHUD()
            Utility.showErrorAlert(with: empty_Field, controller: self)
           
        }
       
    }
}

extension AcronymListVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {

            var numOfSections: Int = 0
        if acronymVM.longFormList.count > 0
            {
                tableView.separatorStyle = .singleLine
                numOfSections            = 1
                tableView.backgroundView = nil
            }
            else
            {
                let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
                noDataLabel.text          = noDataText
                noDataLabel.textColor     = UIColor.black
                noDataLabel.textAlignment = .center
                tableView.backgroundView  = noDataLabel
                tableView.separatorStyle  = .none
            }
            return numOfSections

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acronymVM.longFormList.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcronymListCell", for: indexPath) as! AcronymListCell
        let longForData = acronymVM.longFormList[indexPath.row]
        cell.setAcronyData(longForData)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = mainStoryBoard.instantiateViewController(withIdentifier: "AcronymDetailVC") as! AcronymDetailVC
            detailVC.slectedLF = acronymVM.longFormList[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
