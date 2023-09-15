//
//  ProfileModel.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 21/07/22.
//

import Foundation
struct Response: Decodable {
  let status: String
  let profilePicBase64: [Product]
}

struct Product: Decodable {
  let IMAGEDATA: String
}
