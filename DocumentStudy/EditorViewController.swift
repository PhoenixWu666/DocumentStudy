//
//  EditorViewController.swift
//  DocumentStudy
//
//  Created by Phoenix Wu on H30/06/21.
//  Copyright © 平成30年 Phoenix Wu. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {
    
    var document: StudyDocument?
    
    var dataModel: StudyDataModel? {
        get {
            if let img = bgImg, let data = UIImagePNGRepresentation(img) {
                return StudyDataModel(data: data)
            } else {
                return nil
            }
        }
        
        set {
            if let model = newValue, let imgData = model.bgImgData {
                bgImg = UIImage(data: imgData)
            }
        }
    }
    
    private var bgImg: UIImage? {
        didSet {
            if bgImgView != nil, bgImg != nil {
                bgImgView.image = bgImg
                documentChanged()
            }
        }
    }
    
    @IBOutlet weak var bgImgView: UIImageView! {
        didSet {
            if bgImgView != nil {
                bgImgView.isUserInteractionEnabled = true
                bgImgView.addInteraction(UIDropInteraction(delegate: self))
            }
        }
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        if document?.dataModel != nil {
            document?.thumbnail = bgImg
        }
        
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    
    func documentChanged() {
        document?.dataModel = dataModel
        
        if document?.dataModel != nil {
            document?.updateChangeCount(.done)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        document?.open(completionHandler: { (isSuccess) in
            if isSuccess {
                self.title = self.document?.localizedName
                self.dataModel = self.document?.dataModel
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension EditorViewController: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self) && session.canLoadObjects(ofClass: NSURL.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self, completion: {
            if let img = $0.first as? UIImage {
                DispatchQueue.main.async {
                    self.bgImg = img
                }
            }
        })
        
        session.loadObjects(ofClass: NSURL.self, completion: {
            if let url = $0.first as? URL, let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.bgImg = UIImage(data: data)
                }
            }
        })
    }
    
}










