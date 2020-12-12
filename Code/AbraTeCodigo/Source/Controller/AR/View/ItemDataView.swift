//
//  ItemDataView.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 25/10/20.
//

import SwiftUI

struct ItemDadoCell: View {
    var dado: ItemDigital.Dado
    var colorScheme: ColorScheme
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dado.titulo)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
                Text(dado.valor)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(colorScheme == .light ? .black : .white)
                Spacer()
            }
            Spacer()
        }
    }
}

struct ItemDataView: View {
    var item: ItemDigital
    var colorScheme: ColorScheme
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 10) {
            ForEach(item.dados) { dado in
                ItemDadoCell(dado: dado, colorScheme: colorScheme)
            }
        }.background(Color.clear)
    }
}

struct ItemDataView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ItemDataView(item: Acervo.shared.itens[0], colorScheme: .light)
            ItemDataView(item: Acervo.shared.itens[0], colorScheme: .dark)
                .background(Color.blue)
        }
        .previewLayout(.sizeThatFits)
    }
}
