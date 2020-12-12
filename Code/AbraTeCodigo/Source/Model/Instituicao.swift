//
//  Instituicao.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 24/10/20.
//

import Foundation

struct Instituicao: Equatable {
    enum Categoria { case museu }
    
    let nome: String
    let logo: String
    let fotoCapa: String
    let categoria: Categoria
    var resumo: String = ""
    
    static func == (lhs: Instituicao, rhs: Instituicao) -> Bool {
        lhs.nome == rhs.nome
    }
}
