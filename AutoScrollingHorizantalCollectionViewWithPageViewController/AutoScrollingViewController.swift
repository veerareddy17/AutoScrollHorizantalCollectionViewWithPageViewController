//
//  AutoScrollingViewController.swift
//  ScruptiousFriuts
//
//  Created by Daemon on 12/08/17.
//  Copyright © 2017 veareddy. All rights reserved.
//

import UIKit

class AutoScrollingViewController: UIViewController {
    //Mark:- IBOutlets
    @IBOutlet weak var scrollPageControll: UIPageControl!
    @IBOutlet weak var imageCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCV.delegate = self
        imageCV.dataSource = self
         Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }
   
   //Mark:- Private Function
    func moveToNextPage (){
        
        let imageCVWidth:CGFloat = self.imageCV.frame.width
        let maxWidth:CGFloat = imageCVWidth * 10
        let contentOffset:CGFloat = self.imageCV.contentOffset.x
        
        var slideToX = contentOffset + imageCVWidth
        
        if  contentOffset + imageCVWidth == maxWidth
        {
            slideToX = 0
        }
        self.imageCV.scrollRectToVisible(CGRect(x:slideToX, y:0, width:imageCVWidth, height:self.imageCV.frame.height), animated: true)
    }
}
//Mark:- Extension Of ViewController
extension AutoScrollingViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    //Mark:- DataSource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //Mark:-
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCV.dequeueReusableCell(withReuseIdentifier: "ImageCVC", for: indexPath) as! ImageCVC
        cell.modelView.layer.borderWidth = 2.0
        cell.modelView.layer.cornerRadius = 2.0
        cell.modelView.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: imageCV.frame.height)
    }
    
    //Mark:- ScrollViewDelegate Methode
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = self.imageCV.frame.size.width
        print(pageWidth)
        print(self.imageCV.contentOffset.x)
        print(self.imageCV.contentOffset.x / pageWidth)
        scrollPageControll.currentPage = Int(self.imageCV.contentOffset.x / pageWidth)
        
    }
    
}
   

