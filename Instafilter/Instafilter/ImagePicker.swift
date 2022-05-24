//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Ken Muyesu on 23/05/2022.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        //pick your choice
        var config = PHPickerConfiguration()
        //what do you want to load... Images? Videos? LivePhotos?
        config.filter = .images
        
        //load choice into viewcontroller
        let picker = PHPickerViewController(configuration: config)
        
        //use coordinator as our delegate for phpicker
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        //leave it empty!!!
    }
    
    //communicates changes from viewcontroller to other instances of swiftui
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
