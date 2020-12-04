//
//  CreateStationsTable.swift
//  
//
//  Created by SinoMac on 02/12/2020.
//

import Foundation
import Fluent
import FluentSQLiteDriver

struct CreateStationsTable: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database
            .schema(Station.schema)
            .id()
            .field("name", .string)
            .field("active", .bool)
            .create()
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Station.schema).delete()
    }
}
