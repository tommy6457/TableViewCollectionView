//
//  ViewController.swift
//  TableViewCollectionView
//
//  Created by 蔡尚諺 on 2022/1/14.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let texts = ["測試-1","測試-2","測試-3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    //section數量
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    //Header Title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "圖片"
        }else{
            return "Label"
        }
        
    }
    
    //row數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1 //放collectionView
        }else{
            return texts.count
        }
        
    }
    
    //cell內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PhotosTableViewCell.self)", for: indexPath) as! PhotosTableViewCell
            
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TextTableViewCell.self)", for: indexPath) as! TextTableViewCell
            cell.testTextLabel.text = texts[indexPath.row]
            return cell
            
        }
        
    }
    
}

