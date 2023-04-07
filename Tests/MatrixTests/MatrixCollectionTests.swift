//
//  MatrixCollectionTests.swift
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

final class MatrixCollectionTests: XCTestCase {
    
    // MARK: - Initialization
    
    func testStartIndex() {
        let matrix = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        
        XCTAssertEqual(matrix.startIndex.row, 0, "The row of the start index expected to be 0.")
        XCTAssertEqual(matrix.startIndex.column, 0, "The column of the start index expected to be 0.")
    }
    
    func testEndIndex() {
        let matrix = Matrix(elements: [1, 2, 3, 4, 5, 6], rowCount: 3, columnCount: 2)
        
        XCTAssertEqual(matrix.endIndex.row, 2, "The row of the end index expected to be 2.")
        XCTAssertEqual(matrix.endIndex.column, 1, "The column of the end index expected to be 1.")
    }
    
    func testRandomIndex() {
        let matrix = Matrix(elements: [1, 2, 3, 4, 5, 6], rowCount: 3, columnCount: 2)
        XCTAssertNotNil(matrix.randomIndex(), "The index is expected to exist.")
        XCTAssertNil(Matrix<Int>().randomIndex(), "The index is expected to be nil.")
    }
    
    func testIndexAfter() {
        let matrix = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        let startIndex = matrix.startIndex
        var nextIndex = matrix.index(after: startIndex)
        
        XCTAssertEqual(nextIndex.row, 0, "The row of the index expected to be 0.")
        XCTAssertEqual(nextIndex.column, 1, "The column of the index expected to be 1.")
        
        nextIndex = matrix.index(after: nextIndex)
        XCTAssertEqual(nextIndex.row, 1, "The row of the index expected to be 0.")
        XCTAssertEqual(nextIndex.column, 0, "The column of the index expected to be 1.")
    }
    
    func testIndexSubscript() {
        var matrix = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        XCTAssertEqual(matrix[Matrix<Int>.Index(row: 0, column: 1)], 2, "The value at {0, 1} is expected to be 2.")
        
        matrix[Matrix<Int>.Index(row: 0, column: 1)] = 5
        XCTAssertEqual(matrix[Matrix<Int>.Index(row: 0, column: 1)], 5, "The value at {0, 1} is expected to be 5.")
    }
    
    func testRowColumnSubscript() {
        var matrix = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        XCTAssertEqual(matrix[0, 1], 2, "The value at {0, 1} is expected to be 2.")
        
        matrix[0, 1] = 5
        XCTAssertEqual(matrix[0, 1], 5, "The value at {0, 1} is expected to be 5.")
    }
    
    func testIndexBefore() {
        let matrix = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        let endIndex = matrix.endIndex
        var nextIndex = matrix.index(before: endIndex)
        
        XCTAssertEqual(nextIndex.row, 1, "The row of the index expected to be 1.")
        XCTAssertEqual(nextIndex.column, 0, "The column of the index expected to be 0.")
        
        nextIndex = matrix.index(before: nextIndex)
        XCTAssertEqual(nextIndex.row, 0, "The row of the index expected to be 0.")
        XCTAssertEqual(nextIndex.column, 1, "The column of the index expected to be 1.")
    }
    
    func testReplaceSubrange() {
        var matrix = Matrix(elements: [1, 2, 3, 4, 5, 6], rowCount: 3, columnCount: 2)
        matrix.replaceSubrange(
            MatrixIndex(row: 1, column: 0)..<MatrixIndex(row: 2, column: 0),
            with: [7, 8]
        )
        XCTAssertEqual(matrix, Matrix(elements: [1, 2, 7, 8, 5, 6], rowCount: 3, columnCount: 2), "The updated matrix does not match the expected value.")
    }
    
}
