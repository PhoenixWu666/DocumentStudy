//
//  StudyDataModel.swift
//  DocumentStudy
//
//  Created by Phoenix Wu on H30/06/21.
//  Copyright © 平成30年 Phoenix Wu. All rights reserved.
//

import Foundation

struct StudyDataModel: Codable {
    
    var bgImgData: Data?
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init(data: Data) {
        bgImgData = data
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(StudyDataModel.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
}
