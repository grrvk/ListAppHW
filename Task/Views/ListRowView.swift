//
//  ListRowView.swift
//  Task
//
//  Created by Vika Granadzer on 03.10.2022.
//

import SwiftUI

struct ListRowView: View {
    @EnvironmentObject var listM: ListViewModel
    var item: ItemModel
    var body: some View {
        HStack{
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var item1 = ItemModel()
    static var previews: some View {
        Group{
            ListRowView(item: item1)
        }
    }
}
