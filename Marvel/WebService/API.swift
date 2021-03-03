//
//  API.swift
//  Marvel
//
//  Created by Jaber Vieira Da Silva Shamali on 02/03/21.
//

import Foundation
import Alamofire

class API{
    
    
    func requestData(from:Int?){

            var parameters:Parameters = [String : Any]()
            parameters["ts"] = "1"
            parameters["apikey"] = "a483c4863e16947858e3015be24d081f"
            parameters["hash"] = "d209e8995ad3ec568be381ca92591ba2"
            parameters["limit"] = "10"
        
            if from != nil{
                parameters["offset"] = "\(10+from!)"
            } else {
                parameters["offset"] = "10"
            }
            

            let url = "https://gateway.marvel.com/v1/public/characters"

        AF.request(url, method: .get, parameters: parameters , encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    print ("return as JSON using swiftyJson is: \(value)")
                    
                    do {
                        let decoder = JSONDecoder()
                        let teste = try decoder.decode(Entry.self, from: response.data!)
                        print(teste.data.result[1].name)
                        
                    } catch {
                        print(error)
                    }
                    
                    
                case .failure(let error):
                    print ("error: \(error)")
                }
            }
    
    }
}
