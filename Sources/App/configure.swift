import Vapor
import Fluent
import FluentSQLiteDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.sqlite(.file("bigtable.sqlite")), as: .sqlite)
    // register routes
    
    app.migrations.add(CreateStationsTable())
    
    try routes(app)
}
