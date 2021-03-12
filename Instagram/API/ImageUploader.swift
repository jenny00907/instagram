//
//  ImageUploader.swift
//  Instagram
//
//  Created by Jenny Woorim Lee on 2021/03/11.
//


import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { (metadata, err) in
            if let err = err {
                print("DEBUG: Failed to upload image \(err.localizedDescription)")
                return
            }
            ref.downloadURL { (url, error) in
                guard let imageurl = url?.absoluteString else { return }
                completion(imageurl)
            }
        }
    }
}
