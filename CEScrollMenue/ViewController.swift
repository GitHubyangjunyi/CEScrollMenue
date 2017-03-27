//
//  ViewController.swift
//  CEScrollMenue
//
//  Created by Mr.LuDashi on 2017/3/24.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import UIKit

let reuseIdentifier = "CEThemeCollectionViewCell"
let headerReuseIdentifier = "CEHeaderCollectionReusableView"
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

class ViewController: UIViewController, UICollectionViewDataSource{
    
    var themeCollectionView: CEThemeCollectionView!
    var dataSource: Array<Array<String>>!
    
    var themeCollectionViewWidth: CGFloat {
        get {
            return SCREEN_WIDTH - 60
        }
    }
    
    var themeCollectionViewHeight: CGFloat {
        get {
            return SCREEN_HEIGHT - 60
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = createDataSource()
        self.addThemeCollectionView()
    }
    
    ///添加选择主题的View
    func addThemeCollectionView() {
        self.themeCollectionView = CEThemeCollectionView(frame: CGRect(x: 30, y: 30, width:themeCollectionViewWidth,  height: themeCollectionViewHeight), collectionViewLayout: UICollectionViewFlowLayout())
        self.themeCollectionView.dataSource = self

        self.view.addSubview(self.themeCollectionView)
        
        weak var weak_self = self
        self.themeCollectionView.setSwapDataSource { (at, to) in
            weak_self?.swap(at: at, to: to)
        }
        self.themeCollectionView.setUpdataDataSource { (at, to) in
            weak_self?.updateDataSource(at: at, to: to)
        }
    }
    
    
    /// 同一个Section中进行交换
    ///
    /// - Parameters:
    ///   - at: <#at description#>
    ///   - to: <#to description#>
    func swap(at: IndexPath, to: IndexPath) {
        let temp = self.dataSource[at.section][at.row]
        self.dataSource[at.section][at.row] = self.dataSource[to.section][to.row]
        self.dataSource[to.section][to.row] = temp
    }
    
    
    /// 不同的Section中进行更新
    ///
    /// - Parameters:
    ///   - at: <#at description#>
    ///   - to: <#to description#>
    func updateDataSource(at: IndexPath, to: IndexPath) {
        let removeItem = self.dataSource[at.section].remove(at: at.row)
        self.dataSource[to.section].insert(removeItem, at: 0)
    }
    
    func createDataSource() -> Array<Array<String>> {
        var dataSource = Array<Array<String>>()
        for i in 0..<2 {
            var subArray = Array<String>()
            for j in 0..<15 {
                subArray.append("菜单\(i)-\(j)")
            }
            dataSource.append(subArray)
        }
        return dataSource
    }
    
    
    // Mark: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CEThemeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CEThemeCollectionViewCell
        cell.textLabel.text = dataSource[indexPath.section][indexPath.row]
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: CEHeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! CEHeaderCollectionReusableView
        if indexPath.section == 0 {
            headerView.titleLabel.text = "我的频道"
        } else {
            headerView.titleLabel.text = "推荐频道"
        }
        
        return headerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
