import Foundation

struct Urls {
    
    static let base = "https://itunes.apple.com/search?"
}

struct parameterKeys {
    
    static let term = "term"
    static let media = "media"
    
}

struct parameterValues {
    
    static var search: String?
}

struct Scope {
    
    static var scope = "all"
}

struct UserDefaultsKeys {
    static let id = "id"
     static let isLoggedIn = "isLoggedIn"
}

struct VCs {
    static let signUpVC = "SignUpVC"
    static let signInVC = "SignInVC"
    static let profileVC = "ProfileVC"
    static let mediaListVC = "MediaListVC"
    
}

struct Storyboards {
    static let main = "Main"
}
