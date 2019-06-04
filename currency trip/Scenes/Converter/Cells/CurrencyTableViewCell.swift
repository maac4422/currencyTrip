//
//  CurrencyViewCell.swift
//  currency trip
//
//  Created by Guillermo Costa on 6/3/19.
//  Copyright © 2019 Guillermo Costa. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var codeLabel: UILabel! {
        didSet {
            codeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24.0)
        }
    }
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView! {
        didSet {
            flagImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel! {
        didSet {
            valueLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 22.0)
        }
    }
    
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

@IBDesignable
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
