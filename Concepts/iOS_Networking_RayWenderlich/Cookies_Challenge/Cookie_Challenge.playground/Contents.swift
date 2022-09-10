import UIKit
import Foundation

guard let url = URL(string: "https://www.youtube.com") else {
    fatalError()
}

let _ = URLSession.shared.dataTask(with: url) { _, response, _ in
    if let response = response as? HTTPURLResponse,
       let fields = response.allHeaderFields as? [String: String]  {
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
        for cookie in cookies {
            print("Cookie 🍪 Name:\(cookie.name)")
            print("Cookie 🍪 Value:\(cookie.value)")
        }
        
//        all the cookies receive from the different URLs
        if let cookieJar = HTTPCookieStorage.shared.cookies {
            for cookies in cookieJar {
                print("CookieJar Name:\(cookies.name)")
                print("CookieJar Value:\(cookies.value)")
            }
        }
        
    }
    
    
}.resume()
