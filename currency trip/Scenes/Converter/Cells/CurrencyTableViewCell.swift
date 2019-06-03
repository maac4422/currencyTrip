//
//  CurrencyViewCell.swift
//  currency trip
//
//  Created by Guillermo Costa on 6/3/19.
//  Copyright © 2019 Guillermo Costa. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView! {
        didSet {
            flagImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var currency: Currency.Fetch.ViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        guard let currency = currency  else { return }
        codeLabel.text = currency.code
        convertedValueLabel.text = currency.convertedValue?.description
        nameLabel.text = currency.name
        valueLabel.text = currency.value.description
        if let imageCode = currency.image {
            self.flagImageView.downloadFlag(from: imageCode)
        }
    }
}
