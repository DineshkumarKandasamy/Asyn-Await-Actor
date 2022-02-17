//
//  AsyncAwaitActorViewController.swift
//  Async&Await&Actor
//
//  Created by Dineshkumar Kandasamy on 17/02/22.
//

import UIKit

class AsyncAwaitActorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    private func makeSingleRequest() {
        
        /// Create task to access async methods
        Task {
            let albumData = try await getAlbumDetails()
            print(albumData)
        }
        
    }
    
    private func makeMultipleRequestInSeries() {
        
        /// Create task to access async methods
        Task {
            
            let albumData = try await getAlbumDetails()
            print(albumData)
            
            let photosData = try await getPhotosDetails()
            print(photosData)
            
            let usersData = try await getUsersDetails()
            print(usersData)

        }
        
    }
    
    private func makeMultipleRequestInParallel() async throws -> [String]? {
        
        do {
            
            let albumURL = URL(string: "https://jsonplaceholder.typicode.com/albums")!
            async let (data1,_) = try URLSession.shared.data(from: albumURL)
            
            let photosURL = URL(string: "https://jsonplaceholder.typicode.com/photos")!
            async let (data2,_) = try URLSession.shared.data(from: photosURL)
            
            let usersURL = URL(string:    "https://jsonplaceholder.typicode.com/users")!
            async let (data3,_) = try URLSession.shared.data(from: usersURL)
            
            let data = try await [data1, data2, data3]
            let strings = data.compactMap({ String(data: $0, encoding: .utf8)})
            return strings
            
        } catch {
            
            return nil
            
        }
        
    }
    
    
    /// Get album details in async 
    private func getAlbumDetails() async throws -> String {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        let (data,_) = try await URLSession.shared.data(from: url)
        return String(data: data, encoding: .utf8) ?? ""
        
    }
    
    /// Get photos details in async
    private func getPhotosDetails() async throws -> String {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        let (data,_) = try await URLSession.shared.data(from: url)
        return String(data: data, encoding: .utf8) ?? ""
        
    }
    
    
    /// Get users details in async
    private func getUsersDetails() async throws -> String {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let (data,_) = try await URLSession.shared.data(from: url)
        return String(data: data, encoding: .utf8) ?? ""
        
    }
    
    
    

}
