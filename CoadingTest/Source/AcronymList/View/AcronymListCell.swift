//
//  AcronymListCell.swift
//  CoadingTest
//
//  Created by Hiren  Patel on 12/6/22.
//


import UIKit

class AcronymListCell: UITableViewCell {

    @IBOutlet weak var lblLF: UILabel!
    @IBOutlet weak var lblFreq: UILabel!
    @IBOutlet weak var lblSince: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAcronyData( _ lf:LF?) {
        if let lfTitle = lf?.lf {
            lblLF.text = lfTitle
        }
        if let lfFreq = lf?.freq {
            lblFreq.text = "Freq: " + String(lfFreq)
        }
        if let lfSince = lf?.since {
            lblSince.text = "Since: " + String(lfSince)
         }
    }
}
