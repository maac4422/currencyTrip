//
//  CurrencyDetail.swift
//  currencyWatch Extension
//
//  Created by Miguel Angel Arenas Correa on 6/3/19.
//  Copyright © 2019 Guillermo Costa. All rights reserved.
//

import WatchKit

class CurrencyDetailController: WKInterfaceController {

    @IBOutlet weak var imageCoutry: WKInterfaceImage!
    @IBOutlet weak var valueCurrency: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        let context = context as! String
        valueCurrency.setText(context)
    }
}
