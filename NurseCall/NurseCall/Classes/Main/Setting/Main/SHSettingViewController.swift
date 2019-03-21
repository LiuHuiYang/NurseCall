//
//  SHSettingViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/18.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


class SHSettingViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.white
        
        tableView.sectionHeaderHeight = 20
        tableView.sectionFooterHeight = 0
        
        // 分组样式的第一个cell的默认y值是35，要想间距为20，必须上移15，
        // 但这个上移应该是内容视图整体的上移，应该调整tableview头部的内边距
        tableView.contentInset =
            UIEdgeInsets(top: -15, left: 0, bottom: 0, right: 0);
        
    }
    
    // MARK: - Table view data source
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
            
        case 0:
            break
            
        case 1:
            break
            
        case 2:
            break
            
        case 3:
            let aboutController = SHAboutViewController()
            navigationController?.pushViewController(
                aboutController, animated: true
            )
            
        default:
            break
        }
    }
}

