//
//  Pin.swift
//  Mapas
//
//  Created by Dianelys Saldaña on 3/12/24.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var thumbImage: UIImage

    init(num: Int, coordinate: CLLocationCoordinate2D) {
        self.title = "Pin \(num)"
        self.subtitle = "Un bonito lugar"
        self.coordinate = coordinate
        if (num % 2 == 0) {
            self.thumbImage = UIImage(named: "alicante1_thumb.jpg")!
        } else {
            self.thumbImage = UIImage(named: "alicante2_thumb.jpg")!
        }
        super.init()
    }
}
