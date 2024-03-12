//
//  DetalleViewController.swift
//  Mapas
//
//  Created by Dianelys Saldaña on 3/11/24.
//

import UIKit

class DetalleViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var thumbnailImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let thumbnailImage = thumbnailImage {
            imageView.image = thumbnailImage
        }
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
