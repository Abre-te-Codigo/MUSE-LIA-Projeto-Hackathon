//
//  ItemDigital.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 24/10/20.
//

import Foundation

struct Licenca {
    var name: String
    var logo: String
    
    static let cc = Licenca(name: "Creative Commons", logo: "licenca_cc")
}

enum Denominacao: String {
    case moeda = "Moeda"
    case pinturaDocumental = "Pintura Documental"
    case pinturaPaisagem = "Paisagem (Pintura)"
}

class ItemDigital {
    struct Dado: Identifiable {
        var id: String { titulo }
        var titulo: String
        var valor: String
    }
    
    var fileName: String
    var denominacao: Denominacao
    var nome: String
    var descricao: String
    var local: String
    var data: String
    var imagem: String?
    
    var licenca: Licenca
    var instituicao: Instituicao
    
    var dados: [Dado] { [] }
    
    internal init(fileName: String, denominacao: Denominacao, nome: String, descricao: String, local: String, data: String, licenca: Licenca, instituicao: Instituicao, imagem: String? = nil) {
        self.fileName = fileName
        self.denominacao = denominacao
        self.nome = nome
        self.descricao = descricao
        self.local = local
        self.data = data
        self.licenca = licenca
        self.instituicao = instituicao
        self.imagem = imagem
    }
}
