//
//  ViewController.swift
//  Marvel
//
//  Created by Jaber Vieira Da Silva Shamali on 01/03/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var Collection: UICollectionView!
    @IBOutlet weak var Tabela: UITableView!
    
    let request = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request.requestData(from: nil)
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = Collection.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Tabela.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        return cell
    }

}

