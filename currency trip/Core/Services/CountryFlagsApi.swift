//
//  CountryFlagsApi.swift
//  currency trip
//
//  Created by Guillermo Costa on 6/2/19.
//  Copyright © 2019 Guillermo Costa. All rights reserved.
//

import Foundation
import UIKit

typealias CompletionRequestFlag = (Data?, URLResponse?, Error?) -> ()

enum CountryFlagSize: Int {
    case small = 24
    case medium = 48
    case large = 64
}

enum CountryFlagTheme: String {
    case flat
    case shiny
}

protocol ICountryFlagsAPI {
    var baseMethod: String { get }
    var baseScheme: String { get }
    var imageFormat: String { get }
    var imageSize: CountryFlagSize { get }
    var imageTheme: CountryFlagTheme { get }
    
    func request(for flag: String, completionHandler: @escaping CompletionRequestFlag)
}

class CountryFlagsAPI: ICountryFlagsAPI {
    let baseHost = "www.countryflags.io"
    let baseMethod = "GET"
    let baseScheme = "https"
    let imageFormat = ".png"
    let imageSize: CountryFlagSize
    let imageTheme: CountryFlagTheme
    
    init(imageSize: CountryFlagSize = .medium) {
        self.imageSize = imageSize
        self.imageTheme = .flat
    }
    
    func getUrlRequest(for flag: String) -> URLRequest? {
        let urlSepare = "/"
        var urlImage = urlSepare + flag + urlSepare + imageTheme.rawValue
        urlImage += urlSepare + String(imageSize.rawValue) + imageFormat
        var components = URLComponents()
        components.scheme = baseScheme
        components.host = baseHost
        components.path = urlImage
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = baseMethod
        return urlRequest
    }
    
    func request(for flag: String, completionHandler: @escaping CompletionRequestFlag) {
        guard let urlRequest = getUrlRequest(for: flag) else { return }
        URLSession.shared.dataTask(with: urlRequest, completionHandler: completionHandler)
    }
}

extension UIImageView {
    
    private func download(from urlRequest: URLRequest, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    self.image = #imageLiteral(resourceName: "flag.png")
                    return
            }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func downloadFlag(from code: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        let countryFlagsApi = CountryFlagsAPI()
        guard let urlRequest = countryFlagsApi.getUrlRequest(for: code) else {
            self.image = #imageLiteral(resourceName: "flag.png")
            return
        }
        download(from: urlRequest, contentMode: mode)
    }
}
