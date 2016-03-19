//
//  MarvelProductionInfo.swift
//  AwesomeHeroes
//
//  Created by Alberto Moral on 19/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation


/**  
    Marvel info to retrieve information with their API. Normally, in other enviorentments like TEST, DEV, etc. I put this information also in the .plist. In production is mandatory to protect this information with pods like: https://github.com/orta/cocoapods-keys
 
    - These info is used to create a md5 hash with the timestamp. md5(ts+privateKey+publicKey)
**/
enum Marvel: String {    
    case publicKey  = "0581b50024cada264dd0343e6e37a247"
    case privateKey = "c80292170f68e5bf415420297bbffa33d8c50214"
}


