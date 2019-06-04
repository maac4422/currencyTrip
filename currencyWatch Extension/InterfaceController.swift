//
//  InterfaceController.swift
//  currencyWatch Extension
//
//  Created by Miguel Angel Arenas Correa on 6/3/19.
//  Copyright © 2019 Guillermo Costa. All rights reserved.
//

import WatchKit
import Foundation

public extension WKInterfaceImage {
    
    @discardableResult public func setImageWithUrl(url:String, scale: CGFloat = 1.0) -> WKInterfaceImage? {
        
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
            if (data != nil && error == nil) {
                let image = UIImage(data: data!, scale: scale)
                
                DispatchQueue.main.async {
                    self.setImage(image)
                }
            }
            }.resume()
        
        return self
    }
}

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var tableCurrency: WKInterfaceTable!
    let numberRows = 3
    override init() {
        super.init()
        configureTable()
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func configureTable()
    {
        tableCurrency.setNumberOfRows(numberRows, withRowType: ImageLabelRowController.identifier)
        for row in 0..<tableCurrency.numberOfRows
        {
            let imageLabelRowController = tableCurrency.rowController(at: row) as! ImageLabelRowController
            imageLabelRowController.valueCurrency.setText("000001")
                imageLabelRowController.image.setImageWithUrl(url: "https://picsum.photos/200/300")
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        if segueIdentifier == "cellSelected" {
            return "Hola"
        }
        return nil
    }
}
