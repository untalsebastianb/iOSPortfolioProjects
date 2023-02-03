import UIKit

//Adapt a third party authenticator service with an app internal authenticator service
public class GoogleAuthenticator {
  
  public func login(email: String,
                    password: String,
                    completion: @escaping (GoogleUser?, Error?) -> Void) {
    // Make networking calls, which return a special "token"
    let token = "special-token-value"
    let user = GoogleUser(email: email, password: password, token: token)
    completion(user, nil)
  }
}

public struct GoogleUser {
  public var email: String
  public var password: String
  public var token: String
}

// also has a login option but is different from google authenticator
public protocol AuthenticationService {
    func login(email: String,
               password: String,
               success: @escaping (User, Token) -> Void,
               failure: @escaping (Error?) -> Void)
}

public struct User {
  public let email: String
  public let password: String
}

public struct Token {
  public let value: String
}

// 2 options, create an extension of google authenticator or create an adapter class
public class GoogleAuthenticatorAdapter: AuthenticationService {
  
  private var authenticator = GoogleAuthenticator()
  
  public func login(email: String,
                    password: String,
                    success: @escaping (User, Token) -> Void,
                    failure: @escaping (Error?) -> Void) {
//       calling the google authenticator and using the success and failure closures, This is the ADAPTER!!
    authenticator.login(email: email, password: password) { (googleUser, error) in
      guard let googleUser = googleUser else {
        failure(error)
        return
      }
      let user = User(email: email, password: password)
      let token = Token(value: googleUser.token)
      success(user, token)
    }
  }
}


//Try out!
let authService: AuthenticationService = GoogleAuthenticatorAdapter()
authService.login(email: "example.com", password: "password") { user, token in
    print("Auth succeded: \(user.email), \(token.value)")
} failure: { error in
    if let error = error {
        print("auth failed: \(error)")
    } else {
        print("auth failed with no error")
    }
}

