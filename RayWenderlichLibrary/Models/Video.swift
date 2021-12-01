

import Foundation

struct Video: Decodable {
  let url: String
  let title: String
}


extension Video: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
    
}
