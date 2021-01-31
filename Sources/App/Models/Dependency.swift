import Fluent
import Vapor


final class Dependency: Model, Content {
    static let schema = "dependencies"

    typealias Id = UUID

    // managed fields

    @ID(key: .id)
    var id: Id?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    // reference fields
    
    @OptionalParent(key: "package_id")
    var package: Package?
    
    // data fields

    @Field(key: "type")
    var type: `Type`
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "used_by")
    var usedBy: [Package.Id]

    // initializers

    init() { }

    init(id: UUID? = nil,
         package: Package?,
         type: `Type`,
         name: String) throws {
        self.id = id
        self.type = type
        self.name = name
        if let package = package {
            self.$package.id = try package.requireID()
        }
    }
}

extension Dependency {
    enum `Type`: String, Codable {
        case framework
        case package
    }
}

extension Dependency {
    
    static func query(database: Database, url: URL, name: String) -> EventLoopFuture<Dependency> {
        let trunk = url.absoluteString
            .droppingGithubComPrefix
            .droppingGitExtension
        
        let components = trunk.components(separatedBy: "/")
        
        return Dependency.query(on: database)
            .with(\.$package)
            .filter(
                DatabaseQuery.Field.path(Package.path(for: \.$url), schema: Package.schema),
                DatabaseQuery.Filter.Method.custom("ilike"),
                DatabaseQuery.Value.bind(trunk)
            )
            .first()
            .flatMap { value -> EventLoopFuture<Dependency> in
                guard let dependency = value else {
                    return Package.query(on: database, owner: components[0], repository: components[1]).flatMapThrowing {
                        return try Dependency(package: $0, type: .package, name: name)
                    }
                }
                
                return database.eventLoop.future(dependency)
            }
    }
    
}
