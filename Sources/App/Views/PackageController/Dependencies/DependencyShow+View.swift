import Ink
import Vapor
import Plot

enum DependencyShow {
    
    class View: PublicPage {
        
        let model: Model

        init(path: String, model: Model) {
            self.model = model
            super.init(path: path)
        }
        
        override func pageTitle() -> String? {
            model.title
        }
        
        override func pageDescription() -> String? {
            return "\(model.title) on the Swift Package Index"
        }
        
        override func bodyClass() -> String? {
            "package"
        }
        
        override func content() -> Node<HTML.BodyContext> {
            .group(
                .h2(.text(model.title))
            )
        }
        
    }
}
