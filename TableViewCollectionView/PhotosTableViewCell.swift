//
//  PhotosTableViewCell.swift
//  TableViewCollectionView
//
//  Created by 蔡尚諺 on 2022/1/14.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    var deviceWidth: Double! //實際裝置的寬
    let space = 15.0 //圖片間隔
    var padding: Double! { deviceWidth * 0.1 } //部分分頁

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint! //collectionView的height
    let images = ["Image-1","Image-2","Image-3","Image-4","Image-5","Image-6"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setFlowLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = deviceWidth - space * 2 - padding * 2
        layout.minimumLineSpacing = space
        heightConstraint.constant = width //透過程式改 Constraint
        layout.itemSize = CGSize(width: width, height: width)
        layout.estimatedItemSize = .zero
    }
    
    func getTargetX(page: Int) -> CGFloat {
        
        var targetX = 0.0
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let width = layout.itemSize.width
        
        if page <= 1 {
            targetX = 0
            //最後一頁
        }else if page >= images.count{
            
            targetX = width * Double(images.count - 1) + space * Double(images.count - 2) - 2 * padding - space
            //中間頁數（有前後頁）
        }else{
            targetX = width * Double(page - 1) + space * Double(page - 2) - padding
        }
        
        return targetX
    }
}

extension PhotosTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotosCollectionViewCell.self)", for: indexPath) as! PhotosCollectionViewCell
        let name = images[indexPath.row]
        
        cell.photoImageView.image = UIImage(named: name )
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let scrollView = collectionView as UIScrollView
        var contentOffset = scrollView.contentOffset
        contentOffset.x = getTargetX(page: indexPath.row + 1)
        scrollView.setContentOffset(contentOffset, animated: true)
        
    }
    
}

extension PhotosTableViewCell {
    //用程式控制換頁
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //圖片寬度
        let width = layout.itemSize.width
        /* ceil: 無條件進位
         算出滑到第幾張圖（一張圖一頁）*/
        let totalX = width * Double(images.count - 1) + space * Double(images.count - 2) - 2 * padding - space
        //算出一頁的平均值
        let averate = totalX / Double(images.count)
        let currentPage = Int(ceil(targetContentOffset.pointee.x / averate)) + 1
        
        //x軸位置
        var targetX = getTargetX(page: currentPage)
        targetContentOffset.pointee.x = targetX
    }
    
}
