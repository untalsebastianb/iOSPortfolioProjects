import Vapor

struct VideoCourse: Content {
    let name: String
    let language: String
    let version: Double
}

func routes(_ app: Application) throws {
    
    app.post("upload") { req -> HTTPResponseStatus in
        let course = try req.content.decode(VideoCourse.self)
        print("Course name: \(course.name)")
        print("Course language: \(course.language)")
        print("Course version: \(course.version)")
        
        return .ok
    }
    
}
