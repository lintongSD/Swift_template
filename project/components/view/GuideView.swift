//
//  GuideView.swift
//  bldme
//
//  Created by LYon on 2018/5/22.
//  Copyright © 2018年 bld. All rights reserved.
//

import UIKit

class GuideView: UIView ,UIScrollViewDelegate {
    
    let pageContrll = UIPageControl()
    let overButton = UIButton()
    let imageScrollview = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        loadSubView()
    }
    
    func loadSubView(){
        //滚动视图
        self.imageScrollview.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        self.imageScrollview.contentSize = CGSize(width: screenWidth * 4, height: screenHeight)
        self.imageScrollview.isPagingEnabled = true
        self.imageScrollview.backgroundColor = UIColor.white
        self.imageScrollview.delegate = self
        self.imageScrollview.showsVerticalScrollIndicator = false
        self.imageScrollview.showsHorizontalScrollIndicator = false
        self.addSubview(imageScrollview)
        //创建image
        self.makeImage()
        //页面指示器
        self.pageContrll.frame = CGRect(x: 50, y: screenHeight - 85, width: screenWidth - 100, height: 50)
        self.pageContrll.currentPage = 0
        self.pageContrll.numberOfPages = 4
        self.pageContrll.pageIndicatorTintColor = .subTitleColor
        self.pageContrll.currentPageIndicatorTintColor = .themeColor
//        self.pageContrll.setValue(UIImage.init(named: "guide_current"), forKey: "currentPageImage")
//        self.pageContrll.setValue(UIImage.init(named: "guide_default"), forKey: "pageImage")
//        self.pageContrll.isEnabled = false //禁止点圆点
        self.addSubview(pageContrll)
        //立即体验按钮
        let orignY = screenHeight - (isiPhoneX ? 143 : 104)
        self.overButton.frame = CGRect(x: (screenWidth/2)-66, y: orignY, width: 132, height: 40)
        self.overButton.layer.masksToBounds = true
        self.overButton.layer.borderColor = UIColor.themeColor.cgColor
        self.overButton.layer.cornerRadius = 20
        self.overButton.layer.borderWidth = 1.0
        self.overButton.setTitle("开始体验", for: .normal)
        self.overButton.setTitleColor(.themeColor, for: .normal)
        self.overButton.isHidden = true
        self.overButton.addTarget(self, action: #selector(self.overButtonSelect), for: .touchUpInside)
        self.addSubview(overButton)
    }
    func makeImage(){
        let imageNameArr = isiPhoneX ? ["guide_x_1","guide_x_2","guide_x_3","guide_x_4"] : ["guide_1","guide_2","guide_3","guide_4"]
        for i in 0..<imageNameArr.count {
            let imageView = UIImageView.init(frame: CGRect(x: screenWidth * CGFloat(i), y: 0, width: screenWidth, height: screenHeight))
            imageView.image = UIImage.init(named: imageNameArr[i])
            self.imageScrollview.addSubview(imageView)
        }
    }
    
    @objc func overButtonSelect() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }, completion: { (finish) in
            self.removeFromSuperview()
        })
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let current = NSInteger.init(scrollView.contentOffset.x/screenWidth)
        self.pageContrll.currentPage = current
        if current == 3 {
            self.pageContrll.isHidden = true
            self.overButton.isHidden = false
        } else {
            self.pageContrll.isHidden = false
            self.overButton.isHidden = true
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
