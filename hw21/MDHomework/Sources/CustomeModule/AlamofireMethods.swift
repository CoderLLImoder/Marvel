//
//  AlamofireMethods.swift
//  MDHomework
//
//  Created by Илья Капёрский on 20.10.2023.
//

import Foundation
import Alamofire

func fetchSeries() {
    let request = AF.request("https://api.jikan.moe/v3/anime/38000")
    request.responseJSON { (data) in
        print (data)
    }
}
