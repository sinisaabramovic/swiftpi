//
//  Address.swift
//  
//
//  Created by SinoMac on 02/12/2020.
//

import Foundation
import Vapor

struct Address: Content {
    let altitude: String
    let latitude: String
    let city: String
    let country: String
    let street: String
    let number: String
}
