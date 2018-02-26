//
//  ViewController.swift
//  Gobang
//
//  Created by nietao on 2018/2/24.
//  Copyright © 2018年 nietao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    let size = UIScreen.main.bounds.size.width/10;
    let bounds = UIScreen.main.bounds;
    let gird:Int = 10; //确定每行10个格子
    let cellIndentify = "GobangCell";
    var dic = Dictionary<String, GoBangModel>();
    var girdView:UICollectionView?;
    var currentUser:GIRDSTATES = .black;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white;
        
        //数据层
        //方法：棋盘内每一个点看作一个对象
        //x y 作为一个key 对应一个model
        for x in 0...gird{
            for y in 0...gird{
                let model = GoBangModel.init();
                let str = String.init(x) + String.init(y);
                dic[str] = model;
            }
        }
        
        //UI层
        let layout = UICollectionViewFlowLayout.init();
        layout.itemSize = CGSize.init(width: size, height: size);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置section的编距
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout);
        collectionView.backgroundColor = UIColor.white;
        self.view.addSubview(collectionView);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.register(GobangCell.self, forCellWithReuseIdentifier: cellIndentify);
        girdView = collectionView;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - 计算是否五子成立？
    func winner(_ x:Int,_ y:Int){
        //五子棋4种情况下可以成功
        //1.横
        var continuity = 0; //连续性能 5次算赢
        for t in x-4...x+4 {
            let str = String.init(t) + String.init(y);
            let model:GoBangModel? = dic[str];
            if (model != nil && model?.states == currentUser){
                continuity += 1; //必须满足，这个点存在，并且状态跟下棋的人一样才行
                if(continuity == 5){
                    winAction();
                }
            } else {
                continuity = 0;
            }
        }
        //2.竖
        for t in y-4...y+4 {
            let str = String.init(x) + String.init(t);
            let model:GoBangModel? = dic[str];
            if (model != nil && model?.states == currentUser){
                continuity += 1; //必须满足，这个点存在，并且状态跟下棋的人一样才行
                if(continuity == 5){
                    winAction();
                }
            } else {
                continuity = 0;
            }
        }
        //3.斜 \ x越来越大，y越来越大
        for t in -4 ... +4 {
            let str = String.init(x+t) + String.init(y+t);
            let model:GoBangModel? = dic[str];
            if (model != nil && model?.states == currentUser){
                continuity += 1; //必须满足，这个点存在，并且状态跟下棋的人一样才行
                if(continuity == 5){
                    winAction();
                }
            } else {
                continuity = 0;
            }
        }
        //4.斜 / x越大y越小，x越小y越大
        for t in -4 ... +4 {
            let str = String.init(x+t) + String.init(y-t);
            let model:GoBangModel? = dic[str];
            if (model != nil && model?.states == currentUser){
                continuity += 1; //必须满足，这个点存在，并且状态跟下棋的人一样才行
                if(continuity == 5){
                    winAction();
                }
            } else {
                continuity = 0;
            }
        }
    }
    
    func winAction(){
        var str = "白棋赢"
        if currentUser == .black {
            str = "黑棋赢了";
        }
        let alertController = UIAlertController(title: str,
                                                message:nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gird;
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gird;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GobangCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentify, for: indexPath) as! GobangCell;
        let str = String.init(indexPath.row) + String.init(indexPath.section);
        let model:GoBangModel = dic[str]!;
        cell.isUserInteractionEnabled = false;
        switch model.states {
        case .black:
            cell.piece.backgroundColor = UIColor.black;
        case .white:
            cell.piece.backgroundColor = UIColor.orange;
        default:
            cell.piece.backgroundColor = UIColor.clear;
            cell.isUserInteractionEnabled = true;
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let str = String.init(indexPath.row) + String.init(indexPath.section);
        let model:GoBangModel = dic[str]!;
        model.states = currentUser;
        collectionView.reloadData();
        
        winner(indexPath.row, indexPath.section);
        if currentUser == .black {
            currentUser = .white;
        } else {
            currentUser = .black;
        }
    }

}

