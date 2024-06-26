//
//  SongDownload.swift
//  HalfTunes
//
//  Created by Sebastian on 17/08/22.
//  Copyright © 2022 raywenderlich. All rights reserved.
//

import Foundation
import SwiftUI

class SongDownload: NSObject, ObservableObject {
    var downloadTask: URLSessionDownloadTask?
    var downloadUrl: URL?
    
    @Published var downloadLocation: URL?
    @Published var downloadedAmount: Float = 0
    @Published var isDownloading = false
    
    lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    func fetchSongAtURL(_ item: URL) {
        downloadUrl = item
        downloadTask = urlSession.downloadTask(with: item)
        downloadTask?.resume()
        isDownloading = true
    }
}

extension SongDownload: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        DispatchQueue.main.async {
            self.downloadedAmount = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            print(self.downloadedAmount)
        }
        
    }
    
    // to handle the error
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        DispatchQueue.main.async {
            self.isDownloading = false
        }
        print("Finished")
    }
    
    // donwloaded data will be store in a file
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let fileManager = FileManager.default
        guard
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first,
            let lastPathComponent = downloadUrl?.lastPathComponent else {
            fatalError()
        }
        let destinationURL = documentsPath.appendingPathComponent(lastPathComponent)
        do {
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }
            try fileManager.copyItem(at: location, to: destinationURL)
            DispatchQueue.main.async {
                self.downloadLocation = destinationURL
            }
        } catch {
            print(error)
        }
    }
    
    
}

