//
//  Article.swift
//  GoodNews
//
//  Created by raul.santos on 23/01/23.
//

import Foundation

struct ArticlesList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
