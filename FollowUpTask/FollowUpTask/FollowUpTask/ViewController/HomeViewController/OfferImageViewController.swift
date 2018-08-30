//
//  OfferImageViewController.swift
//  FollowUpTask
//
//  Created by Narayanasamy, Vignesh on 2/18/18.
//  Copyright © 2018 Narayanasamy, Vignesh. All rights reserved.
//

import UIKit

class OfferImageViewController: BaseViewController {
    
    //  MARK:-  Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    //  MARK:-  Properties
    fileprivate var image: UIImage?
    fileprivate(set) var index = 0
    
    //  MARK:-  View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//  MARK:-  New Instance
extension OfferImageViewController {
    static func newInstance() -> OfferImageViewController {
        let offerImageViewController = Storyboard.main
            .instantiateViewController(withIdentifier: String
                .init(describing: OfferImageViewController.self)) as! OfferImageViewController
        return offerImageViewController
    }
}

//  MARK:-  Custom setter
extension OfferImageViewController {
    func setImage(_ imagePath: String, at index: Int) {
        let image = UIImage.init(named: imagePath)
        self.image = image
        self.index = index
    }
}
