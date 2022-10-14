//
//  Recorder+Firebase.swift
//  Basirah
//
//  Created by Nadia Seleem on 4/20/21.
//  Copyright © 2021 Nadia seleem. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

extension RecorderVC
{
    
    
    func uploadAudioFile(with request: Request,fileURL url: URL,_ successHandler:@escaping ()->(),_ failHandler: @escaping (_ msg: String)->(),progess: @escaping (_ progress: String)->())
    {
        
        let storage =  Storage.storage()
        let storageRef = storage.reference()
        
         var fileRef  = "/" + request.requestOwner
             fileRef += "/" + request.requestTimestamp
             fileRef += "/" + "audio.m4a"
        
        let audioFileRef = storageRef.child(fileRef)
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = audioFileRef.putFile(from: url, metadata: nil)
        {
            metadata, error in
            if error != nil {
                failHandler("حدث خطأ في ارسال المقطع الصوتي ")
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL()
                
                let ref = Database.database().reference()
                guard let userID = Auth.auth().currentUser?.uid else
                {
                    failHandler("حدث خطأ في ارسال المقطع الصوتي ")
                    return
                    
                }
           
                let responseDict =
                    [
                        ResponseKeys.volunteerName : currentUser()?.name ?? "",
                        ResponseKeys.date : Date().description,
                        ResponseKeys.url : downloadURL?.absoluteString ?? "",
                        ResponseKeys.volunteer : userID
                    ]
                
               
            ref.child("requests").child(request.requestOwner).child(request.requestTimestamp).child("response").setValue(responseDict)
                
                
            }
        }
        
        uploadTask.resume()
        
        uploadTask.observe(.progress)
        {
            snapshot in
            // Upload reported progress
            guard let progress = snapshot.progress else {return}
            if progress.totalUnitCount != 0
            {
            let percentComplete: Int = Int(100.0 * Double(progress.completedUnitCount)
                / Double(progress.totalUnitCount))
                progess("\(percentComplete)")

            }
            
        }
        
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            successHandler()
            uploadTask.removeAllObservers()
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    failHandler("المقطع الصوتي غير موجود")
                case .unauthorized:
                    // User doesn't have permission to access file
                    failHandler("ليس لديك صلاحية برفع هذا الملف")
                case .cancelled:
                    // User canceled the upload
                    failHandler("تم الغاء رفع المقطع الصوتي")

                    
                    /* ... */
                    
                case .unknown:
                    failHandler("تم الغاء رفع المقطع الصوتي")

                default:
                   uploadTask.resume()
                }
            }
        }
        
    }
    
    
}
