//
//  ListCardTableViewController.swift
//  KisanHubJson
//
//  Created by Nikhil Modi on 10/5/18.
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import UIKit

class ListCardTableViewController: UITableViewController {
    var response:Response<DataItem>?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: AppConstant.tableIdentifier)
        tableView.tableFooterView = UIView()
        let networkSession = NetworkSession(success: { data,url,requestString in
            
            do {
                let jsonDecoder = JSONDecoder()
                self.response = try jsonDecoder.decode(Response<DataItem>.self, from: data)

                
            }
            catch {
                print(error)
            }
            
        }, andFailure: { error,url,requestString in
            
                    DispatchQueue.main.async {
                        self.showAlertOK(title: "Error", message: error.localizedDescription)
                    }
            
            
            
            }, andCommonUI: {
                if let parent = self.parent as? ListCardContainerViewController {
                    parent.activityIndicatorView.stopAnimating()
                    self.tableView.reloadData()
                }
                
        })
        networkSession.setUpGetRequest(urlString: AppConstant.baseURL)
        
    }

    // MARK: - Table view data source

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return response?.data?.count ?? 0
    }

    /* */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstant.tableIdentifier, for: indexPath) as! TitleTableViewCell
        if let dataItem = response?.data?[indexPath.row]
        {
            cell.titleLabel.text = "\(dataItem)"
        }

        return cell
    }
 

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

}
extension UIViewController {
    func showAlertOK(title:String,message:String){
        print("show alert \(message)")
        showAlertOk(title: title, message: message,alertAction:nil)
    }
    func showAlertOk(title:String,message:String,alertAction:UIAlertAction?){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if alertAction == nil {
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //           }
            
        }
        else{
            alertController.addAction(alertAction!)
            
        }
        
        if UIApplication.shared.frontmostViewController?.presentedViewController == nil {
            UIApplication.shared.frontmostViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
extension UIApplication {
    
    var frontmostViewController: UIViewController? {
        let window = UIApplication.shared.keyWindow
        var viewController = window!.rootViewController
        while viewController?.presentedViewController != nil {
            viewController = viewController?.presentedViewController
        }
        
        return viewController
    }
}
