//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Arda Keleş on 4.09.2022.
//

/*
-- Bu yapının kullanımı dizilerle beraber çok daha güzel olacak. Bir listeyi alt alta sıralı şeklinde gösterebildiğimiz yapıdır Tableview. Main sayfasında Label ekler gibi TableView ekliyoruz ve kod bölümüne onu tanımlıyoruz.
-- Sonra class bölümünde UIViewController sınıfı zaten tanımlı. Bunun yanında TableView özelliklerini kullanabilmek için 2 adet daha Protokol ekliyoruz. Bunlar soyut kavramlar ileri ki derslerde görülecek. Bu 2 protokolü ekleyince hata verecek ve bunların kullanımını sağlayan fonksiyonları yazmamız gerekecek. Fix ile de ekleniyor ama manuel yazmak daha düzgün çalışmasını sağlıyor.
-- DELEGATE ve DATASOURCE uzantılı iki adet protokolü ekledikten sonra sınıf parantezi içinde "Numberofrawinsection" ve "Cellforrawat" isimli iki fonksiyonu ekleyeceğiz. Sınıfa 2 protokolü eklemezsek bu 2 fonksiyonu çağıramayız.
--değişiklik 2 notu...
 */
import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    var landMarkNames = [String]()
    var landMarkImages = [UIImage]()
    
    var chosenLandMarkLabel = ""
    var chosenLandMarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bu kodaları da burada çağırmamız gerekli. Tableview'ımıza delegate ve datasource protokollerini çağırmış oluyoruz.
        tableView.delegate = self
        tableView.dataSource = self
        
        //burada yerler ve resimleri diye 2 adet dizi oluşturacağız. Normalde hem ismi hem de image'ı aynı yerde kullanabileceğimiz bir dizi oluşturabiliriz ama bunu ileride gösterecek. Biz şimdi iki ayrı dizi oluşturarak bu işlemi yapacağız.
        
        
        landMarkNames.append("Colosseum")
        landMarkNames.append("Great Wall")
        landMarkNames.append("Kremlin")
        landMarkNames.append("Stonehenge")
        landMarkNames.append("Taj Mahal")
        
        //append'lerin sonuna ! koyduk. Kesin öyle bir image var olduğunu bildiğimiz için. Bunlar optional diyor program bize, ! koyduğumuzda programı çökertmeyeceğini bildiğimiz için koyduk...
       
        landMarkImages.append(UIImage(named: "kolezyum")!)
        landMarkImages.append(UIImage(named: "greatwall")!)
        landMarkImages.append(UIImage(named: "cremlin")!)
        landMarkImages.append(UIImage(named: "stonehenge")!)
        landMarkImages.append(UIImage(named: "tajmahal")!)
        
        
        
    }
    
    //ilk fonksiyon ne kadarlık bir liste gösterileceğini soruyor ve Int döndürüyor. Buraya ne kadarlık liste istiyorsak onu yazıyoruz.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landMarkNames.count
    }
    
    //ikinci fonksiyonda da hücrelerde ne verisi olacak onu yazmamız gerekiyor.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell()
        /* bu kod satırı artık kullanımdan kalkacakmış. Bu kolay yolu. Bunun bir tık daha zor yoluyla gösterim işini yapacağız.
         cell.textLabel?.text = "test"
         bunun yerine 3 satır kod yazacağız. Önce tanımladığımız tableview.Contentconfiguration sınıfından bir değişken oluşturacağız. Bu oluşturduğumuz değişken üzerinden istediğimiz yazıyı, image'ı ayarlayı bunu kodun üstünde oluşturduğumuz viewCell sınıfından değişkene eşitleyeceğiz.*/
        
        var content = cell.defaultContentConfiguration()
        content.text = landMarkNames[indexPath.row] //bu kod fonksiyonda bize verilen bir özellik. Row ile dizi içindeki hepsini tek tek listeye yazdırıyor.
        /* content.secondaryText = "test" şeklinde ek özellikleri de var...*/
        cell.contentConfiguration = content
        return cell
        
        
    }
    
    //bir hücre seçildiğinde ne yapılması gerektiğini bu fonksiyon içinde yazacağız...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenLandMarkLabel = landMarkNames [indexPath.row] //hangisi seçildiyse ismi değişkene aktar.
        chosenLandMarkImage = landMarkImages [indexPath.row] //hangisi seçildiyse image'ı aktar.
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.selectedLandMarkName = chosenLandMarkLabel
            destinationVC.selectedLandMarkImage = chosenLandMarkImage
        }
    }
    
    //bu "commit" fonksiyonu table'da ki hücrenin yana kaydırılması sonucunda hangi işlemlerin yapılacağını belirtmek için kullanılıyor.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.landMarkNames.remove(at: indexPath.row)
            self.landMarkImages.remove(at: indexPath.row)
            // tableView.reloadData()  silinen bilginin table'da gösterilmemesi için bilgileri reload yaptırabiliriz ama bu bütün bilgileri reload yapabilir. onun yerine silinmek istenen hücreyi sildireceğiz.
            tableView.deleteRows(at: [indexPath], with: .fade)  // silinmesini istediğimiz yerin indexPath olarak [] parantez içinde yazmamız gerekiyor...
        }
    }
    
}

