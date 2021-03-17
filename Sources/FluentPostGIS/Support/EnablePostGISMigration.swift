import Foundation
import FluentKit
import SQLKit
import PostgresNIO

public struct EnablePostGISMigration: Migration {
    
    public init() {}
    
    enum EnablePostGISMigrationError: Error {
        case notSqlDatabase
    }
    
    //public init() { } causing error

    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        guard let db = database as? SQLDatabase else {
            return database.eventLoop.makeFailedFuture(EnablePostGISMigrationError.notSqlDatabase)
        }
        return db.raw("CREATE EXTENSION IF NOT EXISTS \"postgis\"").run()
    }

    public func revert(on database: Database) -> EventLoopFuture<Void> {
        guard let db = database as? SQLDatabase else {
            return database.eventLoop.makeFailedFuture(EnablePostGISMigrationError.notSqlDatabase)
        }
        return db.raw("DROP EXTENSION IF EXISTS \"postgis\"").run()
    }
}

public var FluentPostGISSrid: UInt = 4326
