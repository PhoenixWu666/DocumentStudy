//
//  Document.swift
//  DocumentStudy
//
//  Created by Phoenix Wu on H30/06/21.
//  Copyright © 平成30年 Phoenix Wu. All rights reserved.
//

import UIKit

class StudyDocument: UIDocument {
    
    var dataModel: StudyDataModel?
    
    var thumbnail: UIImage?
    
    // set thumbnail
    override func fileAttributesToWrite(to url: URL, for saveOperation: UIDocumentSaveOperation) throws -> [AnyHashable : Any] {
        var attributes = try super.fileAttributesToWrite(to: url, for: saveOperation)
        
        if let tn = thumbnail {
            attributes[URLResourceKey.thumbnailDictionaryKey] = [URLThumbnailDictionaryItem.NSThumbnail1024x1024SizeKey : tn]
        }
        
        return attributes
    }
    
    // for saving data
    override func contents(forType typeName: String) throws -> Any {
        return dataModel?.json ?? Data()
    }
    
    // for loading data
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let data = contents as? Data {
            dataModel = StudyDataModel(json: data)
        }
    }
}

