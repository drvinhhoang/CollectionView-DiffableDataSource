
import Foundation

struct Section: Decodable, Hashable {
  let title: String
  let videos: [Video]
  let identifier = UUID().uuidString
   
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Section, rhs: Section) -> Bool {
        return lhs.title == rhs.title
    }
    
}

