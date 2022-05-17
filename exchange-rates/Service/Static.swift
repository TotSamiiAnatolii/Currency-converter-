//
//  Static.swift
//  exchange rates
//
//  Created by APPLE on 06.04.2022.
//

import Foundation

struct Data {
    static var shared = Data()
    var valuteArray: RatesModelDTO?
}

