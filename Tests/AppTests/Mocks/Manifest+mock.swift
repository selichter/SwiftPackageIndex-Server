@testable import App


extension Manifest {
    static var mock: Self {
        .init(name: "MockManifest", products: [.mock], dependencies: [], targets: [])
    }
}

extension Manifest.Product {
    static var mock: Self {
        .init(name: "MockProduct", type: .library)
    }
}
