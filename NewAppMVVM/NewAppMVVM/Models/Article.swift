//
//  Article.swift
//  NewAppMVVM
//
//  Created by raul.santos on 07/02/23.
//

import Foundation


struct ArticleRespose: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
    
}
