//
//  ListRowViewBook.swift
//  Task
//
//  Created by Vika Granadzer on 03.10.2022.
//

import SwiftUI

struct ListRowViewBook: View {
    var book: Book
    var body: some View {
        HStack{
            Text(book.Name)
            NavigationLink("", destination: BookView(book: book))
        }
    }
}

struct ListRowViewBook_Previews: PreviewProvider {
    static var book1 = Book()
    static var previews: some View {
        Group{
            ListRowViewBook(book: book1)
        }
    }
}
