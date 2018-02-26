//
//  GobangCell.swift
//  Gobang
//
//  Created by nietao on 2018/2/24.
//  Copyright © 2018年 nietao. All rights reserved.
//

import UIKit

class GobangCell: UICollectionViewCell {
    let piece = UIView.init();
    
    let size = UIScreen.main.bounds.size.width/10;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white
        piece.frame = self.bounds;
        piece.layer.masksToBounds = true;
        piece.layer.cornerRadius = size/2;
        piece.backgroundColor = UIColor.clear;
        self.addSubview(piece);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        let width = self.bounds.size.width;
        let height = self.bounds.size.height;
        
        //画一个+ 字
        let context = UIGraphicsGetCurrentContext()
        //竖直线
        context?.move(to: CGPoint.init(x: width/2, y: 0));
        context?.addLine(to: CGPoint.init(x: width/2, y: height));
        //水平线
        context?.move(to: CGPoint.init(x: 0, y: height/2));
        context?.addLine(to: CGPoint.init(x: width, y: height/2));
        context?.setStrokeColor(UIColor.red.cgColor);
        context?.drawPath(using: .stroke)
        

    }
    

    


}
