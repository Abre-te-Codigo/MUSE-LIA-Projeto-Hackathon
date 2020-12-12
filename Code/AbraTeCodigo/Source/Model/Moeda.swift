//
//  Moeda.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 24/10/20.
//

import Foundation

class Moeda: ItemDigital {
    let tecnica: String
    let material: String
    let governante: String
    let diametro: Float
    
    override var dados: [Dado] {
        [
            Dado(titulo: "Denominação", valor: denominacao.rawValue),
            Dado(titulo: "Técnina", valor: tecnica),
            Dado(titulo: "Data de Produção", valor: data),
            Dado(titulo: "Local de Produção", valor: local),
            Dado(titulo: "Diâmetro", valor: String(format: "%.1fmm", diametro)),
            Dado(titulo: "Materiais", valor: material),
            Dado(titulo: "Governante", valor: governante),
        ]
    }
    
    internal init(fileName: String, nome: String, descricao: String, local: String, data: String, tecnica: String, material: String, governante: String, diametro: Float, licenca: Licenca, instituicao: Instituicao, imagem: String? = nil) {
        self.tecnica = tecnica
        self.material = material
        self.governante = governante
        self.diametro = diametro
        super.init(fileName: fileName, denominacao: .moeda, nome: nome, descricao: descricao, local: local, data: data, licenca: licenca, instituicao: instituicao, imagem: imagem)
    }
}
