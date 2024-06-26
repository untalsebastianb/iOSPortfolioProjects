///// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

class SongDownload: NSObject, ObservableObject {
    
    var downloadTask: URLSessionDownloadTask?
    var downloadURL: URL?
    var resumeData: Data?
    
    @Published var downloadLocation: URL?
    @Published var downloadedAmount: Float = 0
    
    @Published var state: DownloadState = .waiting
    
    enum DownloadState {
      case waiting
      case downloading
      case paused
      case finished
    }
    
    lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    func fetchSongAtUrl(_ item: URL) {
        downloadURL = item
        downloadTask = urlSession.downloadTask(with: item)
        downloadTask?.resume()
        state = .downloading
    }
    
    func cancel() {
      state = .waiting
      downloadTask?.cancel()
      DispatchQueue.main.async {
        self.downloadedAmount = 0
      }
    }
    
    func pause() {
      downloadTask?.cancel(byProducingResumeData: { data in
        DispatchQueue.main.async {
          self.resumeData = data
          self.state = .paused
        }
      })
    }
    
    func resume() {
      guard let resumeData = resumeData else {
        return
      }
      downloadTask = self.urlSession.downloadTask(withResumeData: resumeData)
      downloadTask?.resume()
      state = .downloading
    }
}

extension SongDownload: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        DispatchQueue.main.async {
            self.downloadedAmount = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            print(self.downloadedAmount)
        }
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        print("finished")
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        let fileManager = FileManager.default
        guard let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first,
              let lastPathComponent = downloadURL?.lastPathComponent else {
            fatalError()
        }
        
        let destinationUrl = documentsPath.appendingPathComponent(lastPathComponent)
        do {
            if fileManager.fileExists(atPath: destinationUrl.path) {
                try fileManager.removeItem(at: destinationUrl)
            }
            try fileManager.copyItem(at: location, to: destinationUrl)
            DispatchQueue.main.async {
                self.downloadLocation = destinationUrl
                self.state = .finished
            }
        } catch {
            print(error)
        }
        
    }
    
    
}
