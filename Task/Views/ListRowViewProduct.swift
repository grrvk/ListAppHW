//
//  ListRowViewProduct.swift
//  Task
//
//  Created by Vika Granadzer on 03.10.2022.
//

import SwiftUI

struct ListRowViewProduct: View {
    var product: Product
    var body: some View {
        HStack{
            Text(product.Name)
            NavigationLink("", destination: ProductView(product: product))
        }
    }
}

struct ListRowViewProduct_Previews: PreviewProvider {
    static var product1 = Product()
    static var previews: some View {
        Group{
            ListRowViewProduct(product: product1)
        }
    }
}
