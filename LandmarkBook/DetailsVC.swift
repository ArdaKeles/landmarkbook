//
//  DetailsVC.swift
//  LandmarkBook
//
//  Created by Arda Keleş on 4.09.2022.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var landMarkLabel: UILabel!
    
    //variables.. diğer VC'den gelecek olan seçimleri bu değişkene gönderebilelim diye bunları oluşturdur.
    var selectedLandMarkName = ""
    var selectedLandMarkImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //diğer VC'den gelen isim ve image'ı da bu VC'deki değişkenlere eşitledik.
        landMarkLabel.text = selectedLandMarkName
        imageView.image = selectedLandMarkImage
    }
}
