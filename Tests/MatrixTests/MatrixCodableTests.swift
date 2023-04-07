//
//  MatrixCodableTests.swift
//  MatrixTests
//
//  Created by Solar Design System on 4/5/23.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2023 Solar Design System
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import XCTest
@testable import Matrix

final class MatrixCodableTests: XCTestCase {
    
    // MARK: - Initialization
    
    func testEncode() throws {
        let matrix = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        let encoder = JSONEncoder()
        
        let jsonData = try encoder.encode(matrix)
        let jsonString = String(data: jsonData, encoding: .utf8)
        XCTAssertEqual(jsonString, "[[1,2],[3,4]]", "The output JSON does not match the expected value.")
    }
    
    func testDecode() throws {
        let jsonString = "[[1,2],[3,4]]"
        let jsonData = jsonString.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let matrix = try decoder.decode(Matrix<Int>.self, from: jsonData)
        
        XCTAssertEqual(matrix, Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2), "The decoded matrix does not match the expected value.")
    }
    
}
