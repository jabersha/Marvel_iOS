//
//  DescriptionViewController.swift
//  Marvel
//
//  Created by Jaber Vieira Da Silva Shamali on 03/03/21.
//

import UIKit
import Alamofire
import Hero

class DescriptionViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var descriptionLb: UILabel!
    
    var name = String()
    var imgUrl = String()
    var descriptionCharacters = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if UIDevice.current.userInterfaceIdiom == .phone{
            
            self.hero.isEnabled = true
            nameLb.hero.id = "name"
            img.hero.id = "img"
            descriptionLb.hero.modifiers = [.cascade]
            
        }


        
        
        nameLb.text = name
        if descriptionCharacters != ""{
        descriptionLb.text = descriptionCharacters
        } else {
            descriptionLb.isHidden = true
        }
        
        if let imageURL = URL(string: imgUrl){
                        let data = try? Foundation.Data(contentsOf: imageURL)
                        if let data = data {
                            let image = UIImage(data: data)
                            DispatchQueue.main.async {
                                self.img.image = image
                            }
                        }
                   
                }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
