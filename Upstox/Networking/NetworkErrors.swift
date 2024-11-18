//
//  NetworkErrors.swift
//  Upstox
//
//  Created by MacBook on 15/11/24.
//

import Foundation

enum NetworkErrors: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case serverError(String)
}
