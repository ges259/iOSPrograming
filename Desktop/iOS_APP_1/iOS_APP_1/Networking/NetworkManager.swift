//
//  NetworkManager.swift
//  iOS_APP_1
//
//  Created by 계은성 on 2023/06/07.
//

import Foundation


enum NetworkError: Error {
    case networkError
    case dataError
    case parseError
}






final class NetworkManager {
    
    
    // 싱글톤 생성
    static let shared = NetworkManager()
    private init() {}
    
    

    
    // typealias
    typealias NetworkCompletion = (Result<[Music], NetworkError>) -> Void
    
    
    // fetchMusic
    func fetchMusic(term: String, completion: @escaping NetworkCompletion) {
        print(#function)
        let urlStirng = "https://itunes.apple.com/search?media=music&term=\(term)"
        
        
        
        
        
//        let urlStirng = "https://itunes.apple.com/search?term=podcast&genreId=1406&limit=200"
        
        performRequest(urlString: urlStirng) { result in
            completion(result)
        }
    }
    
    
    
    
    // perfromRequest
    private func performRequest(urlString: String, completion: @escaping NetworkCompletion) {
        print(#function)
        guard let url = URL(string: urlString) else { return }
        print("1")
        let session = URLSession(configuration: .default)
        print("2")
        
        session.dataTask(with: url) { data, response, error in
            print("3")
            if error != nil {
                print("4")
                completion(.failure(.networkError))
                return
            }
            guard let safeData = data else {
                print("5")
                completion(.failure(.dataError))
                return
            }
            
            
            
            if let music = self.parseJSON(musicData: safeData) {
                print("parse 성공")
                completion(.success(music))
                return
            } else {
                print("parse 실패")
                completion(.failure(.parseError))
                return
            }
        }.resume()
    }
    
    // parseJSON
    private func parseJSON(musicData: Data) -> [Music]? {
        print(#function)
        do {
            let musicData = try JSONDecoder().decode(MusicData.self, from: musicData)
            return musicData.results
        } catch {
            return nil
        }
    }
}
