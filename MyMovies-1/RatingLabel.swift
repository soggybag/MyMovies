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
            var str = ""
            
            for i in 1...5 {
                if rating >= i {
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
    
    
    
    func setRatingFor(location: CGPoint) {
        rating = Int(floor(location.x / unit)) + 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        unit = self.frame.width / CGFloat(maxRating)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        setRatingFor(location: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        setRatingFor(location: location)
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
