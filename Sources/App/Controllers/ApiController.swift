//
//  ApiController.swift
//  
//
//  Created by SinoMac on 02/12/2020.
//

import Foundation
import Vapor
import SwiftyGPIO

struct APIController: RouteCollection {
    
    let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi4)
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api-stations")
        
        // Stations /stations
        api.get { request in
            try self.getStations(request: request)
        }

        api.get(":stationId", use: getStation)
        
        api.post("turnon", use: turnOn)
        
        api.post("turnoff", use: turnOff)
        
        api.post { request in
            try self.createStation(request: request)
        }
    }
}

// Stations
private extension APIController {
    
    func getStations(request: Request) throws -> EventLoopFuture<[Station]> {
        let allStations = Station.query(on: request.db).all()
        return allStations
    }
    
    func getStation(request: Request) throws -> EventLoopFuture<Station> {
        guard let stationId = request.parameters.get("stationId") else {
            throw Abort(.badRequest)
        }
        return Station.find(UUID(uuidString: stationId), on: request.db).unwrap(or: Abort(.notFound))
    }
    
    func createStation(request: Request) throws -> EventLoopFuture<Station> {
        let station = try request.content.decode(Station.self)
        station.id = nil
        return station.create(on: request.db).map { station }
    }
}

// GPIO
private extension APIController {
    
    func turnOn(request: Request) throws -> String {
        var gp = gpios[.P2]!
        gp.direction = .OUT
        gp.value = 1
        return "ok"
    }
    
    func turnOff(request: Request) throws -> String {
        var gp = gpios[.P2]!
        gp.direction = .OUT
        gp.value = 0
        return "ok"
    }
}
