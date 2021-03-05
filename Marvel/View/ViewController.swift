//
//  ViewController.swift
//  Marvel
//
//  Created by Jaber Vieira Da Silva Shamali on 01/03/21.
//

import UIKit
import Alamofire
import Network


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var Collection: UICollectionView!
    @IBOutlet weak var Tabela: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var Data = [Entry]()
    let request = API()
    var from = 0
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async(execute: {
            self.monitor.start(queue: self.queue)
            self.checkNetwork()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loader.startAnimating()
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
        
        let url = convertURL(link: Data[0].data.result[indexPath.row].thumb.path, extensionImg: Data[0].data.result[indexPath.row].thumb.extensionThumb , type:"Collection")

        AF.request(url ,method: .get).response{ response in
         switch response.result {
          case .success(let responseData):
            self.loader.stopAnimating()
            self.loader.isHidden = true
            cell.img.image = UIImage(data: responseData!, scale:1)
          case .failure(let error):
              print("error--->",error)
          }
        }
        
        cell.nameCharacter.text = Data[0].data.result[indexPath.row].name
        
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
                
        let url = convertURL(link: Data[0].data.result[indexPath.row+5].thumb.path, extensionImg: Data[0].data.result[indexPath.row+5].thumb.extensionThumb, type: "")

        AF.request(url ,method: .get).response{ response in
         switch response.result {
          case .success(let responseData):
            cell.img.image = UIImage(data: responseData!, scale:1)
          case .failure(let error):
            print("error--->",error)
          }
        }

        
        cell.personagemLb.text = Data[0].data.result[indexPath.row+5].name

        
        
        
        return cell
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 1) {
            loadMore()
            self.Tabela.reloadData()

            }
        }
    
    func loadMore(){
        from += 15
        request.requestData(from: from) { (result) in
            self.Data[0].data.result.append(contentsOf: result.data.result)
        }
    }
    
    func convertURL(link:String, extensionImg: String, type:String) -> String{
        
        var link = link
        
        if type == "Collection"{
            link = "\(link)/portrait_incredible.\(extensionImg)"
        }
        else if type == "SV"{
            link = "\(link)/portrait_uncanny.\(extensionImg)"
        
        }else {
            link = "\(link)/landscape_incredible.\(extensionImg)"
        }
        let linkFinal = link.replacingOccurrences(of: "http", with: "https")
        
        return linkFinal
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = Tabela.indexPathForSelectedRow{
            
            let detailVC = segue.destination as! DescriptionViewController
            let url = convertURL(link: Data[0].data.result[indexPath.row+5].thumb.path, extensionImg: Data[0].data.result[indexPath.row+5].thumb.extensionThumb, type: "SV")
            
            detailVC.name = Data[0].data.result[indexPath.row+5].name
            detailVC.descriptionCharacters = Data[0].data.result[indexPath.row+5].description
            detailVC.imgUrl = url
            }
    }
    
    func showAlert(){
        // create the alert
               let alert = UIAlertController(title: "Aviso", message: "Você está sem acesso a internet!!!", preferredStyle: UIAlertController.Style.alert)

               // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            self.checkNetwork()
        }))
        
        

        DispatchQueue.main.async(execute: {
            // show the alert
            self.present(alert, animated: true, completion: nil)
        })
        
    }
    
    func checkNetwork(){
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                self.request.requestData(from: nil) { (result) in
                self.Data.append(result)
                self.Tabela.reloadData()
                self.Collection.reloadData()
                }
            } else {
                self.showAlert()
            }
        }
    }
    

}
    



