/**
 //
 //  VerizonIamgeListViewController.swift
 //  VerizonImageDownLoader
 //
 //  Created by Dhara Naik on 1/10/17.
 //  Copyright © 2017 Verizon. All rights reserved.
 //
 */

// Adinng Some new Comments


import UIKit
import WebImage
import SwiftyJSON

class VerizonIamgeListViewController: UITableViewController,UISearchResultsUpdating {

    /** Properties Declaration */
    @IBOutlet weak var hearderView: UIView!
    @IBOutlet weak var searchbarHeaderView: UIView!
    @IBOutlet weak var btnImageNameRefresh: UIButton!
    @IBOutlet weak var btnImageURLRefresh: UIButton!
    @IBOutlet weak var refreshTableView: UIBarButtonItem!
    
    
    var ascendingName = true
    var ascendingImage = true
    
    /** Variable to store JSON data */
    var jsonObj : JSON?
    
    /** Variable to store filetered JSON data */
    var filterObj : [JSON] = []
    
    /** Variable to store search controller */
    let searchController = UISearchController(searchResultsController: nil)
    
    
    /*********************************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromFile()
        configureSearchController()
        
        for subView in self.searchController.searchBar.subviews
        {
            for subsubView in subView.subviews
            {
                if let textField = subsubView as? UITextField
                {
                    textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search by Name", comment: ""), attributes: [NSForegroundColorAttributeName:UIColor(red:0.03, green:0.73, blue:0.85, alpha:1.0)])
                    textField.textColor = UIColor(red:0.03, green:0.73, blue:0.85, alpha:1.0)
                    
                    let glassIconView = textField.leftView as! UIImageView
                    glassIconView.image = glassIconView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                    glassIconView.tintColor = UIColor(red:0.03, green:0.73, blue:0.85, alpha:1.0)
                    
                    let clearButton = textField.value(forKey: "clearButton") as! UIButton
                    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
                    clearButton.tintColor = UIColor(red:0.03, green:0.73, blue:0.85, alpha:1.0)
                    
                }
            }
        }
        
    }
   
    /*********************************************************************************************/
    /** Will hide the status bar */
    /*********************************************************************************************/
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /*********************************************************************************************/
    override func viewWillAppear(_ animated: Bool) {
        configureSearchController()
    }
    
    /*********************************************************************************************/
    /** This function will filter the JSON array based on searchtext and will create filtered array
     :param: searchText,JSON Array .
     :returns: filtered JSON Array.
     */
    /*********************************************************************************************/

    func filterContentForSearchText(searchText: String,filterDictionary : JSON) {
        let  newfilterArray = filterDictionary.filter { ($0.1["name"].string?.contains(searchText))!}.map { $0.1 }
        filterObj = newfilterArray
        tableView.reloadData()
    }
    

    /*********************************************************************************************/
    /** This function will configure searchController */
    /*********************************************************************************************/
    func configureSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.definesPresentationContext = true
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.barTintColor = UIColor(red:0.03, green:0.73, blue:0.85, alpha:1.0)
        self.searchController.searchBar.tintColor = UIColor.white
        self.searchbarHeaderView.addSubview(self.searchController.searchBar)
             self.tableView.reloadData()
    }
    

    /*********************************************************************************************/
    /** Delegate to fit the searchbar size with its super view */
    /*********************************************************************************************/
    override func viewWillLayoutSubviews() {
        self.searchController.searchBar.sizeToFit()
    }
    
    
    /*********************************************************************************************/
    /** This function will fetch data from data file and will convert data into JSON object array using SWIFTYJSON library */
    /*********************************************************************************************/
    func fetchDataFromFile()
    {
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                jsonObj = JSON(data: data)
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    /*********************************************************************************************/
    /** This function will do alphabatic sorting on JSON Data using filter(name or imageURL value.
        sorting can be done in ascending as well as descending direction.*/
    /*********************************************************************************************/
    func sortData(filterValue : String, jsonDictionary : JSON,ascending:Bool) {
        var sortedResults:[JSON] = []
        if filterValue == "name" {
            if ascending {
                 sortedResults = jsonDictionary.sorted { $0.0.1["name"] < $0.1.1["name"]}.map { $0.1 } }
            else {
               sortedResults = jsonDictionary.sorted { $0.0.1["name"] > $0.1.1["name"]}.map { $0.1 } }
        }
        else if filterValue == "imageURL"
        {
            if ascending {
                sortedResults = jsonDictionary.sorted { $0.0.1["image"] < $0.1.1["image"]}.map { $0.1 } }
            else{
                sortedResults = jsonDictionary.sorted { $0.0.1["image"] > $0.1.1["image"]}.map { $0.1 } }
        }
        
        for i in 0..<jsonDictionary.count {
            jsonObj?[i] = sortedResults[i]
        }
        self.tableView.reloadData()

    }
    
    // Mark :- IBActions
    /*********************************************************************************************/
    /**  This function will refresh table view */
    /*********************************************************************************************/
   
    @IBAction func refreshTableViewToOriginal(_ sender: Any) {
        fetchDataFromFile()
        self.tableView.reloadData()
    }
    
    
    /*********************************************************************************************/
    /** This action will be called on image button clicked from table header view. This action will provide sorting of data based on ImageURL in ascending as well as descending direction.     */
    /*********************************************************************************************/
    @IBAction func sortTablebyImageURL(_ sender: Any) {
        if jsonObj != JSON.null {
            sortData(filterValue: "imageURL", jsonDictionary: jsonObj!,ascending: self.ascendingImage)
            self.ascendingImage = !self.ascendingImage
            
        }
    }
    
    /*********************************************************************************************/
    /** This action will be called on image button clicked from table header view. This action will provide sorting of data based on name in ascending as well as descending direction. */
    /*********************************************************************************************/
    @IBAction func sortTablebyImageName(_ sender: Any) {
        
        if jsonObj != JSON.null {
            sortData(filterValue: "name", jsonDictionary: jsonObj!,ascending: self.ascendingName)
            self.ascendingName = !self.ascendingName
        }
    }
    

    
    
    // MARK: - Table view data source
    /*********************************************************************************************/
    /** datasource to provide number of section as well as row to tableview */
    /*********************************************************************************************/
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /*********************************************************************************************/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.isActive {
            return filterObj.count
        }
        else {
             return jsonObj!.count
        }
        
    }
    
    /*********************************************************************************************/
    /**
     @brief Tableview data source method to set custom/default cell for each row.
    
     @discussion This method will get the image URL and image name from JSON Data array and will fetch the actul image for given imageURL using SDWebImage library. Which will lazy load the images using the  custom table view cell and NSCACHE. The Mask image will be used as placeholder image.
    
    @return Will return our custom UITableViewCell. */
    /*********************************************************************************************/
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageListCell", for: indexPath) as! CustomCell
        if self.searchController.isActive {
            if filterObj.count > 0 {
                cell.lblImageText.text = filterObj[indexPath.row]["name"].string!
                cell.imgThumnailImage.sd_setImage(with: URL(string: filterObj[indexPath.row]["image"].string!), placeholderImage: UIImage(named: "Mask"))
                cell.imgThumnailImage.setShowActivityIndicator(true)
                cell.imgThumnailImage.setIndicatorStyle(.gray) }
            else {
                cell.imgThumnailImage.image = UIImage(named: "mask")
                cell.lblImageText.text = "Error in Downloading Data"
            }
        } else {
            if jsonObj != JSON.null {
                cell.lblImageText.text = jsonObj![indexPath.row]["name"].string!
                cell.imgThumnailImage.sd_setImage(with: URL(string: jsonObj![indexPath.row]["image"].string!), placeholderImage: UIImage(named: "Mask"))
                cell.imgThumnailImage.setShowActivityIndicator(true)
                cell.imgThumnailImage.setIndicatorStyle(.gray) }
            else {
                cell.imgThumnailImage.image = UIImage(named: "mask")
                cell.lblImageText.text = "Error in Downloading Data"
            }
        }
        return cell;
        
    }
    
    /*********************************************************************************************/
    /** Delegate will give selected row index as well as selected image data */
    /*********************************************************************************************/
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if jsonObj != JSON.null {
        let selectedImageURL = jsonObj![indexPath.row]["image"].string!
        performSegue(withIdentifier: "showDetailImage", sender: selectedImageURL)
      }
       else
        {
            let alertView = UIAlertController(title: "Data Error",
                                              message: "No Data Found)", preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Try Again!", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    /*********************************************************************************************/
    /** Delegate to update the search result based on user input */
    /*********************************************************************************************/
    func  updateSearchResults(for searchController: UISearchController) {
        self.filterObj.removeAll()
        filterContentForSearchText(searchText: searchController.searchBar.text!, filterDictionary: jsonObj!)
        self.tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    /*********************************************************************************************/
    /** Image URL and the name text will be passed to detail view controller if the segue matches. */
    /*********************************************************************************************/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailImage" {
            let destinationController = segue.destination as! DetailImageViewController
            destinationController.selectedImageURL = sender as? String
        }
        
    }
 

}
