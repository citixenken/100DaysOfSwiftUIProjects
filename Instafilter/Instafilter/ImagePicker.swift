//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Ken Muyesu on 23/05/2022.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PHPickerViewController {
        //pick your choice
        var config = PHPickerConfiguration()
        //what do you want to load... Images? Videos? LivePhotos?
        config.filter = .images
        
        //load choice into viewcontroller
        let picker = PHPickerViewController(configuration: config)
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        //leave it empty!!!
    }
}
