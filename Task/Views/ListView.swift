//
//  ListView.swift
//  Task
//
//  Created by Vika Granadzer on 03.10.2022.
//

import SwiftUI

struct ListView: View {
    let listViewModel = ListViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var showingAlert = false
    @State var textFieldtext: String = ""
    @State var selectedType: Int = 0
    var body: some View {
        VStack{
            VStack{
                TextField("Type smth", text: $textFieldtext)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                    .cornerRadius(10)
                HStack{
                    Picker("Item: ", selection: $selectedType, content: {
                        Text("None").tag(0)
                        Text("Product").tag(1)
                        Text("Book").tag(2)
                    })
                }
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
            VStack{
                Text("List of products")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(14)
                List{
                    ForEach(listViewModel.products) {
                        item in ListRowViewProduct(product: item)
                            }
                    .onDelete(perform: listViewModel.deleteItem)
                }
            }
            Spacer()
            VStack{
                Text("List of books")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(14)
                List{
                    ForEach(listViewModel.books) { item in
                        ListRowViewBook(book: item)
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                }
            }
            .navigationTitle("List")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Invalid type"), message: Text("Type must be Product or Book"), dismissButton: .default(Text("Got it!")))
            }
        }
    }
    func saveButtonPressed(){
        do{
            try checkPicker()
            listViewModel.addItem(name: textFieldtext, type: selectedType)
            textFieldtext = "";
        } catch PickerError.invalidType{
            showingAlert = true
        } catch is Error{
            showingAlert = true
        }
    }
    enum PickerError: Error{
        case invalidType
    }
    func checkPicker() throws{
        if (selectedType == 0){
            throw PickerError.invalidType
        }
    }
}

class ListViewModel: ObservableObject{
    @Published var items: [ItemModel] = []
    @Published var products: [Product] = []
    @Published var books: [Book] = []
    init(){
        getItems()
    }
    func getItems(){
        let newItems = [ItemModel()]
        items.append(contentsOf: newItems)
    }
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    func addItem(name: String, type: Int){
        if (type == 1){
            let product = Product()
            product.setBaseInfo(name: name, type: type)
            products.append(product)
        }
        if (type == 2){
            let book = Book()
            book.setBaseInfo(name: name, type: type)
            books.append(book)
        }
        
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
            }
        }
        
    }
