//
//  DataSource.swift
//  RayWenderlichLibrary
//
//  Created by VINH HOANG on 01/12/2021.
//  Copyright © 2021 Ray Wenderlich. All rights reserved.
//

import Foundation


class DataSource {
    
    static let shared = DataSource()
    
    var tutorials: [TutorialCollection]
 
    private let decoder = PropertyListDecoder()
    
   private init() {
        guard let url = Bundle.main.url(forResource: "Tutorials", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
                let tutorials = try? decoder.decode([TutorialCollection].self, from: data)
        else {
            self.tutorials = []
            return
        }
      
        self.tutorials = tutorials
        
    }
    
}
