//
//  API.swift
//  Marvel
//
//  Created by Jaber Vieira Da Silva Shamali on 02/03/21.
//

import Foundation
import Alamofire

class API{
    
    var dataCharacaters = Entry.self
    
    func requestData(from: Int?, completion: @escaping (_ result: Entry) -> ()){
            
        var dados = [Entry]()

            var parameters:Parameters = [String : Any]()
            parameters["ts"] = "1"
            parameters["apikey"] = "a483c4863e16947858e3015be24d081f"
            parameters["hash"] = "d209e8995ad3ec568be381ca92591ba2"
            parameters["limit"] = "10"
        
            if from != nil{
                parameters["offset"] = "\(10)"
            } else {
                parameters["offset"] = "0"
            }
            

            let url = "https://gateway.marvel.com/v1/public/characters"

        AF.request(url, method: .get, parameters: parameters , encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success( _):
                    
                    do {
                        let decoder = JSONDecoder()
                        let allData = try decoder.decode(Entry.self, from: response.data!)
                        dados.append(allData)
                        completion(allData)

                        
                        
                    } catch {
                        print(error)
                    }
                    
                    
                case .failure(let error):
                    print ("error: \(error)")
                }
            }
    }
}
