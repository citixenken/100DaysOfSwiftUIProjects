//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Ken Muyesu on 24/05/2022.
//

import UIKit

//handles writing image to the photo library

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    //call completion handler when done
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
