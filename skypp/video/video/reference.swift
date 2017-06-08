//
//  reference.swift
//  video
//
//  Created by leixianhua on 5/19/17.
//  Copyright © 2017 leixianhua. All rights reserved.
//

import Foundation

class Kraken: LossOfLimbDelegate {
    let tentacle = Tentacle()
    init() {

//        [weak self] in
//        self?.limbHasBeenLost()
//        tentacle.delegate = self
    }


    func limbHasBeenLost() {
        self.limbHasBeenLost()
        print("hello word")
    }
}

protocol LossOfLimbDelegate: class {
    func limbHasBeenLost()
}

class Tentacle {
    var delegate: LossOfLimbDelegate?
    func cutOffTentacle() {
        delegate?.limbHasBeenLost()
    }
}
