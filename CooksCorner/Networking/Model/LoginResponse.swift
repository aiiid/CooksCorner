//
//  LoginResponse.swift
//  CooksCorner
//
//  Created by Ai Hawok on 19/07/2024.
//

import Foundation

struct LoginResponse: Decodable {
    let email: String
    let accessToken: String
    let refreshToken: String
}

struct ErrorResponse: Decodable {
    let statusCode: Int
    let message: String
}
