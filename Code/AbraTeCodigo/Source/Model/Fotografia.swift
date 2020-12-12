//
//  Fotografia.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 24/10/20.
//

import Foundation

class Fotografia: ItemDigital {
    struct Tamanho {
        var largura: Float
        var altura: Float
    }
    
    let autor: String
    let tecnica: String
    let tamanho: Tamanho
    
    override var dados: [Dado] {
        [
            Dado(titulo: "Denominação", valor: denominacao.rawValue),
            Dado(titulo: "Técnina", valor: tecnica),
            Dado(titulo: "Autor", valor: autor),
            Dado(titulo: "Data de Produção", valor: data),
            Dado(titulo: "Local de Produção", valor: local),
            Dado(titulo: "Tamanho", valor: "\(tamanho.largura)cm x \(tamanho.altura)"),
        ]
    }
    
    internal init(fileName: String, denominacao: Denominacao, nome: String, descricao: String, local: String, data: String, autor: String, tecnica: String, tamanho: Fotografia.Tamanho, licenca: Licenca, instituicao: Instituicao, imagem: String) {
        self.autor = autor
        self.tecnica = tecnica
        self.tamanho = tamanho
        super.init(fileName: fileName, denominacao: denominacao, nome: nome, descricao: descricao, local: local, data: data, licenca: licenca, instituicao: instituicao, imagem: imagem)
    }
}
