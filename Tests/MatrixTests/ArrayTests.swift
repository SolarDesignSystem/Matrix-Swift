//
//  ArrayTests.swift
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

final class ArrayTests: XCTestCase {
    
    // MARK: - Initialization
    
    func testMatrixArrayInitialization() {
        let matrix = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        
        let matrixArray = Array(matrix: matrix)
        
        XCTAssertEqual(matrixArray.count, 2, "The array's count is expected to be 2.")
        XCTAssertEqual(matrixArray[0].count, 2, "The first element's count is expected to be 2.")
        XCTAssertEqual(matrixArray[1].count, 2, "The second element's count is expected to be 2.")
        XCTAssertEqual(matrixArray, [[1, 2], [3, 4]], "The array is expected to contain \"[[1, 2], [3, 4]]\".")
    }
    
    func testMatrixSequenceInitialization() {
        let matrix = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        
        let matrixArray = Array(matrix)
        
        XCTAssertEqual(matrixArray.count, 4, "The array's count is expected to be 4.")
        XCTAssertEqual(matrixArray, [1, 2, 3, 4], "The array is expected to contain \"[1, 2, 3, 4]\".")
    }
    
}
