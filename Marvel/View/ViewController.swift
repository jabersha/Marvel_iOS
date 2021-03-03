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

    var Data = [Entry]()
    let request = API()
    var from = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request.requestData(from: nil) { (result) in
            self.Data.append(result)
            self.Tabela.reloadData()
            self.Collection.reloadData()
        }

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !Data.isEmpty {
            return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = Collection.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = 10.0
        cell.layer.masksToBounds = true
        
        cell.nameCharacter.text = Data[0].data.result[indexPath.row].name
        
        let link = "\(Data[0].data.result[indexPath.row].thumb.path)/portrait_incredible.\(Data[0].data.result[indexPath.row].thumb.extensionThumb)"
        let linkFinal = link.replacingOccurrences(of: "http", with: "https")
        print(linkFinal)
        if let imageURL = URL(string: linkFinal){
                        let data = try? Foundation.Data(contentsOf: imageURL)
                        if let data = data {
                            let image = UIImage(data: data)
                            DispatchQueue.main.async {
                                cell.img.image = image
                            }
                        }
                   
                }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !Data.isEmpty {
            return Data[0].data.result.count - 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Tabela.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        cell.personagemLb.text = Data[0].data.result[indexPath.row+5].name
        

        let link = "\(Data[0].data.result[indexPath.row+5].thumb.path)/landscape_incredible.\(Data[0].data.result[indexPath.row+5].thumb.extensionThumb)"
        let linkFinal = link.replacingOccurrences(of: "http", with: "https")
        print(linkFinal)
        if let imageURL = URL(string: linkFinal){
                        let data = try? Foundation.Data(contentsOf: imageURL)
                        if let data = data {
                            let image = UIImage(data: data)
                            DispatchQueue.main.async {
                                cell.img.image = image
                            }
                        }
                   
                }
        
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 0.6){
                from += 10
                request.requestData(from: from) { (result) in
                    self.Data[0].data.result.append(contentsOf: result.data.result)
                    self.Tabela.reloadData()
                    print("Total: \(self.from)")
                    return
                }
            }
        }

}


