//
//  RatingLabel.swift
//  MyMovies-1
//
//  Created by mitchell hudson on 10/22/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import UIKit


protocol RatingLabelDelegate {
    func didSetRating(sender: RatingLabel)
}


@IBDesignable
class RatingLabel: UILabel {
    
    var delegate: RatingLabelDelegate? = nil
    
    @IBInspectable var maxRating: Int = 5
    
    var unit: CGFloat = 0
    var rating: Int = 0 {
        didSet {
            print(#function, "rating: \(rating)")
            var str = ""
            
            for i in 0 ... 4 {
                if i <= rating {
                    str += "★"
                } else {
                    str += "☆"
                }
            }
            
            text = str
        }
    }

    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    // MARK: Setup 
    
    func setup() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        unit = self.frame.width / CGFloat(maxRating)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        print("Begin: \(location?.x)")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        rating = Int(floor(location!.x / unit))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let delegate = delegate {
            delegate.didSetRating(sender: self)
        }
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
