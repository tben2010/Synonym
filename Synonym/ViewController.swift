//
//  ViewController.swift
//  Synonym
//
//  Created by tben on 19.02.16|KW7.
//  Copyright © 2016 tben. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var searchText: UITextField!
    
    //MARK: - Actions
    @IBAction func searchSynonym(sender: AnyObject) {
        if searchText.text != nil {
            getSynonyms(searchText.text!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        tabelView.delegate = self
        tabelView.dataSource = self
        
        title = NSLocalizedString("synonymTile", comment: "Title in Search View Controller")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("synonymCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Zeile \(indexPath.row)"
        return cell
    }
    
    //MARK: - Methoden
    func getSynonyms(searchText:String){
        
        var foundedSynonyms = [String]()
        let jsonDictionary = fetchSynonyms(searchText)
        
    }
    
    func fetchSynonyms(searchText:String) -> NSDictionary {
        let apiUrl = NSURL(string: "https://www.openthesaurus.de/synonyme/search?q=\(searchText)&format=application/json")
        
        let jsonRespones = NSData(contentsOfURL: apiUrl!)
        
        var jsonDict: NSDictionary = [:]
        do {
            jsonDict = try NSJSONSerialization.JSONObjectWithData(jsonRespones!, options: []) as! NSDictionary
        }catch {
            print(error)
        }
        
        return jsonDict
        
    }


}

