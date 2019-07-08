//
//  Helper.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/08.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

extension Bool {
    var int: Int { return self == true ? 1 : 0 }
}

func usleep(sec: TimeInterval) {
    usleep(useconds_t(round(sec * 1000000)))
}
