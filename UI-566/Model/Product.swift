//
//  Product.swift
//  Product
//
//  Created by nyannyan0328 on 2021/09/01.
//

import SwiftUI

struct Product: Identifiable {
    var id = UUID().uuidString
    var productImage : String
    var productTitle : String
    var productPrice : String
    var productBG : Color
    var isliked : Bool = false
    var productRating : Int
}

var products = [



Product(productImage: "p1", productTitle: "Air Max", productPrice: "$240", productBG: Color("shoeBG1"),productRating: 4),

Product(productImage: "p2", productTitle: "Excee Sneakers", productPrice: "$260", productBG: Color("shoeBG2"),isliked: true,productRating: 5),


Product(productImage: "p3", productTitle: "Air Max Motion 2", productPrice: "$280", productBG: Color("shoeBG3"),productRating: 3),


Product(productImage: "p4", productTitle: "Leather Sneakers", productPrice: "$230", productBG: Color("shoeBG4"),productRating: 4)


]
