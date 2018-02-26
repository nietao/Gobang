//
//  GoBangModel.swift
//  Gobang
//
//  Created by nietao on 2018/2/24.
//  Copyright © 2018年 nietao. All rights reserved.
//

import UIKit

enum GIRDSTATES {
    case clear
    case black
    case white
}

class GoBangModel: NSObject {
  
    var states:GIRDSTATES = .clear;
    
    override init() {
        
    }
}
