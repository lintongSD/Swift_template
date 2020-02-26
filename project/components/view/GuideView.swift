//
//  GuideView.swift
//  bldme
//
//  Created by LYon on 2018/5/22.
//  Copyright © 2018年 bld. All rights reserved.
//

import UIKit

class GuideView: UIView ,UIScrollViewDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        addSubview(imageScrollview)
        addSubview(pageContrll)
        addSubview(overButton)
        
        makeImage()
    }
    
    func makeImage(){
        let imageNameArr = isiPhoneX ? ["guide_x_1","guide_x_2","guide_x_3","guide_x_4"] : ["guide_1","guide_2","guide_3","guide_4"]
        for i in 0..<imageNameArr.count {
            let imageView = UIImageView.init(frame: CGRect(x: screenWidth * CGFloat(i), y: 0, width: screenWidth, height: screenHeight))
            imageView.image = UIImage.init(named: imageNameArr[i])
            imageScrollview.addSubview(imageView)
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
        pageContrll.currentPage = current
        if current == 3 {
            pageContrll.isHidden = true
            overButton.isHidden = false
        } else {
            pageContrll.isHidden = false
            overButton.isHidden = true
        }
    }
    
    // 滚动视图
    lazy var imageScrollview: UIScrollView = {
        let imageScrollview = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        imageScrollview.contentSize = CGSize(width: screenWidth * 4, height: screenHeight)
        imageScrollview.delegate = self
        imageScrollview.isPagingEnabled = true
        imageScrollview.backgroundColor = .white
        imageScrollview.showsVerticalScrollIndicator = false
        imageScrollview.showsHorizontalScrollIndicator = false
        return imageScrollview
    }()
    
    //立即体验按钮
    lazy var overButton: UIButton = {
        let orignY = screenHeight - (isiPhoneX ? 143 : 104)
        let overButton = UIButton(frame: CGRect(x: (screenWidth/2)-66, y: orignY, width: 132, height: 40))
        overButton.isHidden = true
        overButton.layer.cornerRadius = 20
        overButton.layer.borderWidth = 1.0
        overButton.layer.masksToBounds = true
        overButton.setTitle("开始体验", for: .normal)
        overButton.setTitleColor(.themeColor, for: .normal)
        overButton.layer.borderColor = UIColor.themeColor.cgColor
        overButton.addTarget(self, action: #selector(overButtonSelect), for: .touchUpInside)
        return overButton
    }()
    
    lazy var pageContrll: UIPageControl = {
        let pageContrll = UIPageControl(frame: CGRect(x: 50, y: screenHeight - 85, width: screenWidth - 100, height: 50))
        pageContrll.currentPage = 0
        pageContrll.numberOfPages = 4
        pageContrll.pageIndicatorTintColor = .subTitleColor
        pageContrll.currentPageIndicatorTintColor = .themeColor
        return pageContrll
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
