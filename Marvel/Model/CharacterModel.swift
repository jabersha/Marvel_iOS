//
//  CharacterModel.swift
//  Marvel
//
//  Created by Jaber Vieira Da Silva Shamali on 02/03/21.
//

import Foundation

struct Entry: Codable {
    var code: Int
    var status: String
    var data : data
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
        case data = "data"
    }
    
}

struct data:Codable {
    var limit:Int
    var total:Int
    var result:[Characters]
    
    enum CodingKeys: String, CodingKey {
        case limit = "limit"
        case total = "total"
        case result = "results"
    }
}


struct Characters:Codable {
    var id:Int
    var name:String
    var description:String
    var thumb: Thumbnail
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case thumb = "thumbnail"
    }
    
}

struct Thumbnail:Codable {
    var path:String
    var extensionThumb:String
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case extensionThumb = "extension"
    }
}
