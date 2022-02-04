//
//  ViewController.swift
//  SiriSearch
//
//  Created by PRAMOD S on 17/05/19.
//  Copyright © 2019 PRAMOD S. All rights reserved.
//

import UIKit
import Intents
import Photos

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        INPreferences.requestSiriAuthorization({status in
            // Handle errors here
        })
        INVocabulary.shared().setVocabularyStrings(["Search for redken products in SiriSearch ", "Show the list of redken products in SiriSearch", "List some redken products in SiriSearch", "Get the list of Redken Products in SiriSearch", "List me some Redken products in SiriSearch"], of: .photoTag)
    }


}

