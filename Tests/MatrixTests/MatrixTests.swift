//
//  MatrixTests.swift
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

final class MatrixTests: XCTestCase {
    
    // MARK: - Initialization
    
    func testEmptyInitialization() {
        let matrix = Matrix<Int>()
        
        XCTAssertEqual(matrix.rowCount, 0, "The matrix's row count is expected to be 0.")
        XCTAssertEqual(matrix.columnCount, 0, "The matrix's column count is expected to be 0.")
        XCTAssertEqual(matrix.data, [], "The matrix's data array is expected to be empty.")
    }
    
    func testRepeatingElementInitialization() {
        let matrix = Matrix(repeating: 1, rowCount: 2, columnCount: 2)
        
        XCTAssertEqual(matrix.rowCount, 2, "The matrix's row count is expected to be 2.")
        XCTAssertEqual(matrix.columnCount, 2, "The matrix's column count is expected to be 2.")
        XCTAssertEqual(matrix.data, [1, 1, 1, 1], "The matrix's data array is expected to contain four 1s.")
    }
    
    func test1DArrayInitialization() {
        let matrix = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        
        XCTAssertEqual(matrix.rowCount, 2, "The matrix's row count is expected to be 2.")
        XCTAssertEqual(matrix.columnCount, 2, "The matrix's column count is expected to be 2.")
        XCTAssertEqual(matrix.data, [1, 2, 3, 4], "The matrix's data array is expected to contain \"[1, 2, 3, 4]\".")
    }
    
    func test2DArrayInitialization() {
        let matrix = Matrix(elements: [[1, 2], [3, 4]])
        
        XCTAssertEqual(matrix.rowCount, 2, "The matrix's row count is expected to be 2.")
        XCTAssertEqual(matrix.columnCount, 2, "The matrix's column count is expected to be 2.")
        XCTAssertEqual(matrix.data, [1, 2, 3, 4], "The matrix's data array is expected to contain \"[1, 2, 3, 4]\".")
    }
    
    func testRepeatingElementWithDiagonalInitialization() {
        let matrix = Matrix(repeating: 0, diagonalElement: 1, rowCount: 3, columnCount: 3)
        
        XCTAssertEqual(matrix.rowCount, 3, "The matrix's row count is expected to be 3.")
        XCTAssertEqual(matrix.columnCount, 3, "The matrix's column count is expected to be 3.")
        XCTAssertEqual(matrix.data, [1, 0, 0, 0, 1, 0, 0, 0, 1], "The matrix's data array is expected to contain all zeros, except for the diagonal {0, 0}, {1, 1}, and {2, 2} which should be set to 1.")
    }
    
    // MARK: - Utilities
    
    func testIsSquare() {
        let matrix = Matrix(repeating: 0, diagonalElement: 1, rowCount: 3, columnCount: 3)
        XCTAssertTrue(matrix.isSquare, "The matrix is expected to be square.")
    }
    
    func testIsIndexValidByInteger() {
        let matrix = Matrix(elements: [[1, 2], [3, 4]])
        
        XCTAssertEqual(matrix.isIndexValid(row: 1, column: 0), true)
        XCTAssertEqual(matrix.isIndexValid(row: 0, column: 1), true)
        XCTAssertEqual(matrix.isIndexValid(row: 1, column: 3), false)
        XCTAssertEqual(matrix.isIndexValid(row: 3, column: 3), false)
    }
    
}
