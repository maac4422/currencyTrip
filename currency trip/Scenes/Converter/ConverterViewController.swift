//
//  converterViewController.swift
//  currency trip
//
//  Created by Guillermo Costa on 6/2/19.
//  Copyright (c) 2019 Guillermo Costa. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ConverterDisplayLogic: class {
    func convertCurrency(viewModel: [Currency.Fetch.ViewModel])
    func displayCurrencies(viewModel: [Currency.Fetch.ViewModel])
    func displayCurrenciesFetchingError(response: String)
}

class ConverterViewController: UIViewController {
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var currenciesTableView: UITableView!
    @IBOutlet weak var currencyTableViewCell: GroupTableViewCell!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var interactor: ConverterBusinessLogic?
    var router: (NSObjectProtocol & ConverterRoutingLogic & ConverterDataPassing)?
    
    var currencies: [Currency.Fetch.ViewModel] = []

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = ConverterInteractor()
        let presenter = ConverterPresenter()
        let router = ConverterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        TODO complete
//        displayCurrencies(viewModel: <#Currency.Fetch.ViewModel#>)
    }

    
}

extension ConverterViewController: ConverterDisplayLogic {
    
    func convertCurrency(viewModel: [Currency.Fetch.ViewModel]) {
//        let request = Currency.Fetch.Request()
        currencies = viewModel
        showResults(show: true)
        currenciesTableView.reloadData()
    }
    
    func displayCurrencies(viewModel: [Currency.Fetch.ViewModel]) {
        currencies = viewModel
        interactor?.fetch()
    }
    
    func displayCurrenciesFetchingError(response: String) {
        displayMessage(message: response)
    }
    
}

private extension ConverterViewController {
    
    func displayMessage(message: String) {
        messageLabel.text = message
        showResults(show: false)
    }
    
    func showResults(show: Bool) {
        currenciesTableView.isHidden = !show
        messageLabel.isHidden = show
    }
}

extension ConverterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as!currencyTableViewCell
        cell. = currencies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? currencyTableViewCell {
            transitionImage = cell.groupImage
            transitionLabel = cell.groupName
            transitionContainerView = cell.salmonSquare
            interactor?.showGroup(group: cell.group)
        }
    }
}
