
import UIKit

class Tutorial: Decodable {
  let title: String
  let thumbnail: String
  let artworkColor: String
  var isQueued: Bool
  let publishDate: Date
  let content: [Section]
  var updateCount: Int
  
  init(title: String, thumbnail: String, artworkColor: String, isQueued: Bool, publishDate: Date, content: [Section], updateCount: Int) {
    self.title = title
    self.thumbnail = thumbnail
    self.artworkColor = artworkColor
    self.isQueued = isQueued
    self.publishDate = publishDate
    self.content = content
    self.updateCount = updateCount
  }
}

extension Tutorial {
  var image: UIImage? {
    return UIImage(named: thumbnail)
  }
  
  var imageBackgroundColor: UIColor? {
    return UIColor(hexString: artworkColor)
  }
  
  func formattedDate(using formatter: DateFormatter) -> String? {
    return formatter.string(from: publishDate)
  }
}
