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
    case medium = 32
    case large = 64
}

enum CountryFlagTheme: String {
    case flat
    case shiny
}

protocol ICountryFlagsAPI {
    var baseMethod: String { get }
    var baseScheme: String { get }
    var baseUrl: String { get }
    var imageFormat: String { get }
    var imageSize: CountryFlagSize { get }
    var imageTheme: CountryFlagTheme { get }
    
    func request(for flag: String, completionHandler: @escaping CompletionRequestFlag)
}

/// Use
/**
 let countryFlagApi = CountryFlagsAPI()
 countryFlagApi.request(for: "CO" { data, response, error in
    guard let data = data, error == nil else { return }
    print(response?.suggestedFilename ?? url.lastPathComponent)
    print("Download Finished")
    DispatchQueue.main.async() {
        self.imageView.image = UIImage(data: data)
    }
}
*/

// https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
// https://www.countryflags.io/eu/flat/48.png
class CountryFlagsAPI: ICountryFlagsAPI {
    let baseHost = "www.countryflags.io"
    let baseMethod = "GET"
    let baseScheme = "https"
    let baseUrl: String
    let imageFormat = ".png"
    let imageSize: CountryFlagSize
    let imageTheme: CountryFlagTheme
    
    init(imageSize: CountryFlagSize = .medium) {
        self.baseUrl = "https://www.countryflags.io/"
        self.imageSize = imageSize
        self.imageTheme = .flat
    }
    
    func request(for flag: String, completionHandler: @escaping CompletionRequestFlag) {
        let urlSepare = "/"
        let urlImage = imageTheme.rawValue + urlSepare + String(imageSize.rawValue) + imageFormat
        print(urlImage)
        var components = URLComponents()
        components.scheme = baseScheme
        components.host = baseHost
        components.path = urlImage
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = baseMethod
        URLSession.shared.dataTask(with: urlRequest, completionHandler: completionHandler)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
