//
//  File.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 06/06/22.
//

import Foundation
//
//  ManagingSharedData.swift
//  AIIMS Bhubaneswar Swasthya
//
//  Created by sudeep rai on 31/08/20.
//  Copyright © 2020 sudeep rai. All rights reserved.
//

import UIKit

extension UserDefaults {

   func save<T:Encodable>(customObject object: T, inKey key: String) {
       let encoder = JSONEncoder()
       if let encoded = try? encoder.encode(object) {
           self.set(encoded, forKey: key)
       }
   }

   func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
       if let data = self.data(forKey: key) {
           let decoder = JSONDecoder()
           if let object = try? decoder.decode(type, from: data) {
               return object
           }else {
               print("Couldnt decode object")
               return nil
           }
       }else {
           print("Couldnt find key")
           return nil
       }
   }

}
