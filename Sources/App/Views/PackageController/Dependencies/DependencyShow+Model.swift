import Foundation
import Vapor


extension DependencyShow {
    
    struct Model: Equatable {
        var title: String
        var dependencies: [String] = ["one", "two", "three"]
        
        internal init(title: String) {
            self.title = title
        }
        
        init?(package: Package) {
            // we consider certain attributes as essential and return nil (raising .notFound)
            guard let title = package.name() else {
                return nil
            }

            self.init(
                title: title
            )
        }
    }
    
}
