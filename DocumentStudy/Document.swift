//
//  Document.swift
//  DocumentStudy
//
//  Created by Phoenix Wu on H30/06/21.
//  Copyright © 平成30年 Phoenix Wu. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
}

