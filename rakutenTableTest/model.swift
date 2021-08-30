//
//  model.swift
//  rakutenTableTest
//
//  Created by 笹倉一也 on 2021/08/28.
//

import Foundation


struct SerchBookKList: Codable {
    
    var count: Int
    var Items: [ItemDic]?



struct ItemDic : Codable{
    var Item : ItemInfo?
//    var count: Int


struct ItemInfo: Codable {
    var title :String
    var smallImageUrl :String
    var salesDate :String

}

}
    
    
    
}
