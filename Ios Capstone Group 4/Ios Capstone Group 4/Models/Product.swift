//
//  Product.swift
//  Ios Capstone Group 4
//
//  Created by user303000 on 10/1/26.
//

class Product : Identifiable, Hashable, Codable {
    
    let id: Int
    let name: String
    let productNumber: String
    let summary: String
    let thumbnailPhoto: String
    let thumbnailPhotoFileName: String
    let warranty: String?
    let color: String
    let listPrice: Double
    
    init(id: Int, name: String, productNumber: String, summary: String, thumbnailPhoto: String, thumbnailPhotoFileName: String, warranty: String?, color: String, listPrice: Double) {
        self.id = id
        self.name = name
        self.productNumber = productNumber
        self.summary = summary
        self.thumbnailPhoto = thumbnailPhoto
        self.thumbnailPhotoFileName = thumbnailPhotoFileName
        self.warranty = warranty
        self.color = color
        self.listPrice = listPrice
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
