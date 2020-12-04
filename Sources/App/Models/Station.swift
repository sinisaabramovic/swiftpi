//
//  Station.swift
//  
//
//  Created by SinoMac on 02/12/2020.
//

import Foundation
import Fluent
import Vapor

final class Station: Model, Content {
    
    static let schema = "stations"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "active")
    var active: Bool
    
    init() {}
    
    init(id: UUID? = nil, name: String, active: Bool = true) {
        self.id = id
        self.name = name
        self.active = active
    }
}
