//
//  Logging.swift
//  SaveMyStuff
//
//  Created by Andreas Gjaerum on 29/09/2023.
//

import Foundation

class LoggingObservable: ObservableObject {
    
    // MARK: - Private variables
    private let name: String = "log"
    private var file: URL? // = URL(fileURLWithPath: "")
    private let dateFormatter = DateFormatter()
    private var logStrings = [String]()
    
    init() {
        do {
            let appDocumentsURL = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            print("Starting Logging")
            dateFormatter.dateFormat = "yyyy.MM.dd_HH.mm.ss"
            
            let recordingDate = self.dateFormatter.string(from: Date())

            self.file = appDocumentsURL.appendingPathComponent("\(self.name)-\(recordingDate).txt")
            
            print("Saving to: \(self.file?.absoluteString ?? "nothing...")")
            
            var files = [URL]()
            
            if let enumerator = FileManager.default.enumerator(at: appDocumentsURL, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
                for case let fileURL as URL in enumerator {
                    do {
                        let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                        if fileAttributes.isRegularFile! {
                            files.append(fileURL)
                        }
                    } catch { print(error, fileURL) }
                }
                
                print("Got number of files: \(files.count)")
                print(files)
                
                /*
                 Testing once there are files saved
                 */
//                let firstFile = try Data(contentsOf: files.first!)
//                if let string = String(data: firstFile, encoding: .utf8) {
//                    print("File contents: \n\(string)")
//                }
            }
            
//            let moreFiles = try FileManager.default.contentsOfDirectory(atPath: appDocumentsURL.absoluteString)
//            
//            for file in moreFiles {
//                print("\(file)")
//            }
        } catch {
            print("URL failed")
        }
    }
    
    func appendLog(_ log: String) {
        print(log)
        logStrings.append(log)
    }
    
    func saveLogs() {
        guard let localFile = self.file else {
            print("❗ Everything failed....")
            return
        }
        
        logStrings.append("---------------------   saving   ----------------------------")
        let log = logStrings.joined(separator: "\n")
        let logData = Data(log.utf8)
        
        do {
//            try log.write(to: localFile, atomically: true, encoding: .utf8)
            try logData.write(to: localFile, options: .atomic)
        } catch {
            print("Log error: \(error.localizedDescription)")
        }
        
        logStrings = []
        print("Saved")
    }
}
